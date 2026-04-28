import 'package:flutter/material.dart';

/// Outfeed 디자인 시스템 — Apple HIG 미니멀리즘
class AppColors {
  AppColors._();

  // Core
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);

  // Surfaces (iOS System Dark)
  static const surface = Color(0xFF1C1C1E);
  static const surfaceSecondary = Color(0xFF2C2C2E);
  static const surfaceTertiary = Color(0xFF3A3A3C);

  // Text
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF8E8E93);
  static const textTertiary = Color(0xFF636366);

  // Brand Accent — OUTFEED 아이덴티티 컬러 (teal → green)
  static const accentTeal = Color(0xFF2EC4B6);
  static const accentGreen = Color(0xFF7FD48A);

  // Semantic
  static const separator = Color(0xFF38383A);

  // Brand Gradient — teal-cyan → soft-green
  static const brandGradient = LinearGradient(
    colors: [accentTeal, accentGreen],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.black,
      primaryColor: AppColors.accentTeal,
      fontFamily: '.SF Pro Text',
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentTeal,
        secondary: AppColors.accentGreen,
        surface: AppColors.surface,
        onPrimary: AppColors.white,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w700,
          color: AppColors.textPrimary, letterSpacing: -0.4),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700,
          color: AppColors.textPrimary, letterSpacing: -0.3),
        headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700,
          color: AppColors.textPrimary),
        headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary),
        titleLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary),
        titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary),
        bodyLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w400,
          color: AppColors.textSecondary, height: 1.5),
        bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,
          color: AppColors.textSecondary, height: 1.4),
        bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400,
          color: AppColors.textTertiary),
        labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500,
          color: AppColors.textTertiary, letterSpacing: 0.5),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.black,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
      ),
    );
  }
}
