import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';

class BaseCheckBox extends StatefulWidget {
  final bool value;
  final String? textMessage;
  final TextSpan? textSpan;
  final double? fontSize;
  final Color? fontColor;
  final Color enableBorderColor;
  final Color disableBorderColor;
  final Function(bool value)? onChanged;
  final bool enabled;
  final Alignment alignment;

  const BaseCheckBox({
    super.key,
    this.value = false,
    this.textMessage,
    this.textSpan,
    this.fontSize,
    this.fontColor,
    this.enableBorderColor = AppColor.primaryColor,
    this.disableBorderColor = Colors.transparent,
    this.onChanged,
    this.enabled = true,
    this.alignment = Alignment.centerLeft,
  });

  @override
  State<BaseCheckBox> createState() => _BaseCheckBoxState();
}

class _BaseCheckBoxState extends State<BaseCheckBox> {
  late bool checkBoxValue;

  @override
  void initState() {
    super.initState();
    checkBoxValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant BaseCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      checkBoxValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.symmetric(vertical: AppSize.getSize(4)),
      duration: const Duration(milliseconds: 400),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (widget.textMessage != null) {
      return _buildRow(
        child: Flexible(
          child: Text(
            widget.textMessage!,
            style: AppTextStyle.baseTextStyle(
              fontSize: widget.fontSize ?? AppSize.standardTextSize,
              color: widget.enabled ? widget.fontColor : AppColor.darkGrayColor,
            ),
          ),
        ),
      );
    } else if (widget.textSpan != null) {
      return _buildRow(
        child: Flexible(child: RichText(text: widget.textSpan!)),
      );
    } else {
      return Align(
        alignment: widget.alignment,
        child: _buildCheckBox(),
      );
    }
  }

  Widget _buildRow({required Widget child}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCheckBox(),
        SizedBox(width: AppSize.getSize(8)),
        child,
      ],
    );
  }

  Widget _buildCheckBox() {
    return InkWell(
      onTap: widget.enabled && widget.onChanged != null
          ? () {
              setState(() {
                checkBoxValue = !checkBoxValue;
                widget.onChanged?.call(checkBoxValue);
              });
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.getSize(4)),
          color: checkBoxValue ? (widget.enabled ? AppColor.primaryColor : AppColor.darkGrayColor) : Colors.transparent,
          border: Border.all(
            color: widget.enabled ? (checkBoxValue ? widget.enableBorderColor : widget.enableBorderColor) : AppColor.darkGrayColor,
            width: AppSize.getSize(2),
          ),
        ),
        child: Icon(
          Icons.check_rounded,
          size: AppSize.getSize(18),
          color: checkBoxValue ? Colors.white : Colors.transparent,
        ),
      ),
    );
  }
}
