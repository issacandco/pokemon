import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../utils/get_util.dart';


enum IconType {
  menu,
  close,
  none,
  back,
}

class BaseAppBar extends AppBar {
  final IconType? iconType;
  final Widget? icon;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final String? titleName;
  final Color? titleNameColor;
  final Color? surfaceColor;
  final Widget? titleWidget;
  final PreferredSize? bottomWidget;
  final List<Widget>? appBarActions;
  final bool centerTitleName;
  final bool hideElevation;
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  BaseAppBar({
    super.key,
    this.iconType = IconType.back,
    this.icon,
    this.iconColor,
    this.onPressed,
    this.titleName,
    this.titleNameColor,
    this.surfaceColor,
    this.titleWidget,
    this.bottomWidget,
    this.appBarActions,
    this.centerTitleName = false,
    this.hideElevation = true,
    this.systemUiOverlayStyle,
  }) : super(
          leading: iconType == IconType.menu
              ? IconButton(
                  onPressed: onPressed,
                  icon: icon ??
                      Icon(
                        Icons.menu,
                        color: iconColor,
                      ))
              : iconType == IconType.none
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: onPressed ??
                          () {
                            GetUtil.back();
                          },
                      icon: icon ??
                          Icon(
                            Icons.arrow_back,
                            color: iconColor,
                          ),
                    ),
          leadingWidth: iconType == IconType.none ? AppSize.getSize(8) : null,
          centerTitle: centerTitleName,
          elevation: hideElevation ? 0 : null,
          title: titleWidget ??
              Text(
                titleName ?? '',
                style: AppTextStyle.baseTextStyle(
                  fontWeightType: FontWeightType.bold,
                  fontSize: AppSize.getTextSize(22),
                  color: titleNameColor,
                ),
              ),
          bottom: bottomWidget,
          actions: [
            ...?appBarActions,
            SizedBox(
              width: AppSize.getSize(6),
            )
          ],
          backgroundColor: surfaceColor,
          systemOverlayStyle: systemUiOverlayStyle,
          scrolledUnderElevation: 0,
        );
}
