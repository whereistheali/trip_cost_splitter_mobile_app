import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF66BB6A);

  static const Color secondaryLight = Color(0xFF2196F3);
  static const Color secondaryDark = Color(0xFF42A5F5);

  static const Color accentLight = Color(0xFFFF9800);
  static const Color accentDark = Color(0xFFFFB74D);

  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);

  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2D2D2D);

  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);

  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  static const Color splashGradientStart = Color(0xFF4CAF50);
  static const Color splashGradientEnd = Color(0xFF2196F3);

  static const Color errorColor = Color(0xFFE53935);
  static const Color successColor = Color(0xFF43A047);
}

class AppGradients {
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.splashGradientStart, AppColors.splashGradientEnd],
  );

  static const LinearGradient onboardingGradient1 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFE8F5E9), Color(0xFFFFFFFF)],
  );

  static const LinearGradient onboardingGradient2 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
  );

  static const LinearGradient onboardingGradient3 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFF3E0), Color(0xFFFFFFFF)],
  );
}
