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
      letterSpacing: 0.8,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      letterSpacing: 0.8,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      letterSpacing: 0.8,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      letterSpacing: 0.4,
      wordSpacing: 1.2,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.grey[850],
    ),
    bodyMedium: TextStyle(
      letterSpacing: 0.4,
      fontSize: 17,
      fontWeight: FontWeight.normal,
      color: Colors.grey[850],
    ),
    bodyLarge: TextStyle(
      letterSpacing: 0.4,
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Colors.black45,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: const Color.fromRGBO(158, 158, 158, 1),
      fontSize: 11,
    ),
    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
    fillColor: Colors.grey[100], // Light cyan background
    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    iconColor: Colors.cyan[800],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),
    // focusedBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(12),
    //   borderSide: BorderSide(color: Colors.cyan[800]!, width: 1.8),
    // ),
    filled: true,
    errorStyle: const TextStyle(
      color: Colors.red,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
  ),

  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        gapPadding: 8,
      ),
    ),
    menuStyle: MenuStyle(
      backgroundColor: MaterialStateProperty.all(Colors.white),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textStyle: TextStyle(
      letterSpacing: 0.4,
      fontSize: 17,
      fontWeight: FontWeight.normal,
      color: Colors.grey[850],
    ),
  ),
);
