import 'package:flutter/material.dart';
import 'package:login_app/src/app/presentation/root_router.dart';
import 'package:login_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:login_app/src/features/auth/presentation/pages/home_page.dart';
import 'package:login_app/src/features/auth/presentation/pages/sign_up_page.dart';

mixin AppRoutes {
  static const root = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const profile = '/settings';
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.root:
      return _material(const RootRouter()); // 👈 GUARD AQUÍ
    case AppRoutes.login:
      return _material(const LoginPage());
    case AppRoutes.register:
      return _material(const SignUpPage());
    case AppRoutes.home:
      return _material(const HomePage());
    default:
      return _material(
        Scaffold(
          appBar: AppBar(title: const Text('Ruta no encontrada')),
          body: Center(child: Text('No existe: ${settings.name}')),
        ),
      );
  }
}

MaterialPageRoute _material(Widget child) =>
    MaterialPageRoute(builder: (_) => child);
