import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  colorScheme: const ColorScheme.light(
    inversePrimary: Color(0xFFFFF6E0), // fonts colors
    surface: Color(0xFFFFB800), // upper surface
    tertiary:
        Color(0xFFFFCD4D), // Secondary color, a lighter shade from primary
    primary: Color(0xFFFF9100), // Darker shade of primary for tertiary
    secondary: Color(
        0xFFFF9100), // Using a similar dark shade from primary for inverse
  ),
);
