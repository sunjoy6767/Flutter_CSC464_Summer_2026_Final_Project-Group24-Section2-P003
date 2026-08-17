import 'package:flutter/material.dart';

/// ByteShop's app-wide theme: a dark, cool-toned tech/electronics look
/// (navy/slate surfaces) with a single blue accent color.
class AppTheme {
  AppTheme._();

  static const Color _background = Color(0xFF0B1220);
  static const Color _surface = Color(0xFF141B2A);
  static const Color _surfaceVariant = Color(0xFF1D2637);
  static const Color _outline = Color(0xFF29344A);
  static const Color _accent = Color(0xFF3DB2FF);
  static const Color _secondary = Color(0xFF64748B);
  static const Color _onSurface = Color(0xFFE2E8F0);
  static const Color _mutedText = Color(0xFF94A3B8);
  static const Color _error = Color(0xFFEF4444);

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _background,
    colorScheme: const ColorScheme.dark(
      primary: _accent,
      onPrimary: Color(0xFF04121F),
      secondary: _secondary,
      onSecondary: Colors.white,
      surface: _surface,
      onSurface: _onSurface,
      error: _error,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: _onSurface,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: _onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: _onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: _onSurface,
      ),
      bodyLarge: TextStyle(fontSize: 15, color: _onSurface),
      bodyMedium: TextStyle(fontSize: 14, color: _mutedText),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: _onSurface,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _background,
      foregroundColor: _onSurface,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: _onSurface,
      ),
    ),
    cardTheme: CardThemeData(
      color: _surfaceVariant,
      elevation: 0,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: _outline),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _accent,
        foregroundColor: const Color(0xFF04121F),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _accent,
        side: const BorderSide(color: _accent),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: _accent),
    ),
    iconTheme: const IconThemeData(color: _onSurface),
    dividerTheme: const DividerThemeData(color: _outline, thickness: 1),
  );
}
