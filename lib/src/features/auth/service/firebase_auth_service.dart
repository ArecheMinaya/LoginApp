import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:login_app/src/features/auth/service/auth_service.dart';
import '../../auth/models/user.dart';

class FirebaseAuthServiceAdapter implements AuthService {
  final FirebaseAuth _auth;
  FirebaseAuthServiceAdapter({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final u = cred.user!;
      return UserModel(id: u.uid, email: u.email ?? email);
    } catch (e, st) {
      debugPrint('Firebase signIn error: $e\n$st');
      throw Exception(_readableError(e));
    }
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final u = cred.user!;
      return UserModel(id: u.uid, email: u.email ?? email);
    } catch (e, st) {
      debugPrint('Firebase signUp error: $e\n$st');
      throw Exception(_readableError(e));
    }
  }

  @override
  Future<void> signOut() => _auth.signOut();

  String _readableError(Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return 'Credenciales inválidas';
        case 'email-already-in-use':
          return 'El correo ya está registrado';
        case 'weak-password':
          return 'Contraseña muy débil';
        default:
          return 'Error de autenticación (${e.code})';
      }
    }
    return 'Error de autenticación';
  }
}
