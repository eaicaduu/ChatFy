import 'package:flutter/material.dart';

class AppColors {

  static const Color primary = Color(0xFF6200EA);
  static const Color secondary = Color(0xFF03DAC5);
  static const Color global = Colors.green;
  static const Color button = Color(0XFFF5F5F5);


  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color textColorLight = Color(0xFF333333);


  static const Color backgroundDark = Color(0xFF121212);
  static const Color textColorDark = Color(0xFFFFFFFF);
}

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    secondaryHeaderColor: AppColors.secondary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.textColorLight),
      bodyMedium: TextStyle(color: AppColors.textColorLight),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.button,
    )
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    secondaryHeaderColor: AppColors.secondary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.textColorDark),
      bodyMedium: TextStyle(color: AppColors.textColorDark),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.button,
    )
  );
}

Color getBackgroundColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.light
      ? AppColors.backgroundLight
      : AppColors.backgroundDark;
}
