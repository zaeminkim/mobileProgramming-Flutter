import 'package:flutter/material.dart';

/// Outfeed 네온 탈출 디자인 시스템
class AppColors {
  // 배경
  static const deepNavy = Color(0xFF0B0F1A);
  static const deepNavyLight = Color(0xFF111827);
  static const cardDark = Color(0xFF141B2D);
  static const cardDarkLight = Color(0xFF1A2332);
  static const surfaceDark = Color(0xFF0D1321);

  // 메인 그라디언트 (네온 블루 → 네온 그린)
  static const neonBlue = Color(0xFF0000FF);
  static const neonGreen = Color(0xFF00FF00);

  // 포인트 컬러
  static const lime = Color(0xFFC0FF00);
  static const cyan = Color(0xFF00FFFF);

  // 텍스트
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB0BEC5);
  static const textMuted = Color(0xFF546E7A);

  // 네온 글로우 컬러 (약간 투명)
  static Color neonBlueGlow = neonBlue.withOpacity(0.3);
  static Color neonGreenGlow = neonGreen.withOpacity(0.3);
  static Color limeGlow = lime.withOpacity(0.3);
  static Color cyanGlow = cyan.withOpacity(0.3);

  // 메인 그라디언트
  static const mainGradient = LinearGradient(
    colors: [neonBlue, neonGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const mainGradientHorizontal = LinearGradient(
    colors: [neonBlue, Color(0xFF0066FF), Color(0xFF00CC66), neonGreen],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const subtleGradient = LinearGradient(
    colors: [Color(0xFF0033AA), Color(0xFF00AA44)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.deepNavy,
      primaryColor: AppColors.neonBlue,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonBlue,
        secondary: AppColors.neonGreen,
        surface: AppColors.cardDark,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.deepNavy,
        onSurface: AppColors.textPrimary,
      ),
      fontFamily: 'Pretendard',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textMuted,
          letterSpacing: 0.5,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}

/// 네온 글로우 박스 데코레이션 유틸
class NeonDecoration {
  static BoxDecoration glowBox({
    Color glowColor = AppColors.neonBlue,
    double blurRadius = 20,
    double borderRadius = 16,
    Color? bgColor,
  }) {
    return BoxDecoration(
      color: bgColor ?? AppColors.cardDark,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: glowColor.withOpacity(0.3), width: 1),
      boxShadow: [
        BoxShadow(
          color: glowColor.withOpacity(0.15),
          blurRadius: blurRadius,
          spreadRadius: 0,
        ),
      ],
    );
  }

  static BoxDecoration gradientGlowBox({
    double borderRadius = 16,
    double blurRadius = 24,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      gradient: AppColors.subtleGradient,
      boxShadow: [
        BoxShadow(
          color: AppColors.neonBlue.withOpacity(0.2),
          blurRadius: blurRadius,
          offset: const Offset(-4, 0),
        ),
        BoxShadow(
          color: AppColors.neonGreen.withOpacity(0.2),
          blurRadius: blurRadius,
          offset: const Offset(4, 0),
        ),
      ],
    );
  }
}
