import 'package:login_app/src/features/auth/redux/auth_reducer.dart';
import 'package:login_app/src/features/settings/redux/settings_reducer.dart';
import 'package:redux/redux.dart';
import 'app_state.dart';

final Reducer<AppState> appReducer = combineReducers<AppState>([
  TypedReducer<AppState, dynamic>(
    (state, action) => state.copyWith(auth: authReducer(state.auth, action)),
  ).call,
  TypedReducer<AppState, dynamic>(
    (s, a) => s.copyWith(settings: settingsReducer(s.settings, a)),
  ).call,
]);
