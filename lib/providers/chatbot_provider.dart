import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/chatbot_message.dart';
import 'package:myapp/services/gemini_service.dart';
import 'package:uuid/uuid.dart';

/// Provider pour gérer l'état et la logique du chatbot N'ti IA
class ChatbotProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late GeminiService _geminiService;

  List<ChatbotMessage> _messages = [];
  bool _isLoading = false;
  String? _currentUserId;
  String? _error;

  // Getters
  List<ChatbotMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ChatbotProvider({String? geminiApiKey}) {
    // Initialiser le service Gemini
    if (geminiApiKey != null && geminiApiKey.isNotEmpty) {
      _geminiService = GeminiService.withApiKey(geminiApiKey);
    } else {
      _geminiService = GeminiService();
    }

    // Ajouter un message initial du bot
    _initializeChat();
  }

  /// Initialise la conversation avec un message de bienvenue
  void _initializeChat() {
    _messages = [
      ChatbotMessage(
        id: const Uuid().v4(),
        userId: 'system',
        text:
            'Akwaaba ! 👋 Je suis N\'ti, votre assistant IA pour l\'apprentissage du Baoulé. '
            'Vous pouvez me poser des questions en français ou en baoulé, et je vous aiderai à:\n'
            '• Apprendre du vocabulaire\n'
            '• Comprendre la grammaire\n'
            '• Découvrir la culture baoulé\n'
            '• Traduire des mots ou phrases\n\n'
            'Par quoi commençons-nous ? 😊',
        sender: 'bot',
        timestamp: DateTime.now(),
        language: 'fr',
        type: 'welcome',
      ),
    ];
    notifyListeners();
  }

  /// Définit l'ID utilisateur actuel
  void setCurrentUserId(String userId) {
    _currentUserId = userId;
  }

  /// Charge l'historique des messages depuis Firestore
  Future<void> loadChatHistory(String userId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final snapshot = await _firestore
          .collection('chatbot_conversations')
          .doc(userId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(50)
          .get();

      final loadedMessages = snapshot.docs
          .map((doc) => ChatbotMessage.fromFirestore(doc))
          .toList()
          .reversed
          .toList();
      if (loadedMessages.isEmpty) {
        _initializeChat();
      } else {
        _messages = loadedMessages;
      }

      _error = null;
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        _error = null;
        print(
          'Historique chatbot non chargé: permissions Firestore insuffisantes.',
        );
      } else {
        _error = 'Erreur lors du chargement: $e';
        print('Erreur: $_error');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Envoie un message à N'ti IA et obtient une réponse
  Future<void> sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    try {
      _error = null;
      _isLoading = true;

      // Créer et ajouter le message utilisateur
      final userMsg = ChatbotMessage(
        id: const Uuid().v4(),
        userId: _currentUserId ?? 'anonymous',
        text: userMessage,
        sender: 'user',
        timestamp: DateTime.now(),
        type: 'text',
      );

      _messages.add(userMsg);
      notifyListeners();

      // Tenter de sauvegarder dans Firestore si l'utilisateur est authentifié
      if (_currentUserId != null) {
        await _saveMessageToFirestore(userMsg);
      } else {
        print(
          'Utilisateur non authentifié - Message sauvegardé localement uniquement',
        );
      }

      // Obtenir la réponse de Gemini
      final response = await _geminiService.sendMessage(userMessage);

      // Créer et ajouter le message du bot
      final botMsg = ChatbotMessage(
        id: const Uuid().v4(),
        userId: _currentUserId ?? 'anonymous',
        text: response,
        sender: 'bot',
        timestamp: DateTime.now(),
        type: 'response',
      );

      _messages.add(botMsg);

      // Tenter de sauvegarder dans Firestore si l'utilisateur est authentifié
      if (_currentUserId != null) {
        await _saveMessageToFirestore(botMsg);
      }

      _isLoading = false;
    } catch (e) {
      _error = 'Erreur: $e';
      print('Erreur lors de l\'envoi: $_error');
      _isLoading = false;
    }

    notifyListeners();
  }

  /// Sauvegarde un message dans Firestore
  Future<void> _saveMessageToFirestore(ChatbotMessage message) async {
    try {
      await _firestore
          .collection('chatbot_conversations')
          .doc(_currentUserId)
          .collection('messages')
          .doc(message.id)
          .set(message.toFirestore());
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        print(
          'Message chatbot gardé localement: permissions Firestore insuffisantes.',
        );
      } else {
        print('Erreur lors de la sauvegarde Firestore: $e');
      }
    }
  }

  /// Efface tout l'historique de conversation
  Future<void> clearConversation() async {
    if (_currentUserId == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      // Supprimer tous les messages de Firestore
      final snapshot = await _firestore
          .collection('chatbot_conversations')
          .doc(_currentUserId)
          .collection('messages')
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      // Réinitialiser le chat localement
      _initializeChat();
      _geminiService.resetChat();

      _error = null;
      _isLoading = false;
    } catch (e) {
      _error = 'Erreur lors de l\'effacement: $e';
      _isLoading = false;
    }

    notifyListeners();
  }

  /// Met à jour la clé API Gemini (utile pour les tests ou l'administration)
  void updateGeminiApiKey(String newApiKey) {
    _geminiService.reinitializeWithApiKey(newApiKey);
  }

  /// Réinitialise le provider
  @override
  void dispose() {
    _messages.clear();
    super.dispose();
  }
}
