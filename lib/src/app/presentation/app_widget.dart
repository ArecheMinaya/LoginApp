import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_app/src/app/presentation/routes.dart';
import 'package:login_app/src/features/settings/redux/settings_selectors.dart';
import 'package:redux/redux.dart';
import 'package:login_app/src/app/presentation/theme/dark_theme.dart';
import 'package:login_app/src/app/presentation/theme/light_theme.dart';
import 'package:login_app/src/app/redux/app_state.dart';

class MainApp extends StatelessWidget {
  final Store<AppState> store;
  const MainApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, ThemeMode>(
        converter: (s) => mapThemeMode(s.state.settings.themeMode),
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Redux Auth Demo',
            theme: buildLightTheme(),
            darkTheme: buildDarkTheme(),
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.root,
            onGenerateRoute: onGenerateRoute,
          );
        },
      ),
    );
  }
}
