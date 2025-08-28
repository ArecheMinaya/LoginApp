import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/src/features/settings/redux/settings_reducer.dart';
import 'package:login_app/src/features/settings/redux/settings_state.dart';
import 'package:login_app/src/features/settings/redux/settings_actions.dart';

void main() {
  group('settings_reducer', () {
    test('initial state', () {
      final initial = SettingsState.initial();
      expect(initial.themeMode, AppThemeMode.system);
    });

    test('ChangeThemeMode -> actualiza themeMode', () {
      final state = SettingsState.initial();
      final next = settingsReducer(state, ChangeThemeMode(AppThemeMode.dark));
      expect(next.themeMode, AppThemeMode.dark);

      final back = settingsReducer(next, ChangeThemeMode(AppThemeMode.light));
      expect(back.themeMode, AppThemeMode.light);
    });
  });
}
