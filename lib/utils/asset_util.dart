import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/app_size.dart';
import '../widgets/image_enlarger.dart';

class AssetUtil {
  AssetUtil._();

  static Widget imagePokeball({double? size, Color? color}) {
    size ??= AppSize.getSize(48);
    return SvgPicture.asset(
      _imagePath('image_pokeball.svg'),
      width: size,
      height: size,
    );
  }

  static Widget imageOpenedPokeball({double? size, Color? color}) {
    size ??= AppSize.getScreenHeight(percent: 30);
    return SvgPicture.asset(
      _imagePath('image_opened_pokeball.svg'),
      width: size,
      height: size,
    );
  }

  static Widget icPokeball({double? size, Color? color}) {
    size ??= AppSize.getSize(24);
    return SvgPicture.asset(
      _iconPath('ic_pokeball.svg'),
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? Get.theme.iconTheme.color!, BlendMode.srcIn),
    );
  }

  static Widget icRun({double? size, Color? color}) {
    size ??= AppSize.getSize(24);
    return SvgPicture.asset(
      _iconPath('ic_run.svg'),
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? Get.theme.iconTheme.color!, BlendMode.srcIn),
    );
  }

  static Widget icSearch({double? size, Color? color}) {
    size ??= AppSize.getSize(36);
    return SvgPicture.asset(
      _iconPath('ic_search.svg'),
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? Get.theme.iconTheme.color!, BlendMode.srcIn),
    );
  }

  static Widget icBook({double? size, Color? color}) {
    size ??= AppSize.getSize(36);
    return SvgPicture.asset(
      _iconPath('ic_book.svg'),
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? Get.theme.iconTheme.color!, BlendMode.srcIn),
    );
  }

  static Widget icBackpack({double? size, Color? color}) {
    size ??= AppSize.getSize(36);
    return SvgPicture.asset(
      _iconPath('ic_backpack.svg'),
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? Get.theme.iconTheme.color!, BlendMode.srcIn),
    );
  }

  static Widget icFavourite({double? size, Color? color}) {
    size ??= AppSize.getSize(36);
    return SvgPicture.asset(
      _iconPath('ic_favourite.svg'),
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? Get.theme.iconTheme.color!, BlendMode.srcIn),
    );
  }

  static String _iconPath(String iconName) {
    return 'assets/icons/$iconName';
  }

  static String _imagePath(String iconName) {
    return 'assets/images/$iconName';
  }

  /// Enlarges the specified image.
  static void enlargeImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (BuildContext context, _, __) {
          return ImageEnlarger(imageUrl: imageUrl);
        },
      ),
    );
  }
}
