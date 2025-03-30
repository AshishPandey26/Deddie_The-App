import 'package:flutter/material.dart';

class KawaiiTheme {
  // Pastel Colors
  static const Color primaryPink = Color(0xFFFF9FB2); // Soft Pink
  static const Color secondaryMint = Color(0xFF95E1D3); // Mint Green
  static const Color accentYellow = Color(0xFFFFE5B4); // Pastel Yellow
  static const Color pastelPurple = Color(0xFFE0BBE4); // Soft Purple
  static const Color pastelBlue = Color(0xFFBBE4E9); // Soft Blue
  static const Color backgroundColor = Color(
    0xFFFFF6F6,
  ); // Light Pink Background
  static const Color textColor = Color(0xFF6B5876); // Soft Purple Text

  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFF6F6), Color(0xFFFFE9EC)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFFFF0F3)],
  );

  // Shadows
  static List<BoxShadow> cuteShadow = [
    BoxShadow(
      color: primaryPink.withOpacity(0.2),
      offset: const Offset(2, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.white.withOpacity(0.7),
      offset: const Offset(-2, -2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  // Theme Data
  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: primaryPink,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: textColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPink,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  // Custom Decorations
  static BoxDecoration cardDecoration = BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(20),
    boxShadow: cuteShadow,
  );

  static BoxDecoration buttonDecoration = BoxDecoration(
    color: primaryPink,
    borderRadius: BorderRadius.circular(20),
    boxShadow: cuteShadow,
  );
}
