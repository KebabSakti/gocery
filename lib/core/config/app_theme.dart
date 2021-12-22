import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor lightPrimarySwatch = MaterialColor(
    0xff64BA02,
    <int, Color>{
      50: Color(0xffF9FFF3),
      100: Color(0xffF7FFEF),
      200: Color(0xffE9F6DB),
      300: Color(0xffB0F363),
      400: Color(0xff7FDA17),
      500: Color(0xff64BA02),
      600: Color(0xff509600),
      700: Color(0xff407700),
      800: Color(0xff2B5000),
      900: Color(0xff172B00),
    },
  );

  static final ThemeData light = ThemeData(
    primarySwatch: lightPrimarySwatch,
    fontFamily: 'SFPRO',
    scaffoldBackgroundColor: const Color(0xffF2F2F2),
    textTheme: Typography.blackMountainView.copyWith(
      headline4: const TextStyle(
        color: Color(0xff222B45),
        fontWeight: FontWeight.w800,
        fontSize: 32,
      ),
      bodyText2: const TextStyle(
        color: Color(0xff8F9BB3),
        fontSize: 15,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xff64BA02),
        onPrimary: const Color(0xffFFFFFF),
        textStyle: const TextStyle(
          fontSize: 16,
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
