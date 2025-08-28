import 'package:login_app/src/core/services/firebase_auth_service.dart';
import 'package:login_app/src/features/auth/%20models/user.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepository(this._firebaseAuthService);

  Future<UserModel?> signIn(String email, String password) async {
    final response = await _firebaseAuthService.signInWithEmail(
      email,
      password,
    );
    if (response != null) {
      return UserModel.fromFirebase(response);
    }
    return null;
  }

  Future<UserModel?> signUp(String email, String password) async {
    final response = await _firebaseAuthService.createUserWithEmail(
      email,
      password,
    );
    if (response != null) {
      return UserModel.fromFirebase(response);
    }
    return null;
  }

  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
  }

  Future<UserModel?> mockLogin(String email, String password) async {
    final mockUser = UserModel(id: 'mocked_id', email: email);
    await Future.delayed(Duration(seconds: 2));
    if (email == "test@test.com" && password == "password") {
      return mockUser;
    }
    return null;
  }
}
