import 'package:redux/redux.dart';
import 'settings_state.dart';
import 'settings_actions.dart';

final Reducer<SettingsState> settingsReducer = combineReducers<SettingsState>([
  TypedReducer<SettingsState, ChangeThemeMode>(
    (s, a) => s.copyWith(themeMode: a.themeMode),
  ).call,
]);
