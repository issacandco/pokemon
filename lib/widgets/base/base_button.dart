import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';

enum FitType { fit, loose }

class BaseButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Widget? icon;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? color;
  final Color? borderColor;
  final Color? disabledColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final bool enabled;
  final bool showShadow;
  final FitType fitType;
  final bool secondary;

  const BaseButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.textStyle,
    this.textColor,
    this.color,
    this.disabledColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.enabled = true,
    this.showShadow = false,
    this.fitType = FitType.loose,
    this.secondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return fitType == FitType.loose ? _buildButtonWithLooseFit() : _buildButtonWithFit();
  }

  Widget _buildButtonWithLooseFit() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: _buildBoxDecoration(),
      child: _buildTextButton(),
    );
  }

  Widget _buildButtonWithFit() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: AppSize.getScreenWidth(),
      decoration: _buildBoxDecoration(),
      child: _buildTextButton(),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: secondary ? Colors.white : null,
      gradient: !secondary && enabled
          ? LinearGradient(colors: [
              color ?? AppColor.primaryColor,
              color ?? AppColor.primaryColor,
            ])
          : !secondary
              ? LinearGradient(colors: [
                  (color ?? AppColor.primaryColor).withOpacity(0.5),
                  (color ?? AppColor.primaryColor).withOpacity(0.5),
                ])
              : null,
      borderRadius: borderRadius ?? BorderRadius.circular(AppSize.getSize(8)),
      border: Border.all(color: borderColor ?? (secondary ? Colors.grey : Colors.transparent)),
      boxShadow: showShadow
          ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ]
          : null,
    );
  }

  ButtonStyle _buildButtonStyle() {
    return ButtonStyle(
      alignment: Alignment.center,
      padding: WidgetStateProperty.all(
        padding ??
            EdgeInsets.symmetric(
              vertical: AppSize.getSize(8),
              horizontal: AppSize.standardSize,
            ),
      ),
      overlayColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) => Colors.transparent,
      ),
      splashFactory: NoSplash.splashFactory,
    );
  }

  Widget _buildTextButton() {
    return TextButton.icon(
      style: _buildButtonStyle(),
      onPressed: enabled ? onPressed : null,
      label: Text(
        text,
        style: textStyle ?? _getDefaultTextStyle(),
      ),
      icon: icon ?? const SizedBox.shrink(),
    );
  }

  TextStyle _getDefaultTextStyle() {
    return AppTextStyle.baseTextStyle(
      fontWeightType: FontWeightType.bold,
      fontSize: AppSize.standardTextSize,
      color: _getTextColor(),
    );
  }

  Color _getTextColor() {
    if (enabled) {
      return secondary ? (textColor ?? Colors.black) : (textColor ?? Colors.white);
    } else {
      return secondary ? (textColor?.withOpacity(0.5) ?? Colors.black.withOpacity(0.5)) : (textColor?.withOpacity(0.5) ?? Colors.white.withOpacity(0.5));
    }
  }
}
