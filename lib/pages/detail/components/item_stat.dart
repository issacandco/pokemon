import 'package:flutter/cupertino.dart';

import '../../../constants/app_size.dart';
import '../../../constants/app_text_style.dart';
import '../../../utils/string_util.dart';

class ItemStat extends StatelessWidget {
  const ItemStat({
    super.key,
    required this.stat,
    required this.value,
  });

  final String stat;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              stat.toCapitalized(),
              style: AppTextStyle.baseTextStyle(
                fontWeightType: FontWeightType.medium,
              ),
            ),
          ),
        ),
        SizedBox(width: AppSize.getSize(24)),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: AppTextStyle.baseTextStyle(
                fontWeightType: FontWeightType.semiBold,
                fontSize: AppSize.getTextSize(18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
