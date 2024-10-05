import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const primaryColor = fireBrick;
  static const fireBrick = Color(0xFFB22222);

  // common
  static const white = Colors.white;
  static const black = Colors.black;
  static const gray = Color(0xFF80858E);
  static const blue = Color(0xFF4F98CA);
  static const pink = Color(0xFFF08080);

  // light theme
  static const lightBackgroundColor = white;
  static const lightUnselectedColor = Color(0xFF606060);
  static const offWhiteColor = Color(0xFFEEEEEE);
  static const paleLilacColor = Color(0xFFF8F6FE);
  static const lightGrayColor = Color(0xFFBDBDBD);

  // dark theme
  static const darkBackgroundColor = Color(0xFF121212);
  static const darkUnselectedColor = Color(0xFFB0B0B0);
  static const oilColor = Color(0xFF2B2B2B);
  static const charcoalGrayColor = Color(0xFF262626);
  static const darkGrayColor = Color(0xFF757575);

  static const charcoalColor = Color(0xFF2d3436);


  static const lightShadeGrayColor = Color(0xFFbbbbbb);
  static const mediumGray = Color(0xFFa2a2a2);
  static const paleGrayColor = Color(0xFFEAEAEA);
  static const offGrayColor = Color(0xFFAEB5B6);

  // Dark theme colors
  static const darkCharcoalColor = Color(0xFF2A2B32);
  static const deepCharcoalColor = Color(0xFF25262D);

  static const lightCharcoalColor = Color(0xFF1d1e25);

  // static const scaffoldBackgroundColor = Color(0xfffafafa);
  static const scaffoldBackgroundColor = white;
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
