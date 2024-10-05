import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_color.dart';

class BaseLoading extends StatelessWidget {
  static OverlayEntry? _overlayEntry;
  final String? gifPath;

  const BaseLoading({super.key, this.gifPath});

  static void showLoading({String? gifPath}) {
    dismissLoading();

    _overlayEntry = OverlayEntry(
      builder: (context) => BaseLoading(gifPath: gifPath),
    );

    if (Get.overlayContext != null) {
      Overlay.of(Get.overlayContext!).insert(_overlayEntry!);
    }
  }

  static void dismissLoading() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    // double loadingIconSize = AppSize.getScreenWidth(percent: 30);
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: gifPath != null
            ? Image.asset(
                gifPath!,
                // height: loadingIconSize,
                // width: loadingIconSize,
                color: AppColor.primaryColor,
              )
            : const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
              ),
      ),
    );
  }
}
