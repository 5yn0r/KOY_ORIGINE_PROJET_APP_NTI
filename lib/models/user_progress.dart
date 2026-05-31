import 'package:cloud_firestore/cloud_firestore.dart';

class UserProgress {
  final String userId;
  // Liste des IDs des leçons terminées
  final List<String> completedLessons;
  // Map des scores des quiz, avec l'ID du quiz comme clé et le score comme valeur
  final Map<String, int> quizScores;

  UserProgress({
    required this.userId,
    this.completedLessons = const [],
    this.quizScores = const {},
  });

  // Convertir un document Firestore en objet UserProgress
  factory UserProgress.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserProgress(
      userId: doc.id,
      completedLessons: List<String>.from(data['completedLessons'] ?? []),
      // Les clés de la map Firestore doivent être des String
      quizScores: Map<String, int>.from(data['quizScores'] ?? {}),
    );
  }

  // Convertir un objet UserProgress en une map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {'completedLessons': completedLessons, 'quizScores': quizScores};
  }
}
