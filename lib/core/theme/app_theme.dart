import 'package:flutter/material.dart';

class AppTheme {
  // Mocha-inspired color palette
  static const Color primaryColor = Color(0xFF9A6FB0); // Lavender
  static const Color secondaryColor = Color(0xFFBE8C63); // Mocha
  static const Color accentColor = Color(0xFFE6B17E); // Caramel
  static const Color backgroundColor = Color(0xFFFDF6EC); // Cream
  static const Color textColor = Color(0xFF3C2A21); // Dark Mocha
  static const Color cardColor = Color(0xFFFAF3E0); // Light Cream

  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFDF6EC), Color(0xFFF8ECD8)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF9A6FB0), Color(0xFFBE8C63)],
  );

  // Neurobrutalism shadow with softer edges
  static final List<BoxShadow> mochaShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      offset: const Offset(4, 4),
      blurRadius: 2,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(2, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: textColor,
          height: 1.2,
        ),
        bodyLarge: TextStyle(fontSize: 18, color: textColor, height: 1.5),
      ),
    );
  }
}
