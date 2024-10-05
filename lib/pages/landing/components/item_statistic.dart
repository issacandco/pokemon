import 'package:flutter/cupertino.dart';

import '../../../constants/app_color.dart';
import '../../../constants/app_size.dart';
import '../../../constants/app_text_style.dart';

class ItemStatistic extends StatelessWidget {
  final int? count;
  final String label;

  const ItemStatistic({
    super.key,
    this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count?.toString() ?? '0',
          style: AppTextStyle.baseTextStyle(
            fontWeightType: FontWeightType.bold,
            fontSize: AppSize.getSize(22),
            color: AppColor.gray,
          ),
        ),
        SizedBox(height: AppSize.getSize(4)),
        Text(
          label,
          style: AppTextStyle.baseTextStyle(
            fontWeightType: FontWeightType.bold,
            fontSize: AppSize.getTextSize(16),
          ),
        ),
      ],
    );
  }
}
