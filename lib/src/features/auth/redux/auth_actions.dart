import 'package:login_app/src/features/auth/%20models/user.dart';

class LoginRequested {
  final String email;
  final String password;
  LoginRequested({required this.email, required this.password});
}

class LoginSucceeded {
  final UserModel userInfo;
  LoginSucceeded({required this.userInfo});
}

class LoginFailed {
  final String message;
  LoginFailed({required this.message});
}

class LogoutRequested {}

class LogoutSucceeded {}
