import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Crée un salon de discussion ou en récupère un existant
  Future<String> getOrCreateChatRoom(String receiverId) async {
    final currentUser = _auth.currentUser!;
    List<String> ids = [currentUser.uid, receiverId];
    ids.sort(); // Assure que l'ID du salon est toujours le même pour les deux utilisateurs
    String chatRoomId = ids.join('_');

    await _firestore.collection('chat_rooms').doc(chatRoomId).set({
      'users': ids,
    }, SetOptions(merge: true));

    return chatRoomId;
  }

  // Envoie un message
  Future<void> sendMessage(String receiverId, String text) async {
    final currentUser = _auth.currentUser!;
    final chatRoomId = await getOrCreateChatRoom(receiverId);

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add({
          'text': text,
          'senderId': currentUser.uid,
          'timestamp': FieldValue.serverTimestamp(),
        });
  }

  // Récupère les messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
