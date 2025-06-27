import 'package:flutter/material.dart';

class AppTheme {
  static final Color _lightPrimaryColor = Color(0xFFFF5722);
  static final Color _lightPrimaryVariantColor = Color(0xFFE64A19);
  static final Color _lightSecondaryColor = Color(0xFF4CAF50);
  static final Color _lightOnPrimaryColor = Colors.white;

  static final Color _darkPrimaryColor = Color(0xFFFF7043);
  static final Color _darkPrimaryVariantColor = Color(0xFFFF5722);
  static final Color _darkSecondaryColor = Color(0xFF66BB6A);
  static final Color _darkOnPrimaryColor = Colors.white;

  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 96, fontWeight: FontWeight.w300, color: Colors.black87),
    displayMedium: TextStyle(fontSize: 60, fontWeight: FontWeight.w300, color: Colors.black87),
    displaySmall: TextStyle(fontSize: 48, fontWeight: FontWeight.w400, color: Colors.black87),
    headlineMedium: TextStyle(fontSize: 34, fontWeight: FontWeight.w400, color: Colors.black87),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black87),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black87),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black87),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black87),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 96, fontWeight: FontWeight.w300, color: Colors.white70),
    displayMedium: TextStyle(fontSize: 60, fontWeight: FontWeight.w300, color: Colors.white70),
    displaySmall: TextStyle(fontSize: 48, fontWeight: FontWeight.w400, color: Colors.white70),
    headlineMedium: TextStyle(fontSize: 34, fontWeight: FontWeight.w400, color: Colors.white70),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white70),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white70),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white70),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white70),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white70),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white70),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white70),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white70),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white70),
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: _lightPrimaryColor,
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
    ),
    iconTheme: IconThemeData(
      color: _lightPrimaryColor,
    ),
    textTheme: _lightTextTheme,
    buttonTheme: ButtonThemeData(
      buttonColor: _lightPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: AppBarTheme(
      color: _darkPrimaryColor,
      iconTheme: IconThemeData(color: _darkOnPrimaryColor),
    ),
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
      surface: Color(0xFF1E1E1E),
    ),
    iconTheme: IconThemeData(
      color: _darkPrimaryColor,
    ),
    textTheme: _darkTextTheme,
    buttonTheme: ButtonThemeData(
      buttonColor: _darkPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    cardColor: Color(0xFF1E1E1E),
  );
}