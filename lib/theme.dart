import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color bg = Color(0xFFFBF4E6);
  static const Color card = Color(0xFFFFFDF7);
  static const Color cardAlt = Color(0xFFF6ECDA);
  static const Color ink = Color(0xFF4A4038);
  static const Color inkSoft = Color(0xFF93867A);
  static const Color line = Color(0xFFE7DAC4);

  static const Color coral = Color(0xFFE8776D);
  static const Color coralSoft = Color(0xFFF7C9C4);
  static const Color pink = Color(0xFFF0A8B4);
  static const Color green = Color(0xFF7BA37E);
  static const Color greenSoft = Color(0xFFCBE0C8);
  static const Color blue = Color(0xFF7FA6C9);
  static const Color blueSoft = Color(0xFFCFE0EE);
  static const Color yellow = Color(0xFFE7C063);
  static const Color sun = Color(0xFFF5C24B);
}

ThemeData buildAppTheme() {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: AppColors.coral,
    brightness: Brightness.light,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme.copyWith(
      primary: AppColors.coral,
      secondary: AppColors.green,
      surface: AppColors.bg,
    ),
    scaffoldBackgroundColor: AppColors.bg,
    splashFactory: InkRipple.splashFactory,
  );
}
