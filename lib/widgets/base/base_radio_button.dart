import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';

enum LabelPosition {
  left,
  right,
}

class BaseRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String? label;
  final double? labelFontSize;
  final Widget? labelWidget;
  final EdgeInsets? contentPadding;
  final Color? activeColor;
  final Function(T)? onChanged;
  final LabelPosition labelPosition;

  const BaseRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    this.label,
    this.labelFontSize,
    this.labelWidget,
    this.contentPadding,
    this.activeColor,
    this.onChanged,
    this.labelPosition = LabelPosition.right,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) onChanged?.call(value);
      },
      child: Padding(
        padding: contentPadding ?? const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildChildren(),
        ),
      ),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = [];

    if (labelPosition == LabelPosition.left) {
      children.add(_buildLabel());
      children.add(const SizedBox(width: 8));
    }

    children.add(
      Radio<T>(
        groupValue: groupValue,
        value: value,
        activeColor: activeColor ?? AppColor.primaryColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        onChanged: (selectedValue) {
          onChanged?.call(selectedValue as T);
        },
      ),
    );

    if (labelPosition == LabelPosition.right) {
      children.add(const SizedBox(width: 8));
      children.add(_buildLabel());
    }

    return children;
  }

  Widget _buildLabel() {
    if (labelWidget != null) {
      return Expanded(child: labelWidget!);
    }

    if (label != null) {
      return Text(
        label!,
        style: AppTextStyle.baseTextStyle(fontSize: labelFontSize != null && labelFontSize! > 0 ? AppSize.getTextSize(labelFontSize!) : AppSize.standardTextSize),
      );
    }

    return const SizedBox.shrink();
  }
}
