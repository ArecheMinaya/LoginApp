import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:login_app/src/features/auth/service/auth_service.dart';
import '../../auth/models/user.dart';

class FakeAuthService implements AuthService {
  static const validEmail = 'test@redux.com';
  static const validPass = '123456';

  @override
  Future<UserModel> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email.trim().toLowerCase() == validEmail && password == validPass) {
      debugPrint('FakeAuth: login OK');
      return UserModel(id: 'id-1', email: email.trim());
    }
    throw Exception('Invalid email or password');
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    // En DEV aceptamos todo y devolvemos un usuario
    return UserModel(id: 'new-id-1', email: email.trim());
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
