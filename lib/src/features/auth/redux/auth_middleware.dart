// lib/src/features/auth/redux/auth_middleware.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:login_app/src/features/auth/service/auth_service.dart';
import 'package:redux/redux.dart';

import '../../../app/redux/app_state.dart';
import 'auth_actions.dart';

List<Middleware<AppState>> createAuthMiddleware(AuthService auth) {
  return [
    TypedMiddleware<AppState, LoginRequested>(_handleLogin(auth)).call,
    TypedMiddleware<AppState, LogoutRequested>(_handleLogout(auth)).call,
    TypedMiddleware<AppState, SignUpRequested>(_handleSignUp(auth)).call,
  ];
}

FutureOr<void> Function(
  Store<AppState> store,
  LoginRequested action,
  NextDispatcher next,
)
_handleLogin(AuthService auth) {
  return (store, action, next) async {
    next(action);
    try {
      final user = await auth.signIn(action.email, action.password);
      store.dispatch(LoginSucceeded(userInfo: user));
    } catch (e, st) {
      debugPrint('Login error: $e\n$st');
      store.dispatch(LoginFailed(message: _fmt(e)));
    }
  };
}

FutureOr<void> Function(
  Store<AppState> store,
  LogoutRequested action,
  NextDispatcher next,
)
_handleLogout(AuthService auth) {
  return (store, action, next) async {
    next(action);
    try {
      await auth.signOut();
    } catch (_) {
      debugPrint('Logout error');
    }
    store.dispatch(LogoutSucceeded());
  };
}

FutureOr<void> Function(
  Store<AppState> store,
  SignUpRequested action,
  NextDispatcher next,
)
_handleSignUp(AuthService auth) {
  return (store, action, next) async {
    next(action);
    try {
      final user = await auth.signUp(action.email, action.password);
      store.dispatch(SignUpSucceeded(user));
      store.dispatch(LoginSucceeded(userInfo: user));
    } catch (e, st) {
      debugPrint('SignUp error: $e\n$st');
      store.dispatch(SignUpFailed(_fmt(e)));
    }
  };
}

String _fmt(Object e) => e.toString().replaceFirst('Exception: ', '');
