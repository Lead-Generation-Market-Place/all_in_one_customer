import 'package:flutter/material.dart';

final itServicesTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF8FAFD), // Light blueish gray background
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF2D5BFF), // Professional blue
    secondary: Color(0xFF00C2FF), // Tech accent blue
    tertiary: Color(0xFF6C47FF), // Purple accent
  ),
  appBarTheme: AppBarTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    shadowColor: const Color(0xFF2D5BFF).withOpacity(0.3),
    elevation: 3,
    actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
    iconTheme: const IconThemeData(color: Color(0xFF2D5BFF)),
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey[300],
    indent: 16,
    endIndent: 16,
    thickness: 0.8,
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    shadowColor: const Color(0xFF2D5BFF).withOpacity(0.15),
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
    ),
    margin: const EdgeInsets.all(4),
  ),
  // CardThemeData(
  //   color: Colors.white,
  //   shadowColor: Colors.cyan.withOpacity(0.2),
  //   elevation: 2,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(12),
  //     side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
  //   ),
  //   margin: const EdgeInsets.all(2),
  // ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      letterSpacing: 0.8,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF1A2B6D),
    ),
    titleMedium: TextStyle(
      letterSpacing: 0.8,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF1A2B6D),
    ),
    titleLarge: TextStyle(
      letterSpacing: 0.8,
      fontSize: 28,
      fontWeight: FontWeight.w800,
      color: const Color(0xFF1A2B6D),
    ),
    bodySmall: TextStyle(
      letterSpacing: 0.4,
      wordSpacing: 1.2,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.grey[800],
    ),
    bodyMedium: TextStyle(
      letterSpacing: 0.4,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.grey[800],
    ),
    bodyLarge: TextStyle(
      letterSpacing: 0.4,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF1A2B6D).withOpacity(0.8),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: const Color(0xFF6B7280),
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(
      color: Colors.grey[600], 
      fontSize: 14,
    ),
    fillColor: const Color(0xFFF1F5F9), // Light blue-gray background
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    iconColor: const Color(0xFF2D5BFF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF2D5BFF), width: 1.5),
    ),
    filled: true,
    errorStyle: const TextStyle(
      color: Colors.red,
      fontSize: 12,
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
      elevation: MaterialStateProperty.all(4),
    ),
    textStyle: TextStyle(
      letterSpacing: 0.4,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF1A2B6D),
    ),
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    buttonColor: const Color(0xFF2D5BFF),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2D5BFF),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF2D5BFF),
      side: const BorderSide(color: Color(0xFF2D5BFF), width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: const Color(0xFFEFF4FF),
    labelStyle: const TextStyle(
      color: Color(0xFF2D5BFF),
      fontWeight: FontWeight.w500,
    ),
    iconTheme: const IconThemeData(color: Color(0xFF2D5BFF), size: 18),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  listTileTheme: ListTileThemeData(
    iconColor: const Color(0xFF2D5BFF),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);