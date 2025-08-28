import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/src/features/auth/models/user.dart';
import 'package:login_app/src/features/auth/redux/auth_reducer.dart';
import 'package:login_app/src/features/auth/redux/auth_state.dart';
import 'package:login_app/src/features/auth/redux/auth_actions.dart';

void main() {
  group('auth_reducer', () {
    test('initial state', () {
      final initial = AuthState.initial();
      final next = authReducer(initial, Object());
      expect(next, initial);
    });

    test('LoginRequested -> status: loading', () {
      final state = AuthState(
        status: AuthStatus.unauthenticated,
        userInfo: null,
        errorMessage: 'algo falló',
      );

      final next = authReducer(
        state,
        LoginRequested(email: 'a@b.com', password: '123456'),
      );

      expect(next.status, AuthStatus.loading);
      expect(next.errorMessage, isNull);
      expect(next.userInfo, state.userInfo); // no cambia todavía
    });

    test('LoginSucceeded -> authenticated', () {
      final state = AuthState.initial();
      final next = authReducer(
        state,
        LoginSucceeded(
          userInfo: UserModel(id: 'id-1', email: 'test@redux.com'),
        ),
      );

      expect(next.status, AuthStatus.authenticated);
      expect(next.userInfo?.id, 'id-1');
      expect(next.userInfo?.email, 'test@redux.com');
      expect(next.errorMessage, isNull);
    });

    test('SignUpRequested -> loading', () {
      final state = AuthState.initial();
      final next = authReducer(
        state,
        SignUpRequested(email: 'nuevo@correo.com', password: '123456'),
      );

      expect(next.status, AuthStatus.loading);
      expect(next.errorMessage, isNull);
    });

    test('SignUpSucceeded -> authenticated (auto-login en reducer)', () {
      final state = AuthState.initial();
      final next = authReducer(
        state,
        SignUpSucceeded(UserModel(email: 'nuevo@correo.com', id: 'id-2')),
      );

      expect(next.status, AuthStatus.authenticated);
      expect(next.userInfo?.email, 'nuevo@correo.com');
      expect(next.userInfo?.id, 'id-2');
      expect(next.errorMessage, isNull);
    });

    test('SignUpFailed -> error', () {
      final state = AuthState.initial();

      final next = authReducer(state, SignUpFailed('Correo ya registrado'));

      expect(next.status, AuthStatus.error);
      expect(next.errorMessage, 'Correo ya registrado');
    });

    test('ClearAuthError ->  limpia error, no cambia status', () {
      final state = AuthState(
        status: AuthStatus.error,
        userInfo: null,
        errorMessage: 'error',
      );

      final next = authReducer(state, ClearAuthError());

      expect(next.status, state.status);
      expect(next.errorMessage, isNull);
    });

    test('LogoutSucceeded -> vuelve a initial()', () {
      final state = AuthState(
        status: AuthStatus.authenticated,
        userInfo: UserModel(id: 'id-1', email: 'test@redux.com'),
        errorMessage: null,
      );

      final next = authReducer(state, LogoutSucceeded());

      expect(next.status, AuthStatus.unauthenticated);
      expect(next.userInfo, isNull);
      expect(next.errorMessage, isNull);
    });
  });
}
