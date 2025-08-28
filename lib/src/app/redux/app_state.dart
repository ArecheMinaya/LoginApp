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
  static const _schemaVersion = 1;
  Map<String, dynamic> toJson() => {
    '_v': _schemaVersion,
    'auth': auth.toJson(),
    'settings': settings.toJson(),
  };

  static AppState fromJson(dynamic json) {
    final authJson = (json['auth'] as Map?) ?? const <String, dynamic>{};
    final settingsJson =
        (json['settings'] as Map?) ?? const <String, dynamic>{};

    return AppState(
      auth: AuthState.fromJson(Map<String, dynamic>.from(authJson)),
      settings: SettingsState.fromJson(Map<String, dynamic>.from(settingsJson)),
    );
  }
}
