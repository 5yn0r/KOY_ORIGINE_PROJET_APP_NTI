import 'package:myapp/models/learning_models.dart';

class LearningService {
  // Données factices pour les modules
  final List<LearningModule> _modules = [
    // --- Modules Débutant ---
    LearningModule(
      id: 'd1',
      title: 'Les salutations de base',
      level: 'Débutant',
      lessons: [
        Lesson(
          id: 'd1_l1',
          title: 'Dire bonjour et au revoir',
          content: 'Apprenez les formes courantes de salutation en Baoulé.',
          quiz: [
            QuizQuestion(
              question: 'Que signifie "Agniho" ?',
              options: ['Bonjour', 'Au revoir', 'Merci', 'S\'il vous plaît'],
              correctAnswerIndex: 0,
            ),
            // ... autres questions
          ],
        ),
      ],
    ),
    LearningModule(
      id: 'd2',
      title: 'Se présenter',
      level: 'Débutant',
      lessons: [],
    ),

    // --- Modules Intermédiaire ---
    LearningModule(
      id: 'i1',
      title: 'La nourriture et les repas',
      level: 'Intermédiaire',
      lessons: [],
    ),

    // --- Modules Avancé ---
    LearningModule(
      id: 'a1',
      title: 'Les proverbes Baoulé',
      level: 'Avancé',
      lessons: [],
    ),
  ];

  // Récupérer tous les modules pour un niveau donné
  Future<List<LearningModule>> getModulesByLevel(String level) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simuler un appel réseau
    return _modules.where((module) => module.level == level).toList();
  }

  // Récupérer un module par son ID
  Future<LearningModule?> getModuleById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _modules.firstWhere((module) => module.id == id);
  }
}
