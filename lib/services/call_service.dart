import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CallService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _collection = 'calls';

  // Obtient l'ID de l'utilisateur actuellement connecté
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  Future<bool> isUserOnline(String userId) async {
    final userDoc = await _firestore.collection('users').doc(userId).get();
    final data = userDoc.data();
    if (data == null) return false;

    final isOnline = data['isOnline'] == true;
    final lastSeen = data['lastSeen'];
    if (!isOnline || lastSeen is! Timestamp) return false;

    final difference = DateTime.now().difference(lastSeen.toDate());
    return difference.inSeconds < 90;
  }

  // Crée un appel en stockant l'offre SDP et les participants
  Future<String> createCall(
    RTCSessionDescription offer,
    String callerId,
    String calleeId,
  ) async {
    final callDoc = _firestore.collection(_collection).doc();
    await callDoc.set({
      'offer': {'sdp': offer.sdp, 'type': offer.type},
      'callerId': callerId,
      'calleeId': calleeId,
      'callType': 'video',
      'status': 'ringing',
      'createdAt': FieldValue.serverTimestamp(), // Pour d'éventuels nettoyages
    });
    return callDoc.id;
  }

  // Met à jour l'appel avec la réponse SDP
  Future<void> joinCall(String callId, RTCSessionDescription answer) async {
    await _firestore.collection(_collection).doc(callId).update({
      'answer': {'sdp': answer.sdp, 'type': answer.type},
      'status': 'answered',
      'answeredAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> declineCall(String callId) async {
    await _firestore.collection(_collection).doc(callId).update({
      'status': 'declined',
      'endedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> cancelCall(String callId) async {
    final callDoc = await _firestore.collection(_collection).doc(callId).get();
    final data = callDoc.data() ?? {};
    final callerId = data['callerId'] as String? ?? '';
    final calleeId = data['calleeId'] as String? ?? '';

    await _firestore.collection(_collection).doc(callId).update({
      'status': 'cancelled',
      'endedAt': FieldValue.serverTimestamp(),
      if (calleeId.isNotEmpty) 'missedFor': [calleeId],
      if (callerId.isNotEmpty) 'missedSeenBy': [callerId],
    });
  }

  Future<void> endCall(String callId) async {
    await _firestore.collection(_collection).doc(callId).update({
      'status': 'ended',
      'endedAt': FieldValue.serverTimestamp(),
    });
  }

  // Trouve un appel en attente pour un utilisateur donné
  Future<String?> getCallId(String calleeId) async {
    final query = await _firestore
        .collection(_collection)
        .where('calleeId', isEqualTo: calleeId)
        .where('answer', isNull: true)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return query.docs.first.id;
    }
    return null;
  }

  Stream<Map<String, dynamic>?> getIncomingCallStream() {
    final currentUserId = getCurrentUserId();
    if (currentUserId == null) return Stream.value(null);

    return _firestore
        .collection(_collection)
        .where('calleeId', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'ringing')
        .limit(1)
        .snapshots()
        .asyncMap((snapshot) async {
          if (snapshot.docs.isEmpty) return null;

          final callDoc = snapshot.docs.first;
          final data = callDoc.data();
          final callerId = data['callerId'] as String? ?? '';
          final callerDoc = await _firestore
              .collection('users')
              .doc(callerId)
              .get();
          final callerData = callerDoc.data() ?? {};

          return {
            'callId': callDoc.id,
            'callerId': callerId,
            'calleeId': currentUserId,
            'callerName': callerData['displayName'] ?? 'Utilisateur inconnu',
          };
        });
  }

  // Ajoute un candidat ICE à la bonne sous-collection
  Future<void> addIceCandidate(
    String callId,
    RTCIceCandidate candidate,
    bool isCaller,
  ) async {
    final collectionName = isCaller ? 'callerCandidates' : 'calleeCandidates';
    await _firestore
        .collection(_collection)
        .doc(callId)
        .collection(collectionName)
        .add({
          'candidate': candidate.candidate,
          'sdpMid': candidate.sdpMid,
          'sdpMLineIndex': candidate.sdpMLineIndex,
        });
  }

  // Récupère l'offre initiale pour un appel donné
  Future<RTCSessionDescription?> getOffer(String callId) async {
    final snapshot = await _firestore.collection(_collection).doc(callId).get();
    final data = snapshot.data();
    if (data != null && data.containsKey('offer')) {
      return RTCSessionDescription(data['offer']['sdp'], data['offer']['type']);
    }
    return null;
  }

  // Fournit un flux pour écouter la réponse de l'appelé
  Stream<RTCSessionDescription> getAnswerStream(String callId) {
    return _firestore
        .collection(_collection)
        .doc(callId)
        .snapshots()
        .where((snapshot) => snapshot.data()?.containsKey('answer') ?? false)
        .map((snapshot) {
          final data = snapshot.data()!;
          return RTCSessionDescription(
            data['answer']['sdp'],
            data['answer']['type'],
          );
        });
  }

  // Fournit un flux pour écouter les candidats ICE
  Stream<RTCIceCandidate> getIceCandidatesStream(String callId, bool isCaller) {
    final collectionName = isCaller ? 'calleeCandidates' : 'callerCandidates';
    return _firestore
        .collection(_collection)
        .doc(callId)
        .collection(collectionName)
        .snapshots()
        .expand((snapshot) => snapshot.docChanges)
        .where((change) => change.type == DocumentChangeType.added)
        .map((change) {
          final data = change.doc.data()!;
          return RTCIceCandidate(
            data['candidate'],
            data['sdpMid'],
            data['sdpMLineIndex'],
          );
        });
  }

  // Obtenir l'historique des appels
  Stream<List<Map<String, dynamic>>> getCallHistoryStream() {
    final currentUserId = getCurrentUserId();
    if (currentUserId == null) return Stream.value([]);

    final controller = StreamController<List<Map<String, dynamic>>>();
    QuerySnapshot<Map<String, dynamic>>? callerSnapshot;
    QuerySnapshot<Map<String, dynamic>>? calleeSnapshot;

    Future<void> emitHistory() async {
      final docs = <QueryDocumentSnapshot<Map<String, dynamic>>>[
        ...?callerSnapshot?.docs,
        ...?calleeSnapshot?.docs,
      ];

      final uniqueDocs = {for (final doc in docs) doc.id: doc}.values.toList();

      final callHistory = await _buildCallHistory(uniqueDocs, currentUserId);
      if (!controller.isClosed) {
        controller.add(callHistory);
      }
    }

    final callerSubscription = _firestore
        .collection(_collection)
        .where('callerId', isEqualTo: currentUserId)
        .limit(50)
        .snapshots()
        .listen((snapshot) {
          callerSnapshot = snapshot;
          emitHistory();
        }, onError: controller.addError);

    final calleeSubscription = _firestore
        .collection(_collection)
        .where('calleeId', isEqualTo: currentUserId)
        .limit(50)
        .snapshots()
        .listen((snapshot) {
          calleeSnapshot = snapshot;
          emitHistory();
        }, onError: controller.addError);

    controller.onCancel = () async {
      await callerSubscription.cancel();
      await calleeSubscription.cancel();
    };

    return controller.stream;
  }

  Future<void> markMissedCallsAsSeen() async {
    final currentUserId = getCurrentUserId();
    if (currentUserId == null) return;

    final calleeSnapshot = await _firestore
        .collection(_collection)
        .where('calleeId', isEqualTo: currentUserId)
        .limit(50)
        .get();

    for (final doc in calleeSnapshot.docs) {
      final data = doc.data();
      final status = _resolveCallStatus(data, false);
      if (status != 'missed') continue;

      final seenByRaw = data['missedSeenBy'];
      final seenBy = seenByRaw is List
          ? List<String>.from(seenByRaw)
          : <String>[];
      if (seenBy.contains(currentUserId)) continue;

      await doc.reference.update({
        'missedSeenBy': FieldValue.arrayUnion([currentUserId]),
      });
    }
  }

  Future<List<Map<String, dynamic>>> _buildCallHistory(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
    String currentUserId,
  ) async {
    final callHistory = <Map<String, dynamic>>[];

    for (final doc in docs) {
      final data = doc.data();
      final callerId = data['callerId'] as String? ?? '';
      final calleeId = data['calleeId'] as String? ?? '';
      final isCaller = callerId == currentUserId;
      final otherUserId = isCaller ? calleeId : callerId;

      final userDoc = await _firestore
          .collection('users')
          .doc(otherUserId)
          .get();
      final userData = userDoc.data() ?? {};
      final otherUserName = userData['displayName'] ?? 'Utilisateur inconnu';

      final callStatus = _resolveCallStatus(data, isCaller);
      final seenByRaw = data['missedSeenBy'];
      final seenBy = seenByRaw is List
          ? List<String>.from(seenByRaw)
          : <String>[];
      final missedUnread =
          callStatus == 'missed' && !seenBy.contains(currentUserId);

      final timestamp =
          (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
      final duration = _resolveDuration(data);

      callHistory.add({
        'otherUserName': otherUserName,
        'callType': data['callType'] ?? 'video',
        'callStatus': callStatus,
        'missedUnread': missedUnread,
        'timestamp': timestamp,
        'duration': duration,
      });
    }

    callHistory.sort((a, b) {
      final aTime = a['timestamp'] as DateTime;
      final bTime = b['timestamp'] as DateTime;
      return bTime.compareTo(aTime);
    });

    return callHistory.take(50).toList();
  }

  String _resolveCallStatus(Map<String, dynamic> data, bool isCaller) {
    final status = data['status'] as String?;

    switch (status) {
      case 'answered':
      case 'ended':
        return 'completed';
      case 'declined':
        return 'declined';
      case 'cancelled':
        return 'cancelled';
      case 'ringing':
        return isCaller ? 'ringing' : 'missed';
      default:
        if (data.containsKey('answer')) return 'completed';
        return isCaller ? 'cancelled' : 'missed';
    }
  }

  Duration? _resolveDuration(Map<String, dynamic> data) {
    final answeredAt = data['answeredAt'];
    final endedAt = data['endedAt'];
    if (answeredAt is! Timestamp) return null;

    final start = answeredAt.toDate();
    final end = endedAt is Timestamp ? endedAt.toDate() : DateTime.now();
    if (end.isBefore(start)) return null;

    return end.difference(start);
  }
}
