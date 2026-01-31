import 'package:flutter/material.dart';

class EnXStyle {
  static const Color primaryBlue = Color(0xFF1D2A4E);
  static const Color backgroundBlack = Color(0xFF020306);

  static ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: backgroundBlack,
    // Remove a cor roxa (seed color) e define as cores de foco
    colorScheme: ColorScheme.dark(
      primary: Colors.white, // Cor do cursor e foco
      secondary: primaryBlue,
    ),
    // Estilo global dos campos de texto (Input)
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryBlue),
        borderRadius: BorderRadius.zero,
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.zero,
      ),
    ),
  );
}
