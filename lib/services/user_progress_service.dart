import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/user_progress.dart';
import 'dart:developer' as developer;

class UserProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _progressCollection;

  UserProgressService() {
    _progressCollection = _firestore.collection('userProgress');
  }

  // Récupérer la progression d'un utilisateur
  Future<UserProgress?> getUserProgress(String userId) async {
    try {
      final doc = await _progressCollection.doc(userId).get();
      if (doc.exists) {
        return UserProgress.fromFirestore(doc);
      }
      return null; // Pas de progression trouvée pour cet utilisateur
    } catch (e, s) {
      developer.log(
        'Erreur lors de la récupération de la progression',
        name: 'user_progress.service',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  // Marquer une leçon comme terminée pour un utilisateur
  Future<void> completeLesson(String userId, String lessonId) async {
    try {
      await _progressCollection.doc(userId).set({
        'completedLessons': FieldValue.arrayUnion([lessonId]),
      }, SetOptions(merge: true));
    } catch (e, s) {
      developer.log(
        'Erreur lors de la mise à jour de la leçon terminée',
        name: 'user_progress.service',
        error: e,
        stackTrace: s,
      );
    }
  }

  // Enregistrer le score d'un quiz pour un utilisateur
  Future<void> saveQuizScore(String userId, String quizId, int score) async {
    try {
      // Utiliser la notation par points pour mettre à jour un champ spécifique dans une map
      await _progressCollection.doc(userId).set({
        'quizScores': {quizId: score},
      }, SetOptions(merge: true));
    } catch (e, s) {
      developer.log(
        'Erreur lors de l\'enregistrement du score du quiz',
        name: 'user_progress.service',
        error: e,
        stackTrace: s,
      );
    }
  }
}
