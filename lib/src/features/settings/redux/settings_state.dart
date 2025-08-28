enum AppThemeMode { system, light, dark }

class SettingsState {
  final AppThemeMode themeMode;

  const SettingsState({this.themeMode = AppThemeMode.system});

  factory SettingsState.initial() => const SettingsState();

  SettingsState copyWith({AppThemeMode? themeMode}) {
    return SettingsState(themeMode: themeMode ?? this.themeMode);
  }

  Map<String, dynamic> toJson() => {'themeMode': themeMode.index};

  static SettingsState fromJson(Map<String, dynamic> json) {
    return SettingsState(
      themeMode: AppThemeMode.values[(json['themeMode'] ?? 0) as int],
    );
  }
}
