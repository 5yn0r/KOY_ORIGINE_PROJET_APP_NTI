import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream pour l\'état de l\'authentification
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Inscription avec e-mail, mot de passe et niveau
  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
    String displayName,
    String level,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user != null) {
        // Créer un document pour le nouvel utilisateur dans Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'displayName': displayName,
          'level': level,
          'createdAt': Timestamp.now(),
        });
      }
      return user;
    } catch (e) {
      // Gérer les erreurs (par exemple, si l'email existe déjà)
      rethrow;
    }
  }

  // Connexion avec e-mail et mot de passe
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      rethrow;
    }
  }

  // Mettre à jour le profil utilisateur
  Future<void> updateUserProfile(
    String userId,
    String newDisplayName, {
    String? level,
  }) async {
    try {
      final payload = <String, dynamic>{'displayName': newDisplayName};
      if (level != null) {
        payload['level'] = level;
        payload['levelUpdatedAt'] = FieldValue.serverTimestamp();
      }
      await _firestore.collection('users').doc(userId).update(payload);
    } catch (e) {
      rethrow;
    }
  }

  // Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
