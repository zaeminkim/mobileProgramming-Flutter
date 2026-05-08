import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Outfeed 디자인 시스템 — Apple HIG 미니멀리즘
class AppColors {
  AppColors._();

  // Core
  static const black = Color(0xFF0D0D0F);
  static const white = Color(0xFFFFFFFF);

  // Surfaces (Premium Dark)
  static const surface = Color(0xFF1A1A1E);
  static const surfaceSecondary = Color(0xFF242429);
  static const surfaceTertiary = Color(0xFF2E2E35);

  // Text
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF9E9EA4);
  static const textTertiary = Color(0xFF636369);

  // Brand Accent — OUTFEED 아이덴티티 컬러 (teal → green)
  static const accentTeal = Color(0xFF2EC4B6);
  static const accentGreen = Color(0xFF7FD48A);
  static const accentMint = Color(0xFF6FEDD6);

  // Semantic
  static const separator = Color(0xFF252528);

  // Brand Gradient — teal-cyan → soft-green
  static const brandGradient = LinearGradient(
    colors: [accentTeal, accentGreen],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Premium Gradient — mint → teal
  static const mintGradient = LinearGradient(
    colors: [Color(0xFF00E5BF), accentMint],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// 카드 기본 BoxDecoration
  static BoxDecoration cardDecoration({
    double radius = 20,
    Color? color,
  }) {
    return BoxDecoration(
      color: color ?? surface,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final baseTextTheme = GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    );

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.black,
      primaryColor: AppColors.accentTeal,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentTeal,
        secondary: AppColors.accentGreen,
        surface: AppColors.surface,
        onPrimary: AppColors.white,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          fontSize: 34, fontWeight: FontWeight.w800,
          color: AppColors.textPrimary, letterSpacing: -0.5,
        ),
        displayMedium: baseTextTheme.displayMedium?.copyWith(
          fontSize: 28, fontWeight: FontWeight.w800,
          color: AppColors.textPrimary, letterSpacing: -0.3,
        ),
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(
          fontSize: 22, fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          fontSize: 20, fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          fontSize: 18, fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          fontSize: 15, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          fontSize: 17, fontWeight: FontWeight.w400,
          color: AppColors.textSecondary, height: 1.5,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          fontSize: 15, fontWeight: FontWeight.w400,
          color: AppColors.textSecondary, height: 1.4,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          fontSize: 13, fontWeight: FontWeight.w400,
          color: AppColors.textTertiary,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          fontSize: 15, fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        labelSmall: baseTextTheme.labelSmall?.copyWith(
          fontSize: 11, fontWeight: FontWeight.w500,
          color: AppColors.textTertiary, letterSpacing: 0.5,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.black,
        selectedItemColor: AppColors.accentTeal,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w400),
      ),
    );
  }
}
