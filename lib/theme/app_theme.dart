import 'package:flutter/material.dart';
import 'theme_extension.dart';

class AppTheme {
  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    primary: Color(0xFFE50A17),
    onPrimary: Colors.white,

    secondary: Color(0xFFB0BEC5),
    onSecondary: Color(0xFF212121),

    background: Color(0xFF141414),
    onBackground: Color(0xFFFFFFFF),

    surface: Color(0xFF2A2A2A),
    onSurface: Color(0xFFFFFFFF),

    error: Color(0xFFCF6679),
    onError: Color(0xFF141414),
  );

  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,

    primary: Color(0xFFE50A17),
    onPrimary: Colors.black,

    secondary: Color(0xFF455A64),
    onSecondary: Colors.white,

    background: Color(0xFFF7F7F7),
    onBackground: Color(0xFF212121),

    surface: Colors.white,
    onSurface: Color(0xFF212121),

    error: Color(0xFFB00020),
    onError: Colors.white,
  );

  static final _textTheme = TextTheme(
    headlineLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headlineMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headlineSmall: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    bodyLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    bodySmall: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    labelLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      scaffoldBackgroundColor: _lightColorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: _lightColorScheme.surface,
        foregroundColor: _lightColorScheme.onSurface,
        elevation: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _lightColorScheme.primary,
          foregroundColor: _lightColorScheme.onPrimary,
          textStyle: _textTheme.labelLarge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        color: _lightColorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: _lightColorScheme.surface,
      ),
      extensions: const <ThemeExtension>[CustomThemeExtension()],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      scaffoldBackgroundColor: _darkColorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: _darkColorScheme.surface,
        foregroundColor: _darkColorScheme.onSurface,
        elevation: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkColorScheme.primary,
          foregroundColor: _darkColorScheme.onPrimary,
          textStyle: _textTheme.labelLarge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        color: _darkColorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: _darkColorScheme.surface,
      ),
      extensions: const <ThemeExtension>[CustomThemeExtension()],
    );
  }
}
