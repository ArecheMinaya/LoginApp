import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/src/app/redux/app_state.dart';
import 'package:login_app/src/app/redux/reducers.dart';
import 'package:login_app/src/features/auth/models/user.dart';
import 'package:login_app/src/features/auth/redux/auth_actions.dart';
import 'package:login_app/src/features/settings/redux/settings_actions.dart';
import 'package:login_app/src/features/settings/redux/settings_state.dart';

void main() {
  test('appReducer aplica cada slice sin pisar el otro', () {
    final initial = AppState.initial();

    final afterTheme = appReducer(initial, ChangeThemeMode(AppThemeMode.dark));
    expect(afterTheme.settings.themeMode, AppThemeMode.dark);
    expect(afterTheme.auth, initial.auth); // auth intacto

    final afterLogin = appReducer(
      afterTheme,
      LoginSucceeded(
        userInfo: UserModel(id: "id-1", email: 'test@redux.com'),
      ),
    );
    expect(afterLogin.auth.userInfo?.email, 'test@redux.com');
    expect(
      afterLogin.settings.themeMode,
      AppThemeMode.dark,
    ); // settings intacto
  });
}
