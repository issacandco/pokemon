import 'package:flutter/material.dart';

import '../../../constants/app_size.dart';
import '../../../constants/app_text_style.dart';
import '../../../utils/get_util.dart';
import '../base_text_field.dart';
import 'country_code_sheet.dart';
import 'country_model.dart';
import 'mobile_number.dart';

class BaseMobile extends StatefulWidget {
  final ValueChanged<MobileNumber>? onTextChanged;
  final FormFieldSetter<MobileNumber>? onSaved;
  final MobileNumber? initialValue;
  final bool enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String initialCountryCode;
  final TextStyle? countryCodeTextStyle;
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
  final bool hasLabel;

  const BaseMobile({
    super.key,
    this.onTextChanged,
    this.onSaved,
    this.initialValue,
    this.enabled = true,
    this.controller,
    this.focusNode,
    this.initialCountryCode = '+60',
    this.countryCodeTextStyle,
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
    this.hasLabel = true,
  });

  @override
  BaseMobileState createState() => BaseMobileState();
}

class BaseMobileState extends State<BaseMobile> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  CountryModel? _selectedCountry;

  String? _countryCode;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _countryCode = widget.initialCountryCode;

    if (widget.initialValue != null) {
      _countryCode = widget.initialValue!.countryCode;
      _controller.text = widget.initialValue!.number;
    }
  }

  @override
  void didUpdateWidget(covariant BaseMobile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != null && widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue!.number;
      _countryCode = widget.initialValue!.countryCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      controller: _controller,
      onTextChanged: (value) async {
        final mobileNumber = MobileNumber(
          countryCode: _selectedCountry != null ? _selectedCountry!.phoneCode.toString() : widget.initialCountryCode,
          number: value,
        );

        widget.onTextChanged?.call(mobileNumber);
      },
      onSaved: (value) {
        widget.onSaved?.call(
          MobileNumber(
            countryCode: _selectedCountry != null ? _selectedCountry!.phoneCode.toString() : widget.initialCountryCode,
            number: value!,
          ),
        );
      },
      focusNode: _focusNode,
      enabled: widget.enabled,
      textInputType: TextInputType.phone,
      prefixIcon: widget.hasLabel ? null : _buildPrefixCountryCode(),
      prefix: widget.hasLabel ? _buildPrefixCountryCode() : null,
      maxLines: 1,
      maxLength: 11,
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
    );
  }

  Widget _buildPrefixCountryCode() {
    return GestureDetector(
      onTap: () async {
        if (!widget.enabled) return;

        CountryModel? countryModel = await GetUtil.showBottomSheetWithResult(
          const CountryCodeSheet(),
          isScrollControlled: true,
        );

        if (countryModel != null) {
          setState(() {
            _selectedCountry = countryModel;
            _countryCode = countryModel.phoneCode;
          });
        }

        final mobileNumber = MobileNumber(
          countryCode: _selectedCountry != null ? _selectedCountry!.phoneCode.toString() : widget.initialCountryCode,
          number: _controller.text,
        );
        widget.onTextChanged?.call(mobileNumber);
      },
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_countryCode',
              style: widget.inputTextStyle ?? _defaultCountryCodeTextStyle(),
            ),
            widget.enabled ? SizedBox(width: AppSize.getSize(8)) : const SizedBox.shrink(),
            widget.enabled
                ? Icon(
                    Icons.arrow_drop_down_rounded,
                    color: widget.labelColor,
                  )
                : const SizedBox.shrink(),
            widget.enabled ? SizedBox(width: AppSize.getSize(8)) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  TextStyle _defaultCountryCodeTextStyle() =>
      widget.countryCodeTextStyle ??
      AppTextStyle.baseTextStyle(
        fontSize: widget.inputTextFontSize ?? AppSize.standardTextSize,
        color: widget.inputTextColor ?? Colors.black,
      );
}
