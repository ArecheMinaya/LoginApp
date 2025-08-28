import 'package:flutter/material.dart';
import 'package:login_app/src/app/presentation/theme/dark_theme.dart';
import 'package:login_app/src/app/presentation/theme/light_theme.dart';

import 'routes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redux Auth Demo',
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.root,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
