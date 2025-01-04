import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.pink, foregroundColor: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Color(0x080904),
    appBarTheme: AppBarTheme(
        backgroundColor: Color(0x080904), foregroundColor: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
    ),
  );
}
