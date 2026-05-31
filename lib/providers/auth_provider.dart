import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  Map<String, dynamic>? _userData;
  Timer? _presenceTimer;

  User? get user => _user;
  Map<String, dynamic>? get userData => _userData;
  String? get userLevel => _userData?['level'];

  AuthProvider() {
    _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    _user = user;
    if (user != null) {
      await _setPresence(user.uid, true);
      _startPresenceHeartbeat(user.uid);
      await _fetchUserData(user.uid);
    } else {
      _presenceTimer?.cancel();
      _userData = null;
    }
    notifyListeners();
  }

  void _startPresenceHeartbeat(String userId) {
    _presenceTimer?.cancel();
    _presenceTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _setPresence(userId, true);
    });
  }

  Future<void> _setPresence(String userId, bool isOnline) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'isOnline': isOnline,
        'lastSeen': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {
      // La présence ne doit pas bloquer l'authentification.
    }
  }

  Future<void> _fetchUserData(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      _userData = userDoc.data();
      notifyListeners();
    } catch (e) {
      _userData = null;
      // Idéalement, enregistrez cette erreur quelque part
    }
  }

  // Méthode publique pour rafraîchir les données utilisateur
  Future<void> refreshUserData() async {
    if (_user != null) {
      await _fetchUserData(_user!.uid);
    }
  }

  Future<void> signUp(
    String email,
    String password,
    String displayName,
    String level,
  ) async {
    // Le listener _onAuthStateChanged s'occupera de mettre à jour l'état
    await _authService.signUpWithEmailAndPassword(
      email,
      password,
      displayName,
      level,
    );
  }

  Future<void> signIn(String email, String password) async {
    // Le listener _onAuthStateChanged s'occupera de mettre à jour l'état
    await _authService.signInWithEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    final currentUserId = _user?.uid;
    if (currentUserId != null) {
      _presenceTimer?.cancel();
      await _setPresence(currentUserId, false);
    }
    await _authService.signOut();
    // Le listener _onAuthStateChanged s'occupera de mettre à jour l'état
  }

  @override
  void dispose() {
    _presenceTimer?.cancel();
    super.dispose();
  }
}
