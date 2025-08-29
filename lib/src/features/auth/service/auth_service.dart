import 'package:login_app/src/features/auth/models/user.dart';

abstract class AuthService {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String email, String password);
  Future<void> signOut();
}
