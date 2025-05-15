import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.grey.shade100,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.pink.shade500,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.pink.shade500,
      unselectedItemColor: Colors.grey.shade600,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.grey.shade900),
      bodyMedium: TextStyle(color: Colors.grey.shade800),
    ),
    cardColor: Colors.white,
    canvasColor: Colors.grey.shade200,
    iconTheme: IconThemeData(color: Colors.grey.shade900),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.pink.shade500),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(color: Colors.grey),
      labelStyle: TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.pink.shade400),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade800,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.pink.shade400,
      unselectedItemColor: Colors.grey.shade500,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.grey.shade200),
      bodyMedium: TextStyle(color: Colors.grey.shade400),
    ),
    cardColor: Colors.grey.shade800,
    canvasColor: Colors.grey.shade800,
    iconTheme: IconThemeData(color: Colors.grey.shade200),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.pink.shade400),
        foregroundColor: MaterialStateProperty.all(Colors.grey.shade900),
      ),
    ),
  );
}
