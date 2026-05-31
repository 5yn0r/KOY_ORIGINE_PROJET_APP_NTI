import 'package:cloud_firestore/cloud_firestore.dart';

/// Représente un message dans le chat du chatbot N'ti IA
class ChatbotMessage {
  final String id;
  final String userId;
  final String text;
  final String sender; // 'user' ou 'bot'
  final DateTime timestamp;
  final String? language; // 'fr', 'baoulé', 'auto'
  final String? originalText; // Texte original si traduction
  final bool isTranslated;
  final String? type; // 'text', 'translation', 'explanation', 'example'

  ChatbotMessage({
    required this.id,
    required this.userId,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.language,
    this.originalText,
    this.isTranslated = false,
    this.type = 'text',
  });

  /// Crée un ChatbotMessage à partir d'un document Firestore
  factory ChatbotMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatbotMessage(
      id: doc.id,
      userId: data['userId'] ?? '',
      text: data['text'] ?? '',
      sender: data['sender'] ?? 'user',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      language: data['language'],
      originalText: data['originalText'],
      isTranslated: data['isTranslated'] ?? false,
      type: data['type'],
    );
  }

  /// Convertit le message en un Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'text': text,
      'sender': sender,
      'timestamp': Timestamp.fromDate(timestamp),
      'language': language,
      'originalText': originalText,
      'isTranslated': isTranslated,
      'type': type,
    };
  }

  /// Crée une copie du message avec certains paramètres modifiés
  ChatbotMessage copyWith({
    String? id,
    String? userId,
    String? text,
    String? sender,
    DateTime? timestamp,
    String? language,
    String? originalText,
    bool? isTranslated,
    String? type,
  }) {
    return ChatbotMessage(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      text: text ?? this.text,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      language: language ?? this.language,
      originalText: originalText ?? this.originalText,
      isTranslated: isTranslated ?? this.isTranslated,
      type: type ?? this.type,
    );
  }
}
