import 'package:flutter/material.dart';

final homeServicesTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  colorScheme: const ColorScheme.light(primary: Colors.cyan),
  dividerTheme: DividerThemeData(
    color: Colors.grey[300],
    indent: 8,
    endIndent: 8,
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    shadowColor: Colors.cyan.withOpacity(0.2),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
    ),
    margin: const EdgeInsets.all(2),
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    ),
    bodyMedium: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    ),
    bodyLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Colors.black45,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.grey[800]),
    hintStyle: TextStyle(color: Colors.grey[600]),
    fillColor: Colors.white, // Light cyan background
    iconColor: Colors.cyan[800],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey[400]!),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.cyan[800]!, width: 1.8),
    ),
    filled: true,
    errorStyle: const TextStyle(
      color: Colors.red,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
  ),
);
