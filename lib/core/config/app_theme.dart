import 'package:flutter/material.dart';
import 'package:gocery/core/config/app_const.dart';

class AppTheme {
  static MaterialColor lightPrimarySwatch = MaterialColor(
    kPrimaryColor.value,
    const <int, Color>{
      50: kPrimaryColor50,
      100: kPrimaryColor100,
      200: kPrimaryColor200,
      300: kPrimaryColor300,
      400: kPrimaryColor400,
      500: kPrimaryColor,
      600: kPrimaryColor600,
      700: kPrimaryColor700,
      800: kPrimaryColor800,
      900: kPrimaryColor900,
    },
  );

  static final ThemeData light = ThemeData(
    primarySwatch: lightPrimarySwatch,
    fontFamily: 'SFPRO',
    scaffoldBackgroundColor: kBackgroundColor,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      surface: kLightColor,
      primaryVariant: kPrimaryColor700,
      error: kErrorColor,
      onError: kLightColor,
      background: kBackgroundColor,
      onBackground: kDarkColor,
      primary: kPrimaryColor,
      onPrimary: kLightColor,
      secondary: kAccentColor,
      onSecondary: kLightColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kLightColor,
      centerTitle: true,
      elevation: 0.5,
      iconTheme: IconThemeData(color: kDarkColor),
      titleTextStyle: TextStyle(
        color: kDarkColor,
        fontSize: kBigFont,
        fontFamily: 'SFPRO',
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: Typography.englishLike2018.copyWith(
      headline1: const TextStyle(
        color: kDarkColor,
        fontWeight: FontWeight.bold,
        fontSize: kHugeFont,
        letterSpacing: 0.0,
      ),
      headline2: const TextStyle(
        color: kLightColor100,
        fontSize: kBigFont,
        letterSpacing: 0.0,
      ),
      headline3: const TextStyle(
        color: kDarkColor,
        fontSize: kBigFont,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
      ),
      headline4: const TextStyle(
        color: kPrimaryColor,
        fontSize: kMediumFont,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
      ),
      bodyText1: const TextStyle(
        color: kDarkColor,
        fontSize: kMediumFont,
        letterSpacing: 0.0,
      ),
      bodyText2: const TextStyle(
        color: kLightColor100,
        fontSize: kMediumFont,
        letterSpacing: 0.0,
      ),
      overline: const TextStyle(
        color: kLightColor,
        fontSize: kTinyFont,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
      ),
      caption: const TextStyle(
        color: kLightColor,
        fontSize: kMediumFont,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: kPrimaryColor,
        onPrimary: kLightColor,
        textStyle: const TextStyle(
          fontSize: kMediumFont,
          fontWeight: FontWeight.w400,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ).merge(
        ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
        ),
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    primarySwatch: lightPrimarySwatch,
    fontFamily: 'SFPRO',
  );
}
