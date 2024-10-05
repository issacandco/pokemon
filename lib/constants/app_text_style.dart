import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_size.dart';

enum FontWeightType { thin, light, regular, medium, semiBold, bold }

class AppTextStyle {
  AppTextStyle._();

  static TextStyle getTextStyle({
    FontWeightType fontWeightType = FontWeightType.regular,
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Paint? background,
    double? decorationThickness,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    String? fontFamily,
    List<String>? fontFamilyFallback,
  }) {
    return _buildTextStyle(
      fontSize: fontSize != null ? AppSize.getTextSize(fontSize) : AppSize.standardTextSize,
      color: color,
      fontWeight: fontWeight,
      fontWeightType: fontWeightType,
      fontStyle: fontStyle ?? FontStyle.normal,
      textDecoration: textDecoration,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      background: background,
      decorationThickness: decorationThickness,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      shadows: shadows,
      fontFeatures: fontFeatures,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

  static TextStyle baseTextStyle({
    double? fontSize,
    Color? color,
    TextDecoration? textDecoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    double? height,
    FontWeightType fontWeightType = FontWeightType.regular,
    bool isItalic = false,
  }) {
    return _buildTextStyle(
      fontSize: fontSize,
      color: color,
      textDecoration: textDecoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      height: height,
      fontWeightType: fontWeightType,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static TextStyle _buildTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    FontWeightType? fontWeightType,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Paint? background,
    double? decorationThickness,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    String? fontFamily,
    List<String>? fontFamilyFallback,
  }) {
    return GoogleFonts.raleway(
      textStyle: TextStyle(
        fontSize: fontSize ?? AppSize.standardTextSize,
        color: color ?? Get.theme.colorScheme.tertiary,
        fontWeight: fontWeight ?? _getFontWeight(fontWeightType!),
        fontStyle: fontStyle ?? FontStyle.normal,
        decoration: textDecoration,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        background: background,
        decorationThickness: decorationThickness,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
      ),
    );
  }

  static FontWeight _getFontWeight(FontWeightType fontWeightType) {
    switch (fontWeightType) {
      case FontWeightType.thin:
        return FontWeight.w100;
      case FontWeightType.light:
        return FontWeight.w300;
      case FontWeightType.medium:
        return FontWeight.w500;
      case FontWeightType.semiBold:
        return FontWeight.w600;
      case FontWeightType.bold:
        return FontWeight.w700;
      case FontWeightType.regular:
      default:
        return FontWeight.w400;
    }
  }
}
