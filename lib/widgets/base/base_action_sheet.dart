import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import 'base_bottom_sheet.dart';

class BaseActionSheet extends StatelessWidget {
  final List<ActionModel> actionModelList;

  const BaseActionSheet({
    super.key,
    required this.actionModelList,
  });

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      body: Container(
        padding: EdgeInsets.only(top: AppSize.getSize(8)),
        child: Column(
          children: actionModelList.asMap().entries.map((entry) => _buildActionItem(context, entry.key, entry.value)).toList(),
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, int index, ActionModel action) {
    return GestureDetector(
      onTap: action.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppSize.getSize(16)),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast(index) ? BorderSide.none : BorderSide(color: AppColor.gray.withOpacity(0.6)),
          ),
        ),
        child: Text(
          action.text,
          textAlign: TextAlign.center,
          style: AppTextStyle.baseTextStyle(
            fontWeightType: FontWeightType.bold,
            color: action.fontColor ?? Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }

  bool isLast(int index) {
    return index == actionModelList.length - 1;
  }
}

class ActionModel {
  final String text;
  final Color? fontColor;
  final VoidCallback? onPressed;

  ActionModel({
    required this.text,
    this.fontColor,
    this.onPressed,
  });
}
