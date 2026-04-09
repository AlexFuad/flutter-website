import 'package:flutter/material.dart';

class AppTheme {
  // Reference design color palette - Dark blue gradient theme
  static const primaryColor = Color(0xFF3B82F6); // Blue 500
  static const secondaryColor = Color(0xFF8B5CF6); // Purple 500
  static const accentColor = Color(0xFF06B6D4); // Cyan 500
  static const darkBg = Color(0xFF0F172A); // Slate 900
  static const darkCard = Color(0xFF1E293B); // Slate 800
  static const darkBorder = Color(0xFF334155); // Slate 700
  static const textPrimary = Color(0xFFF8FAFC); // Slate 50
  static const textSecondary = Color(0xFF94A3B8); // Slate 400
  static const textMuted = Color(0xFF64748B); // Slate 500

  // Glass effect colors
  static const glassBg = Color(0x0DFFFFFF); // rgba(255, 255, 255, 0.05)
  static const glassBorder = Color(0x1AFFFFFF); // rgba(255, 255, 255, 0.1)

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 56,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(fontSize: 18, color: textSecondary),
        bodyMedium: TextStyle(fontSize: 16, color: textSecondary),
      ),
    );
  }

  // Dark theme matching reference design
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: darkBg,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: darkCard,
      ),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimary,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 56,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(fontSize: 18, color: textSecondary),
        bodyMedium: TextStyle(fontSize: 16, color: textSecondary),
      ),
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: darkBorder, width: 1),
        ),
      ),
    );
  }

  // Gradient helper methods
  static LinearGradient get heroGradient {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [darkBg, darkCard, darkBorder],
    );
  }

  static LinearGradient get primaryGradient {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [primaryColor, secondaryColor, accentColor],
    );
  }

  static LinearGradient get buttonGradient {
    return const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [primaryColor, secondaryColor],
    );
  }

  // Glass effect decoration
  static BoxDecoration get glassEffect {
    return BoxDecoration(
      color: glassBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: glassBorder, width: 1),
    );
  }
}
