class Env {
  static String environment = const String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'DEV',
  );
}
