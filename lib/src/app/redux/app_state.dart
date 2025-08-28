import 'package:flutter/material.dart';
import 'package:login_app/src/features/settings/redux/settings_state.dart';

// Importa los estados de cada feature
import '../../features/auth/redux/auth_state.dart';

@immutable
class AppState {
  final AuthState auth;
  final SettingsState settings;

  const AppState({required this.auth, required this.settings});

  factory AppState.initial() =>
      AppState(auth: AuthState.initial(), settings: SettingsState.initial());

  AppState copyWith({AuthState? auth, SettingsState? settings}) {
    return AppState(
      auth: auth ?? this.auth,
      settings: settings ?? this.settings,
    );
  }

  // ---- Persistencia ----
  Map<String, dynamic> toJson() => {
    'auth': auth.toJson(),
    'settings': settings.toJson(),
  };

  static AppState fromJson(Map<String, dynamic> json) {
    final authJson = Map<String, dynamic>.from((json['auth'] as Map?) ?? {});
    final settingsJson = Map<String, dynamic>.from(
      (json['settings'] as Map?) ?? {},
    );
    return AppState(
      auth: AuthState.fromJson(authJson),
      settings: SettingsState.fromJson(settingsJson),
    );
  }
}
