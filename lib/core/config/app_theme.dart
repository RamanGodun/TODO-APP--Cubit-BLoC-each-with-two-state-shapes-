import 'package:flutter/material.dart';
import 'text_styles.dart';
import 'app_constants.dart';

/// 🎨 `AppThemes` визначає теми додатку
abstract class AppThemes {
  /// 🌓 Темна тема
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppConstants.darkPrimaryColor,
    scaffoldBackgroundColor: AppConstants.darkScaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppConstants.darkAppBarBackgroundColor,
      // centerTitle: false,
      foregroundColor: AppConstants.darkForegroundColor,
      elevation: 0,
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppConstants.darkPrimaryColor,
      secondary: AppConstants.secondaryColor4DarkTheme,
      surface: AppConstants.darkAppBarBackgroundColor,
      background: AppConstants.darkScaffoldBackgroundColor,
      error: AppConstants.errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
    ),
    textTheme: TextStyles4ThisAppThemes.kTextThemeData(true),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants.darkPrimaryColor,
        foregroundColor: AppConstants.darkForegroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // textStyle: TextStyles4ThisAppThemes.kTextThemeData(true).displaySmall,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.2),
      ),
    ),
  );

  /// 🌞 Світла тема
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppConstants.lightPrimaryColor,
    scaffoldBackgroundColor: AppConstants.lightScaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppConstants.lightAppBarBackgroundColor,
      // centerTitle: false,
      foregroundColor: AppConstants.lightForegroundColor,
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppConstants.lightPrimaryColor,
      secondary: AppConstants.secondaryColor4LightTheme,
      surface: AppConstants.lightScaffoldBackgroundColor,
      background: AppConstants.lightScaffoldBackgroundColor,
      error: AppConstants.errorColor,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
    ),
    textTheme: TextStyles4ThisAppThemes.kTextThemeData(false),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants.lightPrimaryColor,
        foregroundColor: AppConstants.lightForegroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // textStyle: TextStyles4ThisAppThemes.kTextThemeData(false).displaySmall,
        elevation: 0,
        shadowColor: Colors.grey.withOpacity(0.2),
      ),
    ),
  );
}
