import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_app/src/app/presentation/routes.dart';
import 'package:login_app/src/app/redux/app_state.dart';
import 'package:login_app/src/features/auth/redux/auth_state.dart';
import 'package:redux/redux.dart';

class RootRouter extends StatelessWidget {
  const RootRouter({super.key});

  void _maybeGo(BuildContext context, String target) {
    final current = ModalRoute.of(context)?.settings.name;
    if (current == target) return; // evita navegación redundante
    Navigator.of(context).pushNamed(target);
  }

  void _routeForStatus(BuildContext context, AuthStatus status) {
    switch (status) {
      case AuthStatus.authenticated:
        _maybeGo(context, AppRoutes.home);
        break;
      case AuthStatus.unauthenticated:
        _maybeGo(context, AppRoutes.login);
        break;
      case AuthStatus.loading:
      case AuthStatus.error:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthStatus>(
      distinct: true,
      converter: (Store<AppState> store) => store.state.auth.status,

      onInitialBuild: (status) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _routeForStatus(context, status);
        });
      },

      onDidChange: (prev, next) {
        if (prev == next) return;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _routeForStatus(context, next);
        });
      },

      builder: (context, status) =>
          Scaffold(body: Center(child: const CircularProgressIndicator())),
    );
  }
}
