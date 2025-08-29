import 'package:login_app/src/app/config/env.dart';
import 'package:login_app/src/app/redux/app_state.dart';
import 'package:login_app/src/features/auth/redux/auth_middleware.dart';
import 'package:login_app/src/features/auth/service/auth_service.dart';
import 'package:login_app/src/features/auth/service/fake_auht_service.dart';
import 'package:login_app/src/features/auth/service/firebase_auth_service.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> buildAppMiddlewares() {
  final AuthService authService = Env.environment == 'PROD'
      ? FirebaseAuthServiceAdapter()
      : FakeAuthService();
  return [...createAuthMiddleware(authService)];
}
