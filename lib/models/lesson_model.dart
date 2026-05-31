import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/quiz_question.dart';

class Lesson {
  final String id;
  final String moduleId;
  final String title;
  final String type;
  final String content;
  final int order;
  final List<QuizQuestion> quizQuestions;
  final String? audioUrl;

  Lesson({
    required this.id,
    required this.moduleId,
    required this.title,
    required this.type, // e.g., 'quiz', 'reading', 'video'
    required this.content,
    required this.order,
    this.quizQuestions = const [],
    this.audioUrl,
  });

  factory Lesson.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Lesson(
      id: doc.id,
      moduleId: data['moduleId'] ?? '',
      title: data['title'] ?? '',
      type: data['type'] ?? 'reading',
      content: data['content'] ?? '',
      order: data['order'] ?? 0,
      quizQuestions: [],
      audioUrl: data['audioUrl'],
    );
  }
}
