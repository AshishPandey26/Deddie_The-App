import 'package:flutter/material.dart';
import 'dart:ui';

class FrostTheme {
  // Vibrant Colors with Frosted Effect
  static const Color primaryColor = Color(0xFF7C4DFF); // Vibrant Purple
  static const Color secondaryColor = Color(0xFF00E5FF); // Electric Blue
  static const Color accentColor = Color(0xFFFF4081); // Hot Pink
  static const Color successColor = Color(0xFF00E676); // Vibrant Green
  static const Color warningColor = Color(0xFFFFD740); // Bright Yellow
  static const Color backgroundColor = Color(0xFFF8F9FE); // Light Background
  static const Color textColor = Color(0xFF2C3E50); // Deep Blue Grey

  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF8F9FE), Color(0xFFE8EEFF)],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7C4DFF), Color(0xFF9E6FFF)],
  );

  // Frosted Container Decoration
  static BoxDecoration getFrostedDecoration({
    Color? color,
    double? borderRadius,
  }) {
    return BoxDecoration(
      color: (color ?? Colors.white).withOpacity(0.1),
      borderRadius: BorderRadius.circular(borderRadius ?? 20),
      border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    );
  }

  // Theme Data
  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: primaryColor,
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
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  // Add this property to the FrostTheme class
  static List<BoxShadow> cuteShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      spreadRadius: 2,
    ),
  ];
}

// Frosted Glass Container Widget
class FrostedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? borderRadius;

  const FrostedContainer({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding,
          decoration: FrostTheme.getFrostedDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}
