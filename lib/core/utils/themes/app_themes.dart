import 'package:flutter/material.dart';

import '../app_colors.dart';

class AppTheme {
  // static const _prompt = 'Prompt';
  // static const _crashGrotesk = 'Crash Grotesk';

  //? light text mode
  static TextTheme lightTextTheme = TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        // color: AppColors.grey500,
        // fontFamily: _crashGrotesk,
        height: 1.4,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        // color: AppColors.warning500,
        // fontFamily: _crashGrotesk,
        height: 1.45,
      ),
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w700,
        // color: AppColors.grey700,
        // fontFamily: _prompt,
        height: 1.2,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 21,
        // color: AppColors.grey700,
        // fontFamily: _prompt,
      ),
      displaySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        // color: AppColors.shadeWhite,
        height: 1.45,
        // fontFamily: _crashGrotesk,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        // fontFamily: _prompt,
      ));

  //? dark text mode
  static TextTheme darkTextTheme = TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        // fontFamily: _crashGrotesk
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
        color: Colors.white,
      ));

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
