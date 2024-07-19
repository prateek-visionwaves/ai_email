import 'package:flutter/material.dart';

abstract class AppThemes{
  static final themeLight = ThemeData(
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12)
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        )
      )
    )
  );
}