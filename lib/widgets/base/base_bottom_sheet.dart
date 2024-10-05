import 'package:flutter/material.dart';

import '../../utils/general_util.dart';

class BaseBottomSheet extends StatelessWidget {
  final Widget body;

  const BaseBottomSheet({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GeneralUtil.hideKeyboard(context),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            body,
          ],
        ),
      ),
    );
  }
}
