import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const ink = Color(0xFF050507);
  static const surface = Color(0xFF111116);
  static const surfaceBright = Color(0xFF1B1B24);

  static const neonRed = Color(0xFFFF1744);
  static const templeRed = Color(0xFFC1121F);
  static const ember = Color(0xFFFF6A00);
  static const purple = Color(0xFF8A2BE2);
  static const hotPink = Color(0xFFFF2D95);
  static const paper = Color(0xFFD8B98A);

  static const text = Color(0xFFF5F7FB);
  static const muted = Color(0xFFAAB2C5);

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: neonRed,
      brightness: Brightness.dark,
      surface: surface,
      primary: neonRed,
      secondary: ember,
      tertiary: purple,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ink,
      colorScheme: colorScheme,

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: text,
        elevation: 0,
        centerTitle: false,
      ),

      textTheme: const TextTheme(
        displaySmall: TextStyle(
          color: text,
          fontSize: 42,
          fontWeight: FontWeight.w900,
          height: 1,
          letterSpacing: -1.2,
        ),
        headlineMedium: TextStyle(
          color: text,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.6,
        ),
        titleLarge: TextStyle(
          color: text,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
        bodyLarge: TextStyle(
          color: text,
          fontSize: 16,
          height: 1.45,
        ),
        bodyMedium: TextStyle(
          color: muted,
          fontSize: 14,
          height: 1.4,
        ),
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: neonRed.withValues(alpha: 0.18),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            color: muted,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}