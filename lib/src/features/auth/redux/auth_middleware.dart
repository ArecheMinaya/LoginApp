import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_app/src/app/redux/app_state.dart';
import 'package:login_app/src/features/auth/models/user.dart';
import 'package:redux/redux.dart';
import 'auth_actions.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  return [
    TypedMiddleware<AppState, LoginRequested>(_handleLoginRequested).call,
    TypedMiddleware<AppState, LogoutRequested>(_handleLogoutRequested).call,
    TypedMiddleware<AppState, SignUpRequested>(_handleSignUp).call,
  ];
}

Future<void> _handleLoginRequested(
  Store<AppState> store,
  LoginRequested action,
  NextDispatcher next,
) async {
  next(action);

  await Future.delayed(const Duration(seconds: 2));

  const validEmail = 'test@redux.com';
  const validPass = '123456';

  if (action.email.trim().toLowerCase() == validEmail &&
      action.password == validPass) {
    debugPrint('Middleware: Login OK -> LoginSucceeded');
    store.dispatch(
      LoginSucceeded(
        userInfo: UserModel(id: "id-1", email: action.email.trim()),
      ),
    );
  } else {
    store.dispatch(LoginFailed(message: 'Invalid email or password'));
  }
}

void _handleLogoutRequested(
  Store<AppState> store,
  LogoutRequested action,
  NextDispatcher next,
) {
  next(action);
  store.dispatch(LogoutSucceeded());
}

Future<void> _handleSignUp(
  Store<AppState> store,
  SignUpRequested action,
  NextDispatcher next,
) async {
  next(action);

  await Future.delayed(const Duration(seconds: 2));

  store.dispatch(
    SignUpSucceeded(UserModel(email: action.email.trim(), id: "id-1")),
  );

  store.dispatch(
    LoginSucceeded(
      userInfo: UserModel(email: action.email.trim(), id: "id-1"),
    ),
  );
}
