import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_color.dart';
import '../../../constants/app_size.dart';
import '../../../constants/app_text_style.dart';

class ItemActionButton extends StatelessWidget {
  final Map<String, dynamic> action;

  const ItemActionButton({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        action['tap']?.call();
      },
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.getSize(16),
            vertical: AppSize.getSize(8),
          ),
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(AppSize.getSize(12)),
          ),
          child: Row(
            children: [
              action['icon'],
              SizedBox(width: AppSize.getSize(8)),
              Text(
                action['label'],
                style: AppTextStyle.baseTextStyle(
                  fontWeightType: FontWeightType.bold,
                  fontSize: AppSize.getTextSize(18),
                  color: AppColor.white,
                ),
              )
            ],
          )),
    );
  }
}
