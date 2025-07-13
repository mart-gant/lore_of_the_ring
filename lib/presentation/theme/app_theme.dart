
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF2E7D32),
      scaffoldBackgroundColor: const Color(0xFF1B1B1B),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF3E2723),
        foregroundColor: Colors.amber,
        elevation: 2,
      ),
      textTheme: GoogleFonts.medievalSharpTextTheme().apply(
        bodyColor: Colors.amber[100],
        displayColor: Colors.amber[100],
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.brown[300],
        primary: const Color(0xFF2E7D32),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber[800],
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
