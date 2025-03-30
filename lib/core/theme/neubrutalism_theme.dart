import 'package:flutter/material.dart';

class NeubrutalismTheme {
  // Bold, vibrant colors
  static const Color primaryColor = Color(0xFF2B54FF); // Electric Blue
  static const Color secondaryColor = Color(0xFFFF3D57); // Vibrant Red
  static const Color accentColor = Color(0xFFFFCA28); // Bold Yellow
  static const Color backgroundColor = Color(0xFFF0F2F5); // Light Gray
  static const Color textColor = Color(0xFF1A1A1A); // Almost Black
  static const Color successColor = Color(0xFF00C853); // Bright Green
  static const Color warningColor = Color(0xFFFF9100); // Bold Orange

  // Brutalist Box Decoration
  static BoxDecoration getBrutalBoxDecoration({
    Color? color,
    double? borderRadius = 0,
  }) {
    return BoxDecoration(
      color: color ?? Colors.white,
      border: Border.all(color: Colors.black, width: 2),
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      boxShadow: const [
        BoxShadow(color: Colors.black, offset: Offset(4, 4), blurRadius: 0),
      ],
    );
  }

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2B54FF), Color(0xFF4466FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

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
          height: 1.2,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: textColor, height: 1.5),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}

// Brutalist Container Widget
class BrutalContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const BrutalContainer({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: NeubrutalismTheme.getBrutalBoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
