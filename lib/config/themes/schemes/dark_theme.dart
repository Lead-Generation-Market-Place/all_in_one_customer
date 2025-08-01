import 'package:flutter/material.dart';
import 'package:yelpax/core/constants/app_colors.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.dark,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white70),
    hintStyle: TextStyle(color: Colors.white70),
    fillColor: Colors.grey[850],
    iconColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.blueAccent, width: 1.8),
    ),
    filled: true,

    errorStyle: const TextStyle(
      color: Colors.red,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
  ),
  cardColor: Colors.grey[850],
  textTheme: TextTheme(
    titleSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  ),
);
