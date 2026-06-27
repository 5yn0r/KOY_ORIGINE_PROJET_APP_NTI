import 'dart:developer' as developer;

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:myapp/data/baoulé_learning_data.dart';
import 'package:myapp/services/baoule_knowledge_service.dart';

/// Service pour interagir avec l'API Gemini de Google
class GeminiService {
  late GenerativeModel _model;
  late ChatSession _chatSession;
  late String _currentApiKey;
  final BaouleKnowledgeService _knowledgeService = BaouleKnowledgeService();

  static const String _apiKey = 'VOTRE_CLE_API_GEMINI';
  static const String _primaryModelName = 'votre_model_gemini_principal';
  static const String _fallbackModelName = 'votre_model_gemini_fallback';
  GeminiService() {
    _initialize(_apiKey, _primaryModelName);
  }

  /// Initialise le service avec une clé API personnalisée
  /// Utile si vous stockez la clé dans les variables d'environnement ou en toute sécurité
  GeminiService.withApiKey(String apiKey) {
    _initialize(apiKey, _primaryModelName);
  }

  void _initialize(String apiKey, String modelName) {
    _currentApiKey = apiKey;
    _model = GenerativeModel(
      model: modelName,
      apiKey: apiKey,
      systemInstruction: Content.system(BaouleLearningData.getSystemPrompt()),
    );
    _chatSession = _model.startChat();
  }

  /// Envoie un message à Gemini et reçoit une réponse
  ///
  /// [userMessage] - Le message de l'utilisateur en francais ou baoulé
  /// Retourne la réponse générée par Gemini
  Future<String> sendMessage(String userMessage) async {
    try {
      final groundedMessage = _buildGroundedMessage(userMessage);
      final response = await _chatSession.sendMessage(
        Content.text(groundedMessage),
      );

      if (response.text != null && response.text!.isNotEmpty) {
        return _cleanPlainText(response.text!);
      }

      return 'Je n\'ai pas pu générer une réponse. Veuillez réessayer.';
    } catch (e) {
      developer.log(
        'Erreur lors de l\'appel à Gemini',
        name: 'gemini.service',
        error: e,
      );
      if (e.toString().contains('is not found') ||
          e.toString().contains('not supported')) {
        return _retryWithFallbackModel(_buildGroundedMessage(userMessage));
      }
      return 'Une erreur s\'est produite: $e';
    }
  }

  String _buildGroundedMessage(String userMessage) {
    final localContext = _knowledgeService.buildContextForQuestion(userMessage);
    return '''
Question utilisateur:
$userMessage

Donnees locales autorisees:
$localContext

Consignes de reponse:
- Reponds uniquement avec les donnees locales autorisees ci-dessus.
- Si les donnees locales ne suffisent pas, dis clairement: "Je ne trouve pas encore de réponse. Veuillez essayer plus tard. Nous travaillons à enrichir notre base de connaissances."
- Ne complete pas avec des connaissances generales ou internet.
- Si plusieurs variantes existent, cite les variantes et explique que le baoule peut varier selon la prononciation.
- Reponds en francais simple, sans Markdown, sans gras, sans astérisques.
''';
  }

  Future<String> _retryWithFallbackModel(String userMessage) async {
    try {
      _initialize(_currentApiKey, _fallbackModelName);
      final response = await _chatSession.sendMessage(
        Content.text(userMessage),
      );

      if (response.text != null && response.text!.isNotEmpty) {
        return _cleanPlainText(response.text!);
      }

      return 'Je n\'ai pas pu générer une réponse. Veuillez réessayer.';
    } catch (e) {
      developer.log(
        'Erreur lors du fallback Gemini',
        name: 'gemini.service',
        error: e,
      );
      return 'Gemini ne répond pas pour le moment. Vérifiez la clé API et le modèle configuré.';
    }
  }

  String _cleanPlainText(String text) {
    return text
        .replaceAllMapped(RegExp(r'\*\*(.*?)\*\*'), (match) => match.group(1)!)
        .replaceAllMapped(RegExp(r'__(.*?)__'), (match) => match.group(1)!)
        .replaceAllMapped(RegExp(r'\*(.*?)\*'), (match) => match.group(1)!)
        .replaceAllMapped(RegExp(r'_(.*?)_'), (match) => match.group(1)!)
        .replaceAll('*', '');
  }

  /// Remet à zéro la conversation
  void resetChat() {
    _chatSession = _model.startChat();
  }

  /// Réinitialise le service avec une nouvelle clé API
  void reinitializeWithApiKey(String apiKey) {
    _initialize(apiKey, _primaryModelName);
  }
}
