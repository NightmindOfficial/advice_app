import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final Color _lightPrimary = Colors.blueGrey.shade50;
  static final Color _lightPrimaryVariant = Colors.blueGrey.shade800;
  static final Color _lightOnPrimary = Colors.blueGrey.shade200;
  static const Color _lightTextColorPrimary = Colors.black;
  static final Color _lightAppbarColor = Colors.blue.shade400;

  static final Color _darkPrimary = Colors.blueGrey.shade900;
  static const Color _darkPrimaryVariant = Colors.black;
  static final Color _darkOnPrimary = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;
  static final Color _darkAppbarColor = Colors.blue.shade800;

  static const Color _iconColor = Colors.white;
  static const Color _accentColorDark = Color.fromRGBO(74, 217, 217, 1);

  static const TextStyle _lightHeadingText = TextStyle(
    color: _lightTextColorPrimary,
    fontFamily: "DM Sans",
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _lightBodyText = TextStyle(
    color: _lightTextColorPrimary,
    fontFamily: "DM Sans",
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextTheme _lightTextTheme = TextTheme(
    displayMedium: _lightHeadingText,
    bodyMedium: _lightBodyText,
  );

  static final TextStyle _darkHeadingText =
      _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkBodyText =
      _lightBodyText.copyWith(color: _darkTextColorPrimary);

  static final _darkTextTheme =
      TextTheme(displayMedium: _darkHeadingText, bodyMedium: _darkBodyText);

//* THEMES *//

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimary,
    appBarTheme: AppBarTheme(
      color: _lightAppbarColor,
      iconTheme: const IconThemeData(color: _iconColor),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: _lightAppbarColor),
    colorScheme: ColorScheme.light(
      primary: _lightPrimary,
      onPrimary: _lightOnPrimary,
      secondary: _accentColorDark,
      primaryContainer: _lightPrimaryVariant,
    ),
    textTheme: _lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimary,
    appBarTheme: AppBarTheme(
      color: _darkAppbarColor,
      iconTheme: const IconThemeData(color: _iconColor),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: _darkAppbarColor),
    colorScheme: ColorScheme.dark(
      primary: _darkPrimary,
      onPrimary: _darkOnPrimary,
      secondary: _accentColorDark,
      primaryContainer: _darkPrimaryVariant,
    ),
    textTheme: _darkTextTheme,
  );
}
