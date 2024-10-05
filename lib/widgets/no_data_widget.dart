import 'package:flutter/material.dart';

import '../constants/app_size.dart';
import '../constants/app_text_style.dart';

class NoDataWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Color? messageColor;
  final EdgeInsets? padding;
  final bool showMessage;

  const NoDataWidget({
    super.key,
    this.message,
    this.image,
    this.messageColor,
    this.padding,
    this.showMessage = true,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.only(top: AppSize.getScreenHeight(percent: 8)),
        child: Column(
          children: [
            image == null
                ? const SizedBox.shrink()
                : Container(
                    margin: EdgeInsets.only(bottom: AppSize.getSize(16)),
                    child: image!,
                  ),
            Visibility(
              visible: showMessage,
              child: Text(
                message ?? 'No data',
                style: AppTextStyle.baseTextStyle(
                  fontWeightType: FontWeightType.medium,
                  fontSize: AppSize.getTextSize(14),
                  color: messageColor ?? Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
