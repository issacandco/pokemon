import 'package:flutter/material.dart';

import '../../../constants/app_size.dart';
import '../../../constants/app_text_style.dart';
import '../../../utils/get_util.dart';
import '../base_bottom_sheet.dart';
import '../base_text_field.dart';
import 'dropdown_selection_widget.dart';

enum DropdownType { dropdown, bottom, full }

class BaseDropdown<T> extends StatefulWidget {
  final List<T> items;
  final void Function(T) onChanged;
  final T? initialValue;
  final String Function(T?) displayText;
  final TextEditingController? textEditingController;
  final DropdownType? dropdownType;
  final bool enabled;
  final Widget? suffixIcon;
  final Color? iconColor;
  final FocusNode? focusNode;
  final Function(String text)? onValidate;
  final TextStyle? dropdownItemTextStyle;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final double? labelFontSize;
  final Color? labelColor;
  final TextStyle? inputTextStyle;
  final double? inputTextFontSize;
  final Color? inputTextColor;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final double? hintTextFontSize;
  final Color? hintTextColor;
  final String? errorText;
  final TextStyle? errorTextStyle;
  final double? errorTextFontSize;
  final Color? errorTextColor;
  final InputBorder? inputBorder;
  final double? inputBorderRadius;
  final Color? inputBorderColor;

  const BaseDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.initialValue,
    required this.displayText,
    this.textEditingController,
    this.dropdownType = DropdownType.full,
    this.enabled = true,
    this.suffixIcon,
    this.iconColor,
    this.focusNode,
    this.onValidate,
    this.dropdownItemTextStyle,
    this.labelText,
    this.labelTextStyle,
    this.labelFontSize,
    this.labelColor,
    this.inputTextStyle,
    this.inputTextFontSize,
    this.inputTextColor,
    this.hintText,
    this.hintTextStyle,
    this.hintTextFontSize,
    this.hintTextColor,
    this.errorText,
    this.errorTextStyle,
    this.errorTextFontSize,
    this.errorTextColor,
    this.inputBorder,
    this.inputBorderRadius,
    this.inputBorderColor,
  });

  @override
  State<BaseDropdown<T>> createState() => ThemeDropdownState<T>();
}

class ThemeDropdownState<T> extends State<BaseDropdown<T>> with TickerProviderStateMixin {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.textEditingController ?? TextEditingController();

    _controller.text = widget.displayText(widget.initialValue ?? widget.items[0]);
  }

  Widget _openDropdown() {
    return Opacity(
      opacity: 0.0,
      child: Container(
        color: Colors.white,
        height: AppSize.getScreenHeight(percent: 7),
        child: DropdownButton<T>(
          value: widget.initialValue,
          isExpanded: true,
          dropdownColor: Colors.white,
          items: widget.items
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(
                    widget.displayText(e),
                    style: _defaultDropdownItemTextStyle(),
                  ),
                ),
              )
              .toList(),
          onChanged: (item) {
            _controller.text = widget.displayText(item);
            widget.onChanged.call(item as T);
          },
        ),
      ),
    );
  }

  Future _openDropdownSheet() async {
    T item = await GetUtil.showBottomSheetWithResult(
      BottomDropdown(
        initialItem: widget.initialValue,
        onSelectedItem: widget.onChanged,
        items: widget.items,
        displayText: widget.displayText,
        labelText: widget.labelText ?? '',
      ),
    );

    if (item != null) {
      setState(() {
        _controller.text = widget.displayText(item);
      });
    }
  }

  Future _openFullDropdownSelection() async {
    T? item = await GetUtil.navigateToWithResult(
      DropdownSelectionWidget(
        items: widget.items,
        initialItem: widget.initialValue,
        onSelectedItem: widget.onChanged,
        displayText: widget.displayText,
        title: widget.labelText ?? '',
      ),
    );

    if (item != null) {
      setState(() {
        _controller.text = widget.displayText(item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dropdownType == DropdownType.dropdown) {
      return IgnorePointer(
        ignoring: !widget.enabled,
        child: Stack(
          children: [
            _core(),
            _openDropdown(),
          ],
        ),
      );
    } else if (widget.dropdownType == DropdownType.bottom) {
      return InkWell(
        onTap: widget.enabled
            ? () {
                _openDropdownSheet();
              }
            : null,
        child: IgnorePointer(
          ignoring: true,
          child: _core(),
        ),
      );
    } else if (widget.dropdownType == DropdownType.full) {
      return InkWell(
        onTap: widget.enabled
            ? () {
                _openFullDropdownSelection();
              }
            : null,
        child: IgnorePointer(
          ignoring: true,
          child: _core(),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _core() => BaseTextField(
        controller: _controller,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        readOnly: true,
        labelText: widget.labelText,
        labelTextStyle: widget.labelTextStyle,
        labelFontSize: widget.labelFontSize,
        labelColor: widget.labelColor,
        inputTextStyle: widget.inputTextStyle,
        inputTextFontSize: widget.inputTextFontSize,
        inputTextColor: widget.inputTextColor,
        hintText: widget.hintText,
        hintTextStyle: widget.hintTextStyle,
        hintTextFontSize: widget.hintTextFontSize,
        hintTextColor: widget.hintTextColor,
        errorText: widget.errorText,
        errorTextStyle: widget.errorTextStyle,
        errorTextFontSize: widget.errorTextFontSize,
        errorTextColor: widget.errorTextColor,
        inputBorder: widget.inputBorder,
        inputBorderRadius: widget.inputBorderRadius,
        inputBorderColor: widget.inputBorderColor,
        suffixIcon: _defaultSuffixIcon(),
        onTextChanged: (String value) {},
      );

  Widget _defaultSuffixIcon() =>
      widget.suffixIcon ??
      Icon(
        Icons.arrow_drop_down,
        color: widget.iconColor,
      );

  TextStyle _defaultDropdownItemTextStyle() =>
      widget.dropdownItemTextStyle ??
      AppTextStyle.baseTextStyle(
        fontSize: widget.inputTextFontSize ?? AppSize.standardTextSize,
        color: widget.inputTextColor,
      );
}

class BottomDropdown<T> extends StatelessWidget {
  final T? initialItem;
  final Function(T) onSelectedItem;
  final List<T> items;
  final String Function(T?) displayText;
  final String labelText;

  const BottomDropdown({
    super.key,
    this.initialItem,
    required this.onSelectedItem,
    required this.items,
    required this.displayText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    T selectedItem = initialItem ?? items[0];
    return BaseBottomSheet(
      body: Container(
        padding: EdgeInsets.all(AppSize.standardSize),
        height: AppSize.getScreenHeight(percent: 40),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        GetUtil.backWithResult(null);
                      },
                      child: Text(
                        'Cancel',
                        style: AppTextStyle.baseTextStyle(
                          fontSize: AppSize.getTextSize(14),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      labelText,
                      style: AppTextStyle.baseTextStyle(
                        fontWeightType: FontWeightType.bold,
                        fontSize: AppSize.getTextSize(18),
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        onSelectedItem.call(selectedItem);
                        GetUtil.backWithResult(selectedItem);
                      },
                      child: Text(
                        'Done',
                        style: AppTextStyle.baseTextStyle(
                          fontSize: AppSize.getTextSize(14),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.getSize(16)),
                DropdownWheel(
                  items: items,
                  initialItem: initialItem ?? items[0],
                  onSelectedItem: (T selected) {
                    selectedItem = selected;
                  },
                  displayText: displayText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownWheel<T> extends StatefulWidget {
  final List<T> items;
  final T initialItem;
  final Function(T) onSelectedItem;
  final String Function(T) displayText;

  const DropdownWheel({
    super.key,
    required this.items,
    required this.initialItem,
    required this.onSelectedItem,
    required this.displayText,
  });

  @override
  State<DropdownWheel<T>> createState() => _DropdownPickerWidgetState<T>();
}

class _DropdownPickerWidgetState<T> extends State<DropdownWheel<T>> with TickerProviderStateMixin {
  late int _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialItem != null ? widget.items.indexWhere((element) => widget.displayText(element) == widget.displayText(widget.initialItem ?? widget.items[0])) : 0;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (scroll) {
        scroll.disallowIndicator();
        return true;
      },
      child: Flexible(
        child: ListWheelScrollView(
          controller: FixedExtentScrollController(initialItem: _selectedItem),
          physics: const FixedExtentScrollPhysics(),
          itemExtent: AppSize.getSize(40),
          useMagnifier: true,
          magnification: 1.5,
          onSelectedItemChanged: (index) {
            setState(() {
              _selectedItem = index;
              widget.onSelectedItem.call(widget.items[_selectedItem]);
            });
          },
          children: widget.items.map(
            (e) {
              int index = widget.items.indexOf(e);
              return _getItemWidget(index, e);
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget _getItemWidget(int index, dynamic item) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          vertical: AppSize.getSize(8),
        ),
        child: Text(
          widget.displayText(item),
          style: _getTextStyle(index),
        ),
      ),
    );
  }

  TextStyle _getTextStyle(int index) {
    return AppTextStyle.baseTextStyle(
      fontWeightType: _selectedItem == index ? FontWeightType.bold : FontWeightType.medium,
      color: _selectedItem == index ? Colors.black : Colors.grey,
    );
  }
}
