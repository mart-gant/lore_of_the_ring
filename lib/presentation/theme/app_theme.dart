
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define our Middle-earth inspired colors
  static const Color parchment = Color(0xFFFBF5E6); // A light, parchment-like background
  static const Color darkWood = Color(0xFF3E2C1D);      // A dark brown for text, like old ink
  static const Color elvishGreen = Color(0xFF2E7D32);  // A deep green for buttons and accents
  static const Color gondorGold = Color(0xFFFFC107);    // A gold color for highlights

  static ThemeData get theme {
    return ThemeData(
      // Core colors
      primaryColor: elvishGreen,
      scaffoldBackgroundColor: parchment,

      // Font and Text Theme using Google Fonts
      textTheme: GoogleFonts.merriweatherTextTheme().apply(
        bodyColor: darkWood,
        displayColor: darkWood,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkWood),
        titleTextStyle: GoogleFonts.merriweather(
          color: darkWood,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),

      // ElevatedButton Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: elvishGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.merriweather(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
