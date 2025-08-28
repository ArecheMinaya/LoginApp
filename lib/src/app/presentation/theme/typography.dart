import 'package:flutter/material.dart';

TextTheme buildAppTextTheme(Brightness brightness) {
  final base = brightness == Brightness.light
      ? Typography.blackMountainView
      : Typography.whiteMountainView;

  // Ajustes suaves: pesos, tamaños prácticos y alturas de línea
  final typography = base.copyWith(
    // Titulares
    headlineLarge: base.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
    headlineMedium: base.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
    headlineSmall: base.headlineSmall?.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),

    // Títulos (para AppBar / secciones)
    titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    titleSmall: base.titleSmall?.copyWith(fontWeight: FontWeight.w600),

    // Cuerpo
    bodyLarge: base.bodyLarge?.copyWith(fontSize: 16, height: 1.45),
    bodyMedium: base.bodyMedium?.copyWith(fontSize: 14, height: 1.5),
    bodySmall: base.bodySmall?.copyWith(height: 1.45),

    // Labels (botones, chips)
    labelLarge: base.labelLarge?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
    labelMedium: base.labelMedium?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
    labelSmall: base.labelSmall?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
  );

  return typography;
}
