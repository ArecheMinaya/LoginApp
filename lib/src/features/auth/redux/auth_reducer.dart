import 'package:redux/redux.dart';
import 'auth_state.dart';
import 'auth_actions.dart';

final Reducer<AuthState> authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, LoginRequested>(
    (state, action) => _onLoginRequested(state, action),
  ).call,

  TypedReducer<AuthState, LoginSucceeded>(
    (state, action) => _onLoginSucceeded(state, action),
  ).call,

  TypedReducer<AuthState, LoginFailed>(
    (state, action) => _onLoginFailed(state, action),
  ).call,

  TypedReducer<AuthState, LogoutSucceeded>(
    (state, action) => _onLogoutSucceeded(state, action),
  ).call,
]);

AuthState _onLoginRequested(AuthState state, LoginRequested action) {
  return state.copyWith(status: AuthStatus.loading, errorMessage: null);
}

AuthState _onLoginSucceeded(AuthState state, LoginSucceeded action) {
  return state.copyWith(
    status: AuthStatus.authenticated,
    userInfo: action.userInfo,
    errorMessage: null,
  );
}

AuthState _onLoginFailed(AuthState state, LoginFailed action) {
  return state.copyWith(
    status: AuthStatus.error,
    userInfo: null,
    errorMessage: action.message,
  );
}

AuthState _onLogoutSucceeded(AuthState state, LogoutSucceeded action) {
  return AuthState.initial();
}
