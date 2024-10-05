import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize {
  AppSize._();

  static double standardSize = 24.0.w;

  static double standardTextSize = 16.0.sp;

  static double getSize(double size) => size.w;

  static double getTextSize(double size) => size.sp;

  static double getScreenWidth({int? percent}) =>
      percent != null ? (percent / 100).sw : ScreenUtil().screenWidth;

  static double getScreenHeight({int? percent}) =>
      percent != null ? (percent / 100).sh : ScreenUtil().screenHeight;

  static double? getPixelRatio() => ScreenUtil().pixelRatio;

  static double getBodyHeight() =>
      AppSize.getScreenHeight() - (ScreenUtil().statusBarHeight + kToolbarHeight);

  static double dynamicSize(double baseSize, double multiplier) =>
      (baseSize * multiplier).w;

  static double dynamicTextSize(double baseSize, double multiplier) =>
      (baseSize * multiplier).sp;

  static EdgeInsetsGeometry responsivePadding({
    required double horizontalPadding,
    required double verticalPadding,
  }) =>
      EdgeInsets.symmetric(
        horizontal: horizontalPadding.w,
        vertical: verticalPadding.h,
      );
}
