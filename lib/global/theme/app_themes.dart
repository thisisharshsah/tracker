import 'package:flutter/material.dart';

enum AppTheme { light, dark }

final appThemeData = {
  AppTheme.light: ThemeData(
    primaryColor: white,
    scaffoldBackgroundColor: white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: const ColorScheme.light(
      primary: blue,
      secondary: red,
      tertiary: secondaryRed,
      surface: green,
      error: red,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: lightDisplayLarge,
    ),
    iconTheme: const IconThemeData(
      color: black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: white,
      selectedItemColor: blue,
      unselectedItemColor: grey,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    cardColor: white,
    hintColor: grey,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: black,
      selectionColor: black,
      selectionHandleColor: black,
    ),
    textTheme: const TextTheme(
      labelSmall: lightLabelSmall,
      labelMedium: lightLabelMedium,
      labelLarge: lightLabelLarge,
      displaySmall: lightDisplaySmall,
      displayMedium: lightDisplayMedium,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      errorStyle: TextStyle(
        fontSize: 12.0,
        color: red,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: TextStyle(
        fontSize: 14.0,
        color: background,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  AppTheme.dark: ThemeData(
    primaryColor: secondaryBlack,
    scaffoldBackgroundColor: black,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(
      primary: blue,
      secondary: red,
      tertiary: secondaryRed,
      surface: green,
      //background
      error: red,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: darkDisplayLarge,
    ),
    iconTheme: const IconThemeData(
      color: white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: black,
      selectedItemColor: blue,
      unselectedItemColor: grey,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    cardColor: secondaryBlack,
    hintColor: grey,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: white,
      selectionColor: white,
      selectionHandleColor: white,
    ),
    textTheme: const TextTheme(
      labelSmall: darkLabelSmall,
      labelMedium: darkLabelMedium,
      labelLarge: darkLabelLarge,
      displaySmall: darkDisplaySmall,
      displayMedium: darkDisplayMedium,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      errorStyle: TextStyle(
        fontSize: 12.0,
        color: red,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: TextStyle(
        fontSize: 14.0,
        color: background,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
};

// Variables

// Colors
const Color blue = Color(0xFF0C5396);
const Color red = Color(0xFFFF0000);
const Color secondaryRed = Color(0xFFE21113);
const Color background = Color(0xFFF8F8F8);
const Color grey = Color(0xFFA0A0A0);
const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF121212);
const Color secondaryBlack = Color(0xFF1A1A1A);
const Color green = Color(0xFF0BAB64);

// Text styles
const TextStyle lightLabelSmall = TextStyle(
  fontSize: 12.0,
  color: black,
  fontWeight: FontWeight.w400,
);
const TextStyle lightLabelMedium = TextStyle(
  fontSize: 14.0,
  color: black,
  fontWeight: FontWeight.w400,
);
const TextStyle lightLabelLarge = TextStyle(
  fontSize: 18.0,
  color: black,
  fontWeight: FontWeight.w500,
);
const TextStyle lightDisplaySmall = TextStyle(
  fontSize: 12.0,
  color: white,
  fontWeight: FontWeight.w500,
);
const TextStyle lightDisplayMedium = TextStyle(
  fontSize: 14.0,
  color: white,
  fontWeight: FontWeight.w400,
);
const TextStyle lightDisplayLarge = TextStyle(
  fontSize: 18.0,
  color: white,
  fontWeight: FontWeight.w500,
);

const TextStyle darkLabelSmall = TextStyle(
  fontSize: 12.0,
  color: white,
  fontWeight: FontWeight.w400,
);
const TextStyle darkLabelMedium = TextStyle(
  fontSize: 14.0,
  color: white,
  fontWeight: FontWeight.w400,
);
const TextStyle darkLabelLarge = TextStyle(
  fontSize: 18.0,
  color: white,
  fontWeight: FontWeight.w500,
);
const TextStyle darkDisplaySmall = TextStyle(
  fontSize: 12.0,
  color: background,
  fontWeight: FontWeight.w500,
);
const TextStyle darkDisplayMedium = TextStyle(
  fontSize: 14.0,
  color: white,
  fontWeight: FontWeight.w400,
);

const TextStyle darkDisplayLarge = TextStyle(
  fontSize: 18.0,
  color: white,
  fontWeight: FontWeight.w500,
);
