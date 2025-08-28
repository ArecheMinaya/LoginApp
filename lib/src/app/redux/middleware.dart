import 'package:login_app/src/app/redux/app_state.dart';
import 'package:login_app/src/features/auth/redux/auth_middleware.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> buildAppMiddlewares() {
  return [...createAuthMiddleware()];
}
