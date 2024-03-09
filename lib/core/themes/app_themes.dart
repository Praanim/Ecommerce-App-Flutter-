import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///class defining the theme of the project
class AppTheme {
  ///LightTheme
  static final ThemeData lightThemeData = ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      // primaryColor: LightColor.primaryColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          // backgroundColor: LightColor.primaryColor,
          unselectedItemColor: LightColor.secondaryColor,
          selectedItemColor: LightColor.primaryColor,
          selectedLabelStyle: TextStyle(
              color: LightColor.secondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(
            color: LightColor.secondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
      brightness: Brightness.light,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: LightColor.secondaryColor,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          color: LightColor.secondaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: LightColor.secondaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: LightColor.secondaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: LightColor.secondaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          color: LightColor.secondaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: LightColor.secondaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: LightColor.secondaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: LightColor.secondaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        displayMedium: TextStyle(
          fontSize: 14,
          color: LightColor.lightGrey,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: TextStyle(
          fontSize: 12,
          color: LightColor.lightGrey,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconTheme: const IconThemeData(color: LightColor.primaryColor),
      colorScheme: const ColorScheme.light(
          primary: LightColor.primaryColor,
          secondary: LightColor.secondaryColor,
          tertiary: LightColor.tertiaryColor));
}
