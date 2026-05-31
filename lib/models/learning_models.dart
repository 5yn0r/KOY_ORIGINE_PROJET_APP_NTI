// Classe représentant un module d'apprentissage
class LearningModule {
  final String id;
  final String title;
  final String level; // 'Débutant', 'Intermédiaire', 'Avancé'
  final List<Lesson> lessons;

  LearningModule({
    required this.id,
    required this.title,
    required this.level,
    required this.lessons,
  });

  String? get description => null;
}

// Classe représentant une leçon
class Lesson {
  final String id;
  final String title;
  final String content; // Contenu de la leçon (texte, etc.)
  final List<QuizQuestion> quiz;

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.quiz,
  });
}

// Classe représentant une question de quiz
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}
