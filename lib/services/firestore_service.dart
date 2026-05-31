import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/data/all_lessons.dart';
import 'package:myapp/models/lesson_history.dart';
import 'package:myapp/screens/peer_to_peer/user_list_screen.dart'; // Importer P2PUser
import 'package:myapp/screens/peer_to_peer/chat_screen.dart'; // Importer ChatMessage

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const int totalLearningModules = 18;

  // ... (fonctions existantes getUserProgress, updateUserProgress, etc.)
  // --- Gestion de la Progression ---

  // Récupérer les données de progression d'un utilisateur
  Future<Map<String, dynamic>?> getUserProgress() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final docRef = _db.collection('user_progress').doc(user.uid);
    final doc = await docRef.get();

    if (doc.exists) {
      final data = doc.data() ?? {};
      if (data['totalModules'] != totalLearningModules ||
          data['completedModules'] == null ||
          data['moduleQuizResults'] == null) {
        final modulesCompleted = ((data['modulesCompleted'] ?? 0) as num)
            .toInt();
        await docRef.set({
          'totalModules': totalLearningModules,
          'overallProgress': modulesCompleted / totalLearningModules,
          'completedModules': data['completedModules'] ?? <String>[],
          'moduleQuizResults': data['moduleQuizResults'] ?? <String, dynamic>{},
        }, SetOptions(merge: true));
        return {
          ...data,
          'totalModules': totalLearningModules,
          'overallProgress': modulesCompleted / totalLearningModules,
          'completedModules': data['completedModules'] ?? <String>[],
          'moduleQuizResults': data['moduleQuizResults'] ?? <String, dynamic>{},
        };
      }
      return data;
    } else {
      // Si aucune progression n'existe, en créer une par défaut
      final defaultProgress = {
        'overallProgress': 0.0,
        'modulesCompleted': 0,
        'totalModules': totalLearningModules,
        'averageScore': 0.0,
        'completedModules': <String>[],
        'moduleQuizResults': <String, dynamic>{},
      };
      await docRef.set(defaultProgress);
      return defaultProgress;
    }
  }

  // Mettre à jour la progression
  Future<void> updateUserProgress(Map<String, dynamic> progressData) async {
    final user = _auth.currentUser;
    if (user == null) return;
    await _db.collection('user_progress').doc(user.uid).update(progressData);
  }

  Stream<List<String>> getCompletedModulesStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _db.collection('user_progress').doc(user.uid).snapshots().map((doc) {
      final data = doc.data() ?? {};
      return List<String>.from(data['completedModules'] ?? []);
    });
  }

  Future<ModuleValidationResult> recordQuizResult({
    required String moduleId,
    required String quizId,
    required String quizName,
    required int score,
    required int totalQuestions,
  }) async {
    final user = _auth.currentUser;
    if (user == null || totalQuestions == 0) {
      return const ModuleValidationResult(
        quizPassed: false,
        moduleValidated: false,
        newlyValidated: false,
      );
    }

    final progressRef = _db.collection('user_progress').doc(user.uid);
    final progressDoc = await progressRef.get();
    if (!progressDoc.exists) {
      await getUserProgress();
    }

    final currentProgressDoc = await progressRef.get();
    final data = currentProgressDoc.data() ?? {};
    final completedModules = List<String>.from(data['completedModules'] ?? []);
    final moduleQuizResults = Map<String, dynamic>.from(
      data['moduleQuizResults'] ?? {},
    );
    final currentModuleResults = Map<String, dynamic>.from(
      moduleQuizResults[moduleId] ?? {},
    );

    final quizPassed = score * 2 >= totalQuestions;
    currentModuleResults[quizId] = {
      'quizName': quizName,
      'score': score,
      'totalQuestions': totalQuestions,
      'passed': quizPassed,
      'updatedAt': Timestamp.now(),
    };

    final moduleQuizIds = (allLessons[moduleId] ?? [])
        .where((lesson) => lesson.type == 'quiz')
        .map((lesson) => lesson.id)
        .toList();

    final moduleValidated =
        moduleQuizIds.isNotEmpty &&
        moduleQuizIds.every((id) {
          final result = currentModuleResults[id];
          return result is Map && result['passed'] == true;
        });
    final newlyValidated =
        moduleValidated && !completedModules.contains(moduleId);

    final currentAverage = ((data['averageScore'] ?? 0.0) as num).toDouble();
    final currentCompleted = ((data['modulesCompleted'] ?? 0) as num).toInt();
    final quizScorePercent = (score / totalQuestions) * 100;
    final nextCompleted = newlyValidated
        ? currentCompleted + 1
        : currentCompleted;
    final nextAverage = newlyValidated
        ? (currentAverage * currentCompleted + quizScorePercent) / nextCompleted
        : currentAverage;

    await progressRef.set({
      'totalModules': totalLearningModules,
      'moduleQuizResults': {moduleId: currentModuleResults},
      if (newlyValidated) 'completedModules': FieldValue.arrayUnion([moduleId]),
      if (newlyValidated) 'modulesCompleted': nextCompleted,
      if (newlyValidated) 'averageScore': nextAverage,
      if (newlyValidated)
        'overallProgress': nextCompleted / totalLearningModules,
    }, SetOptions(merge: true));

    if (newlyValidated) {
      await addLessonToHistory('Module validé', moduleId);
      // Vérifier et mettre à jour le niveau si nécessaire
      await _checkAndUpdateLevel(user.uid);
    }

    return ModuleValidationResult(
      quizPassed: quizPassed,
      moduleValidated: moduleValidated,
      newlyValidated: newlyValidated,
    );
  }

  // Vérifier et mettre à jour le niveau de l'utilisateur
  Future<void> _checkAndUpdateLevel(String userId) async {
    try {
      final userDoc = await _db.collection('users').doc(userId).get();
      final userData = userDoc.data() ?? {};
      final currentLevel = userData['level'] ?? 'Débutant';

      final progressDoc = await _db
          .collection('user_progress')
          .doc(userId)
          .get();
      final progressData = progressDoc.data() ?? {};
      final completedModules = List<String>.from(
        progressData['completedModules'] ?? [],
      );

      // Compter les modules validés pour chaque niveau
      final debutantModules = [
        'm01_phonetique',
        'm02_salutations',
        'm03_nombres',
        'm04_famille',
        'm05_nature',
        'm06_cuisine',
      ];
      final intermediaireModules = [
        'm07_grammaire',
        'm08_quotidien',
        'm09_interactions',
        'm10_proverbes',
        'm11_verbes',
        'm12_communication',
      ];

      final debutantCompleted = debutantModules
          .where((m) => completedModules.contains(m))
          .length;
      final intermediaireCompleted = intermediaireModules
          .where((m) => completedModules.contains(m))
          .length;

      String newLevel = currentLevel;

      // Vérifier et mettre à jour le niveau
      if (currentLevel == 'Débutant' && debutantCompleted >= 3) {
        newLevel = 'Intermédiaire';
      } else if (currentLevel == 'Intermédiaire' &&
          intermediaireCompleted >= 3) {
        newLevel = 'Avancé';
      }

      // Si le niveau a changé, le mettre à jour
      if (newLevel != currentLevel) {
        await _db.collection('users').doc(userId).update({
          'level': newLevel,
          'levelUpdatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Erreur lors de la mise à jour du niveau: $e');
    }
  }

  // --- Gestion de l'Historique ---

  // Récupérer l'historique des leçons
  Future<List<LessonHistory>> getLessonHistory({int limit = 10}) async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _db
        .collection('users')
        .doc(user.uid)
        .collection('lesson_history')
        .orderBy('completedDate', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return LessonHistory(
        data['lessonName'],
        data['moduleName'],
        (data['completedDate'] as Timestamp).toDate(),
      );
    }).toList();
  }

  // Ajouter une leçon à l'historique
  Future<void> addLessonToHistory(String lessonName, String moduleName) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _db
        .collection('users')
        .doc(user.uid)
        .collection('lesson_history')
        .add({
          'lessonName': lessonName,
          'moduleName': moduleName,
          'completedDate':
              FieldValue.serverTimestamp(), // Utilise l'heure du serveur
        });
  }

  // --- Communication Peer-to-Peer ---

  // Obtenir la liste des utilisateurs (sauf l'utilisateur actuel)
  Stream<List<P2PUser>> getUsersStream() {
    final currentUser = _auth.currentUser;
    return _db.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .where(
            (doc) => doc.id != currentUser?.uid,
          ) // Exclure l'utilisateur actuel
          .map((doc) {
            final data = doc.data();
            return P2PUser(
              id: doc.id,
              name: data['displayName'] ?? 'Utilisateur inconnu',
              avatarUrl: data['photoURL'] ?? '',
              isOnline: _isUserOnline(data),
            );
          })
          .toList();
    });
  }

  // Obtenir le flux de messages pour un chat
  Stream<List<ChatMessage>> getChatMessagesStream(String otherUserId) {
    final currentUser = _auth.currentUser!;
    final chatId = _getChatId(currentUser.uid, otherUserId);

    return _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return ChatMessage(
              text: data['text'],
              isSentByMe: data['senderId'] == currentUser.uid,
            );
          }).toList();
        });
  }

  // Envoyer un message
  Future<void> sendMessage(String otherUserId, String text) async {
    final currentUser = _auth.currentUser!;
    final chatId = _getChatId(currentUser.uid, otherUserId);
    final chatRef = _db.collection('chats').doc(chatId);

    await chatRef.set({
      'users': [currentUser.uid, otherUserId],
      'lastMessage': text,
      'lastMessageSenderId': currentUser.uid,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await chatRef.collection('messages').add({
      'text': text,
      'senderId': currentUser.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> markChatAsRead(String otherUserId) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final chatId = _getChatId(currentUser.uid, otherUserId);
    await _db.collection('chats').doc(chatId).set({
      'users': [currentUser.uid, otherUserId],
      'readBy': {currentUser.uid: FieldValue.serverTimestamp()},
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Helper pour créer un ID de chat unique et cohérent
  String _getChatId(String userId1, String userId2) {
    return userId1.hashCode <= userId2.hashCode
        ? '${userId1}_$userId2'
        : '${userId2}_$userId1';
  }

  // Obtenir le flux des salons de discussion avec le dernier message
  Stream<List<Map<String, dynamic>>> getChatRoomsStream() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return Stream.value([]);

    return _db
        .collection('chats')
        .where('users', arrayContains: currentUser.uid)
        .snapshots()
        .asyncMap((chatRoomsSnapshot) async {
          final chatRooms = <Map<String, dynamic>>[];

          for (final chatDoc in chatRoomsSnapshot.docs) {
            final chatData = chatDoc.data();
            final users = List<String>.from(chatData['users'] ?? []);
            final otherUserId = users.firstWhere((id) => id != currentUser.uid);

            // Récupérer les informations de l'autre utilisateur
            final userDoc = await _db
                .collection('users')
                .doc(otherUserId)
                .get();
            final userData = userDoc.data() ?? {};

            final otherUser = P2PUser(
              id: otherUserId,
              name: userData['displayName'] ?? 'Utilisateur inconnu',
              avatarUrl: userData['photoURL'] ?? '',
              isOnline: _isUserOnline(userData),
            );

            final readByRaw = chatData['readBy'];
            final readBy = readByRaw is Map
                ? Map<String, dynamic>.from(readByRaw)
                : <String, dynamic>{};
            final myReadAtValue = readBy[currentUser.uid];
            final myReadAt = myReadAtValue is Timestamp
                ? myReadAtValue.toDate()
                : DateTime.fromMillisecondsSinceEpoch(0);

            // Récupérer le dernier message
            final messagesQuery = await chatDoc.reference
                .collection('messages')
                .orderBy('timestamp', descending: true)
                .limit(1)
                .get();

            String? lastMessage;
            DateTime? timestamp;

            if (messagesQuery.docs.isNotEmpty) {
              final messageData = messagesQuery.docs.first.data();
              lastMessage = messageData['text'];
              final timestampValue = messageData['timestamp'];
              if (timestampValue != null) {
                timestamp = (timestampValue as Timestamp).toDate();
              }
            }

            final unreadQuery = await chatDoc.reference
                .collection('messages')
                .where('timestamp', isGreaterThan: Timestamp.fromDate(myReadAt))
                .get();
            final unreadCount = unreadQuery.docs.where((msgDoc) {
              final msgData = msgDoc.data();
              return msgData['senderId'] != currentUser.uid;
            }).length;

            chatRooms.add({
              'chatId': chatDoc.id,
              'otherUser': otherUser,
              'lastMessage': lastMessage,
              'timestamp': timestamp,
              'unreadCount': unreadCount,
            });
          }

          // Trier par timestamp du dernier message (les plus récents en premier)
          chatRooms.sort((a, b) {
            final aTime = a['timestamp'] as DateTime?;
            final bTime = b['timestamp'] as DateTime?;
            if (aTime == null && bTime == null) return 0;
            if (aTime == null) return 1;
            if (bTime == null) return -1;
            return bTime.compareTo(aTime);
          });

          return chatRooms;
        });
  }

  bool _isUserOnline(Map<String, dynamic> data) {
    final isOnline = data['isOnline'] == true;
    final lastSeen = data['lastSeen'];
    if (!isOnline || lastSeen is! Timestamp) return false;

    final difference = DateTime.now().difference(lastSeen.toDate());
    return difference.inSeconds < 90;
  }
}

class ModuleValidationResult {
  final bool quizPassed;
  final bool moduleValidated;
  final bool newlyValidated;

  const ModuleValidationResult({
    required this.quizPassed,
    required this.moduleValidated,
    required this.newlyValidated,
  });
}
