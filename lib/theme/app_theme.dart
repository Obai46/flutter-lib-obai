import 'package:flutter/material.dart';

import '../core/constant/app_colors.dart';

class AppTheme {
/* Light Theme */
  static ThemeData customLightTheme = ThemeData.light().copyWith(
    primaryColorLight: AppColors.gradientStart,
    primaryColor: AppColors.gradientStart,
    //AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.gradientStart,
      iconTheme: IconThemeData(color: AppColors.white),
      elevation: 2,
    ),
    // Text Theme
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Cairo",
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontFamily: "Cairo",
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontFamily: "Cairo",
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Cairo",
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Cairo",
        color: AppColors.white,
      ),
      headlineMedium: TextStyle(
        fontFamily: "Cairo",
        fontSize: 18,
        color: AppColors.black,
      ),
      headlineSmall: TextStyle(
        fontFamily: "Cairo",
        fontSize: 14,
        color: AppColors.black,
      ),
    ),
  );

/* Dark Theme */
  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
    primaryColorDark: AppColors.gradientEnd,
    primaryColor: AppColors.gradientEnd,
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.gradientEnd,
      elevation: 2,
      iconTheme: IconThemeData(
        color: AppColors.textWhite70,
      ),
    ),

    // Text Theme
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Cairo",
        color: AppColors.textWhite70,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontFamily: "Cairo",
        color: AppColors.textWhite70,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontFamily: "Cairo",
        color: AppColors.textWhite70,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Cairo",
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textWhite70,
      ),
      bodySmall: TextStyle(
        fontFamily: "Cairo",
        color: AppColors.textWhite70,
      ),
      headlineMedium: TextStyle(
        fontFamily: "Cairo",
        fontSize: 18,
        color: AppColors.textWhite70,
      ),
      headlineSmall: TextStyle(
        fontFamily: "Cairo",
        fontSize: 14,
        color: AppColors.textWhite70,
      ),
    ),
  );
}
