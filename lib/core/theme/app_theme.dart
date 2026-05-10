import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const ink = Color(0xFF070810);
  static const surface = Color(0xFF111521);
  static const surfaceBright = Color(0xFF1B2131);
  static const acid = Color(0xFFB6FF4D);
  static const cyan = Color(0xFF55E7FF);
  static const rose = Color(0xFFFF5E8A);
  static const ember = Color(0xFFFF8A3D);
  static const text = Color(0xFFF5F7FB);
  static const muted = Color(0xFFAAB2C5);

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: cyan,
      brightness: Brightness.dark,
      surface: surface,
      primary: cyan,
      secondary: acid,
      tertiary: rose,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ink,
      colorScheme: colorScheme,
      fontFamily: 'SF Pro Display',
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
          fontWeight: FontWeight.w800,
          height: 1,
        ),
        headlineMedium: TextStyle(
          color: text,
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
        titleLarge: TextStyle(
          color: text,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(color: text, fontSize: 16, height: 1.45),
        bodyMedium: TextStyle(color: muted, fontSize: 14, height: 1.4),
      ),
    );
  }
}
