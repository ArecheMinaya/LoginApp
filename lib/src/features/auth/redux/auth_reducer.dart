import 'package:redux/redux.dart';
import 'auth_state.dart';
import 'auth_actions.dart';

final Reducer<AuthState> authReducer = combineReducers<AuthState>([
  // LOGIN
  TypedReducer<AuthState, LoginRequested>(
    (state, action) => _onLoginRequested(state, action),
  ).call,
  TypedReducer<AuthState, LoginSucceeded>(
    (state, action) => _onLoginSucceeded(state, action),
  ).call,
  TypedReducer<AuthState, LoginFailed>(
    (state, action) => _onLoginFailed(state, action),
  ).call,

  // SIGN UP
  TypedReducer<AuthState, SignUpRequested>(
    (state, action) => _onSignUpRequested(state, action),
  ).call,
  TypedReducer<AuthState, SignUpSucceeded>(
    (state, action) => _onSignUpSucceeded(state, action),
  ).call,
  TypedReducer<AuthState, SignUpFailed>(
    (state, action) => _onSignUpFailed(state, action),
  ).call,

  // LOGOUT
  TypedReducer<AuthState, LogoutSucceeded>(
    (state, action) => _onLogoutSucceeded(state, action),
  ).call,

  // CLEAR ERROR
  TypedReducer<AuthState, ClearAuthError>(
    (s, a) => s.copyWith(errorMessage: null),
  ).call,
]);

// -------------------- HANDLERS --------------------

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

AuthState _onSignUpRequested(AuthState state, SignUpRequested action) {
  return state.copyWith(status: AuthStatus.loading, errorMessage: null);
}

AuthState _onSignUpSucceeded(AuthState state, SignUpSucceeded action) {
  return state.copyWith(
    userInfo: action.userInfo,
    errorMessage: null,
    status: AuthStatus.authenticated,
  );
}

AuthState _onSignUpFailed(AuthState state, SignUpFailed action) {
  return state.copyWith(status: AuthStatus.error, errorMessage: action.message);
}

AuthState _onLogoutSucceeded(AuthState state, LogoutSucceeded action) {
  return AuthState.initial();
}
