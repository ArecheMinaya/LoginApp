import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_app/src/features/auth/models/user.dart';
import 'package:redux/redux.dart';

import 'package:login_app/src/app/redux/app_state.dart';
import 'package:login_app/src/features/auth/redux/auth_state.dart';
import 'package:login_app/src/features/settings/redux/settings_state.dart';
import 'package:login_app/src/features/auth/presentation/pages/home_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Reducer para el store del test (solo devuelve el mismo estado)
  AppState noopReducer(AppState state, dynamic action) => state;

  // Tamaño de dispositivo consistente (iPhone 12-ish)
  const Size deviceSize = Size(390, 844);

  Future<void> pumpHome(
    WidgetTester tester, {
    required ThemeMode themeMode,
    required AppState initialState,
  }) async {
    final store = Store<AppState>(noopReducer, initialState: initialState);

    await tester.binding.setSurfaceSize(deviceSize);
    // Asegura pixelRatio consistente para evitar difs de AA
    tester.view.devicePixelRatio = 3.0;

    await tester.pumpWidget(
      StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: themeMode,
          home: const HomePage(),
        ),
      ),
    );

    // Deja que se pinte todo
    await tester.pumpAndSettle();
  }

  group('HomePage golden', () {
    testWidgets('light mode', (tester) async {
      final initial = AppState(
        auth: AuthState(
          status: AuthStatus.authenticated,
          userInfo: UserModel(id: 'id-1', email: 'test@redux.com'),
          errorMessage: null,
        ),
        settings: const SettingsState(themeMode: AppThemeMode.light),
      );

      await pumpHome(tester, themeMode: ThemeMode.light, initialState: initial);

      // Captura toda la pantalla (MaterialApp raíz)
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/home_page_light.png'),
      );
    });

    testWidgets('dark mode', (tester) async {
      final initial = AppState(
        auth: AuthState(
          status: AuthStatus.authenticated,
          userInfo: UserModel(id: 'id-1', email: 'test@redux.com'),
          errorMessage: null,
        ),
        settings: const SettingsState(themeMode: AppThemeMode.dark),
      );

      await pumpHome(tester, themeMode: ThemeMode.dark, initialState: initial);

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/home_page_dark.png'),
      );
    });
  });
}
