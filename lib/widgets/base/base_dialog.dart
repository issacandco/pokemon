import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../utils/get_util.dart';

class BaseDialog {
  static Future<T?> show<T>({
    String? title,
    String? message,
    String? positiveLabel,
    String? negativeLabel,
    VoidCallback? positiveAction,
    VoidCallback? negativeAction,
    List<Widget>? actionList,
    Color? backgroundColor,
    Color? positiveBackgroundColor,
    bool barrierDismissible = true,
    double paddingSize = 16,
    WrapAlignment wrapAlignment = WrapAlignment.center,
    bool isDefaultActionEnabled = true,
    bool isAutoDismissDialog = true,
    Widget? child,
  }) async {
    return GetUtil.showDialog(
      _BaseDialogWidget(
        title: title,
        message: message,
        positiveLabel: positiveLabel,
        negativeLabel: negativeLabel,
        positiveAction: positiveAction,
        negativeAction: negativeAction,
        actionList: actionList,
        backgroundColor: backgroundColor,
        positiveBackgroundColor: positiveBackgroundColor,
        barrierDismissible: barrierDismissible,
        paddingSize: paddingSize,
        wrapAlignment: wrapAlignment,
        isDefaultActionEnabled: isDefaultActionEnabled,
        isAutoDismissDialog: isAutoDismissDialog,
        child: child,
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}

class _BaseDialogWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final String? positiveLabel;
  final String? negativeLabel;
  final VoidCallback? positiveAction;
  final VoidCallback? negativeAction;
  final List<Widget>? actionList;
  final Color? backgroundColor;
  final Color? positiveBackgroundColor;
  final bool barrierDismissible;
  final double paddingSize;
  final WrapAlignment wrapAlignment;
  final bool isDefaultActionEnabled;
  final bool isAutoDismissDialog;
  final Widget? child;

  const _BaseDialogWidget({
    this.title,
    this.message,
    this.positiveLabel,
    this.negativeLabel,
    this.positiveAction,
    this.negativeAction,
    this.actionList,
    this.backgroundColor,
    this.positiveBackgroundColor,
    this.barrierDismissible = true,
    this.paddingSize = 16,
    this.wrapAlignment = WrapAlignment.center,
    this.isDefaultActionEnabled = true,
    this.isAutoDismissDialog = true,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: barrierDismissible,
      child: _buildDialogWidget(context),
    );
  }

  Widget _buildDialogWidget(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.getSize(8)),
      ),
      insetPadding: EdgeInsets.all(AppSize.standardSize),
      elevation: 0,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(paddingSize),
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(AppSize.getSize(8)),
          ),
          child: child ?? _buildDialogContent(context),
        ),
      ),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.only(bottom: AppSize.getSize(24)),
            child: Text(
              title!,
              style: AppTextStyle.baseTextStyle(
                fontWeightType: FontWeightType.bold,
              ),
            ),
          ),
        if (message != null)
          Text(
            message!,
            style: AppTextStyle.baseTextStyle(fontWeightType: FontWeightType.medium),
          ),
        SizedBox(height: AppSize.getSize(16)),
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final actionWidgets = _buildActionWidgets(context);

    return Column(
      children: actionWidgets.map((widget) {
        final isLast = widget == actionWidgets.last;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : AppSize.getSize(8)),
          child: widget,
        );
      }).toList(),
    );
  }

  List<Widget> _buildActionWidgets(BuildContext context) {
    if (!isDefaultActionEnabled) return [];

    final widgets = <Widget>[
      ActionButton(
        label: positiveLabel ?? 'OK',
        onPressed: () {
          if (isAutoDismissDialog) {
            GetUtil.back();
          }
          positiveAction?.call();
        },
        backgroundColor: positiveBackgroundColor ?? AppColor.primaryColor,
      ),
    ];

    if (negativeAction != null) {
      widgets.add(ActionButton(
        label: negativeLabel ?? 'Cancel',
        onPressed: () {
          if (isAutoDismissDialog) {
            GetUtil.back();
          }
          negativeAction?.call();
        },
        isNegativeAction: true,
        fontColor: Theme.of(context).colorScheme.primary,
      ));
    }

    if (actionList != null) {
      widgets.addAll(actionList!);
    }

    return widgets;
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? fontColor;
  final bool isNegativeAction;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.fontColor,
    this.isNegativeAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSize.getSize(10)),
      decoration: BoxDecoration(
        color: !isNegativeAction ? backgroundColor ?? AppColor.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSize.getSize(4)),
        border: Border.all(
          color: isNegativeAction ? AppColor.gray : Colors.transparent,
          width: AppSize.getSize(1),
        ),
      ),
      width: double.infinity,
      child: InkWell(
        onTap: onPressed,
        child: Text(
          label,
          style: AppTextStyle.baseTextStyle(
            fontWeightType: FontWeightType.bold,
            fontSize: AppSize.getTextSize(14),
            color: fontColor ?? AppColor.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
