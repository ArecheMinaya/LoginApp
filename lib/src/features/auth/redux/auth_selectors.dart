import 'package:login_app/src/features/auth/models/user.dart';

import 'auth_state.dart';

bool isAuthenticated(AuthState s) => s.status == AuthStatus.authenticated;
bool isLoading(AuthState s) => s.status == AuthStatus.loading;
UserModel? currentUser(AuthState s) => s.userInfo;
String? authError(AuthState s) => s.errorMessage;
