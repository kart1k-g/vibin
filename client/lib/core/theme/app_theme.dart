import 'package:client/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border(color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 3, color: color),
      borderRadius: BorderRadius.circular(7),
    );
  }

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: _border(Pallete.gradient2),
      enabledBorder: _border(Pallete.borderColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.backgroundColor,
    ),
  );
}
