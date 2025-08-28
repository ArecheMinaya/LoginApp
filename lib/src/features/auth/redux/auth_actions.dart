import 'package:login_app/src/features/auth/models/user.dart';

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

class SignUpRequested {
  final String email;
  final String password;
  SignUpRequested({required this.email, required this.password});
}

class SignUpSucceeded {
  final UserModel userInfo;
  SignUpSucceeded(this.userInfo);
}

class SignUpFailed {
  final String message;
  SignUpFailed(this.message);
}

class LogoutRequested {}

class LogoutSucceeded {}

class ClearAuthError {}
