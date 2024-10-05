import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_color.dart';

class AppThemes {
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColor.lightBackgroundColor,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: AppColor.black,
      ),
      backgroundColor: Colors.transparent,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.paleLilacColor,
      selectedItemColor: AppColor.primaryColor,
      unselectedItemColor: AppColor.lightUnselectedColor,
    ),
    colorScheme: const ColorScheme.light(
      // surface: AppColor.snow,
      // primary: AppColor.primaryColor,
      // secondary: AppColor.lightUnselectedColor,
      tertiary: AppColor.black,
      primaryContainer: AppColor.offWhiteColor,
      // secondaryContainer: AppColor.offWhiteColor,
      // tertiaryContainer: AppColor.offWhiteColor,
    ),
    // cardColor: AppColor.offWhiteColor,
    // dialogBackgroundColor: AppColor.offWhiteColor,
    // dividerColor: AppColor.shadeGray,
    // dividerTheme: const DividerThemeData(
    //   color: AppColor.paleGrayColor,
    // ),
    disabledColor: AppColor.black.withOpacity(0.3),
    highlightColor: Colors.grey.shade300,
    iconTheme: const IconThemeData(
      color: AppColor.black,
    ),
    // unselectedWidgetColor: AppColor.grayColor,
    // scaffoldBackgroundColor: AppColor.whiteColor,
    // tabBarTheme: const TabBarTheme(
    //   unselectedLabelColor: AppColor.blackColor,
    //   labelColor: AppColor.whiteColor,
    // ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColor.lightBackgroundColor,
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColor.darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(
        color: AppColor.white,
      ),
      backgroundColor: Colors.transparent,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.deepCharcoalColor,
      selectedItemColor: AppColor.primaryColor,
      unselectedItemColor: AppColor.darkUnselectedColor,
    ),
    colorScheme: const ColorScheme.dark(
      // surface: AppColor.eerieBlack,
      // primary: AppColor.primaryColor,
      // secondary: AppColor.darkUnselectedColor,
      tertiary: AppColor.white,
      primaryContainer: AppColor.oilColor,
      // secondaryContainer: AppColor.whiteColor,
      // tertiaryContainer: AppColor.lightCharcoalColor,
    ),
    disabledColor: AppColor.white.withOpacity(0.7),
    // cardColor: AppColor.steelBlueColor,
    // dialogBackgroundColor: AppColor.darkCharcoalColor,
    dividerColor: AppColor.darkGrayColor,
    // dividerTheme: const DividerThemeData(
    //   color: AppColor.lightCharcoalColor,
    // ),
    highlightColor: Colors.grey.shade800,
    iconTheme: const IconThemeData(
      color: AppColor.white,
    ),
    // unselectedWidgetColor: AppColor.lightGrayColor,
    // scaffoldBackgroundColor: AppColor.darkCharcoalColor,
    // tabBarTheme: const TabBarTheme(
    //   unselectedLabelColor: AppColor.whiteColor,
    //   labelColor: AppColor.whiteColor,
    // ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColor.darkBackgroundColor,
    ),
  );
}
