import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_app/src/app/redux/app_state.dart';
import 'package:login_app/src/features/settings/redux/settings_actions.dart';
import 'package:login_app/src/features/settings/redux/settings_state.dart';
import 'package:redux/redux.dart';

class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Vm>(
      distinct: true,
      converter: (Store<AppState> store) => _Vm(
        mode: store.state.settings.themeMode,
        onChange: (m) => store.dispatch(ChangeThemeMode(m)),
      ),
      builder: (context, vm) {
        IconData icon;
        String tooltip;

        switch (vm.mode) {
          case AppThemeMode.light:
            icon = Icons.light_mode;
            tooltip = 'Modo claro';
            break;
          case AppThemeMode.dark:
            icon = Icons.dark_mode;
            tooltip = 'Modo oscuro';
            break;
          case AppThemeMode.system:
            icon = Icons.brightness_auto;
            tooltip = 'Modo del sistema';
            break;
        }

        return IconButton(
          tooltip: tooltip,
          icon: Icon(icon),
          onPressed: () {
            // alterna en orden: system → light → dark → system ...
            final next = _nextMode(vm.mode);
            vm.onChange(next);
          },
        );
      },
    );
  }

  AppThemeMode _nextMode(AppThemeMode current) {
    switch (current) {
      case AppThemeMode.system:
        return AppThemeMode.light;
      case AppThemeMode.light:
        return AppThemeMode.dark;
      case AppThemeMode.dark:
        return AppThemeMode.system;
    }
  }
}

class _Vm {
  final AppThemeMode mode;
  final void Function(AppThemeMode) onChange;
  _Vm({required this.mode, required this.onChange});
}
