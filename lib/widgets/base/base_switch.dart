import 'package:flutter/material.dart';

import '../../constants/app_color.dart';

class BaseSwitch extends StatefulWidget {
  const BaseSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = AppColor.primaryColor,
    this.inactiveColor = Colors.grey,
    this.activeTextColor = Colors.white70,
    this.inactiveTextColor = Colors.white70,
    this.toggleColor = Colors.white,
    this.activeToggleColor,
    this.inactiveToggleColor,
    this.width = 50.0,
    this.height = 25.0,
    this.toggleSize = 20.0,
    this.valueFontSize = 16.0,
    this.borderRadius = 20.0,
    this.padding = 4.0,
    this.showOnOff = false,
    this.activeText,
    this.inactiveText,
    this.activeTextFontWeight,
    this.inactiveTextFontWeight,
    this.switchBorder,
    this.activeSwitchBorder,
    this.inactiveSwitchBorder,
    this.toggleBorder,
    this.activeToggleBorder,
    this.inactiveToggleBorder,
    this.activeIcon,
    this.inactiveIcon,
    this.duration = const Duration(milliseconds: 200),
    this.disabled = false,
  })  : assert(
            (switchBorder == null || activeSwitchBorder == null) && (switchBorder == null || inactiveSwitchBorder == null),
            'Cannot provide switchBorder when an activeSwitchBorder or inactiveSwitchBorder was given\n'
            'To give the switch a border, use "activeSwitchBorder: border" or "inactiveSwitchBorder: border".'),
        assert(
            (toggleBorder == null || activeToggleBorder == null) && (toggleBorder == null || inactiveToggleBorder == null),
            'Cannot provide toggleBorder when an activeToggleBorder or inactiveToggleBorder was given\n'
            'To give the toggle a border, use "activeToggleBorder: color" or "inactiveToggleBorder: color".');

  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showOnOff;
  final String? activeText;
  final String? inactiveText;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final FontWeight? activeTextFontWeight;
  final FontWeight? inactiveTextFontWeight;
  final Color toggleColor;
  final Color? activeToggleColor;
  final Color? inactiveToggleColor;
  final double width;
  final double height;
  final double toggleSize;
  final double valueFontSize;
  final double borderRadius;
  final double padding;
  final BoxBorder? switchBorder;
  final BoxBorder? activeSwitchBorder;
  final BoxBorder? inactiveSwitchBorder;
  final BoxBorder? toggleBorder;
  final BoxBorder? activeToggleBorder;
  final BoxBorder? inactiveToggleBorder;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final Duration duration;
  final bool disabled;

  @override
  State<BaseSwitch> createState() => BaseSwitchState();
}

class BaseSwitchState extends State<BaseSwitch> with SingleTickerProviderStateMixin {
  late final Animation<Alignment> _toggleAnimation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
      duration: widget.duration,
    );
    _toggleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BaseSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color toggleColor = widget.value ? (widget.activeToggleColor ?? widget.toggleColor) : (widget.inactiveToggleColor ?? widget.toggleColor);
    Color switchColor = widget.value ? widget.activeColor : widget.inactiveColor;
    BoxBorder? switchBorder = widget.value ? (widget.activeSwitchBorder ?? widget.switchBorder) : (widget.inactiveSwitchBorder ?? widget.switchBorder);
    BoxBorder? toggleBorder = widget.value ? (widget.activeToggleBorder ?? widget.toggleBorder) : (widget.inactiveToggleBorder ?? widget.toggleBorder);

    double textSpace = widget.width - widget.toggleSize;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Align(
          child: GestureDetector(
            onTap: () {
              if (!widget.disabled) {
                widget.onChanged(!widget.value);
                widget.value ? _animationController.forward() : _animationController.reverse();
              }
            },
            child: Opacity(
              opacity: widget.disabled ? 0.6 : 1,
              child: Container(
                width: widget.width,
                height: widget.height,
                padding: EdgeInsets.all(widget.padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  color: switchColor,
                  border: switchBorder,
                ),
                child: Stack(
                  children: <Widget>[
                    _buildActiveText(textSpace),
                    _buildInactiveText(textSpace),
                    _buildToggle(toggleColor, toggleBorder),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActiveText(double textSpace) {
    return AnimatedOpacity(
      opacity: widget.value ? 1.0 : 0.0,
      duration: widget.duration,
      child: Container(
        width: textSpace,
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        alignment: Alignment.centerLeft,
        child: widget.showOnOff
            ? Text(
                widget.activeText ?? 'On',
                style: TextStyle(
                  color: widget.activeTextColor,
                  fontWeight: widget.activeTextFontWeight ?? FontWeight.w900,
                  fontSize: widget.valueFontSize,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildInactiveText(double textSpace) {
    return Align(
      alignment: Alignment.centerRight,
      child: AnimatedOpacity(
        opacity: !widget.value ? 1.0 : 0.0,
        duration: widget.duration,
        child: Container(
          width: textSpace,
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          alignment: Alignment.centerRight,
          child: widget.showOnOff
              ? Text(
                  widget.inactiveText ?? 'Off',
                  style: TextStyle(
                    color: widget.inactiveTextColor,
                    fontWeight: widget.inactiveTextFontWeight ?? FontWeight.w900,
                    fontSize: widget.valueFontSize,
                  ),
                  textAlign: TextAlign.right,
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildToggle(Color toggleColor, BoxBorder? toggleBorder) {
    return Align(
      alignment: _toggleAnimation.value,
      child: Container(
        width: widget.toggleSize,
        height: widget.toggleSize,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: toggleColor,
          border: toggleBorder,
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Stack(
            children: [
              Center(
                child: AnimatedOpacity(
                  opacity: widget.value ? 1.0 : 0.0,
                  duration: widget.duration,
                  child: widget.activeIcon,
                ),
              ),
              Center(
                child: AnimatedOpacity(
                  opacity: !widget.value ? 1.0 : 0.0,
                  duration: widget.duration,
                  child: widget.inactiveIcon,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
