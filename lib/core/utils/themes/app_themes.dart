import 'package:flutter/material.dart';

import '../app_colors.dart';

class AppTheme {
  static const montserrat = 'Montserrat';
  static const dmSans = 'DMSans';
  static const montserratAlternate = 'MontserratAlternates';

  //? light text mode
  static TextTheme lightTextTheme = const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: AppColors.blackText,
        fontFamily: montserrat,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: AppColors.blackText,
        fontFamily: montserrat,
      ),
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w700,
        fontFamily: montserrat,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 21,
        fontFamily: montserrat,
      ),
      displaySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.blackText,
        fontFamily: montserrat,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.blackSupplementary,
        fontFamily: montserrat,
      ));

  //? dark text mode
  static TextTheme darkTextTheme = const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 21,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.blackSupplementary));

  //? light Mode
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
      ),
      appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black, backgroundColor: Colors.white),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.black, foregroundColor: Colors.white),
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(selectedItemColor: Colors.green),
      textTheme: lightTextTheme,
    );
  }

  //! dark Mode
  static ThemeData darkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.green),
        textTheme: darkTextTheme,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.green, foregroundColor: Colors.white));
  }
}
