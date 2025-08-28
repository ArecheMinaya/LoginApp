typedef Validator = String? Function(String? value);

class AppValidators {
  static Validator required([String fieldName = 'Este campo']) {
    return (value) {
      final v = value?.trim() ?? '';
      if (v.isEmpty) return '$fieldName es obligatorio';
      return null;
    };
  }

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Ingresa tu correo';
    // Regex simple y práctica para emails comunes
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(v)) return 'Correo inválido';
    return null;
  }

  static Validator password({
    int minLength = 8,
    bool requireUpper = true,
    bool requireLower = true,
    bool requireNumber = true,
    bool requireSpecial = true,
    bool noSpaces = true,
  }) {
    return (value) {
      final v = value ?? '';
      if (v.isEmpty) return 'Ingresa tu contraseña';
      if (noSpaces && RegExp(r'\s').hasMatch(v)) {
        return 'La contraseña no debe contener espacios';
      }
      if (v.length < minLength) {
        return 'Debe tener al menos $minLength caracteres';
      }
      if (requireUpper && !RegExp(r'[A-Z]').hasMatch(v)) {
        return 'Debe incluir al menos una mayúscula';
      }
      if (requireLower && !RegExp(r'[a-z]').hasMatch(v)) {
        return 'Debe incluir al menos una minúscula';
      }
      if (requireNumber && !RegExp(r'[0-9]').hasMatch(v)) {
        return 'Debe incluir al menos un número';
      }
      return null;
      // if (requireSpecial && !RegExp(r'[!@#\$%^&*(),.?":{}|<>\-_/\\\[\]=+;\'`~]').hasMatch(v)) {
      //   return 'Debe incluir al menos un carácter especial';
      // }
      // return null;
    };
  }
}
