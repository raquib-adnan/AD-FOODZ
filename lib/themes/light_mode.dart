import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  colorScheme: const ColorScheme.light(
    inversePrimary: Color(
        0xFF333333), // Dark Gray for text colors (font), resembling Swiggy's strong and bold branding
    surface: Color(
        0xFFF5F5F5), // Light Gray for the surface, soft and neutral background
    tertiary: Color(
        0xFFFF5722), // Swiggy Orange for buttons, highlights, representing the brand's energetic and lively nature
    primary: Color(
        0xFFFA6400), // Bright Orange for primary elements, matching Swiggy's vibrant and eye-catching look
    secondary: Color(
        0xFFE65100), // Deep Orange for secondary elements, adding richness and warmth
  ),
);
