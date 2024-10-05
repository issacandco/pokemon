import 'package:flutter/material.dart';

import '../../../constants/app_size.dart';
import '../../../constants/app_text_style.dart';
import '../../../controllers/connectivity_controller.dart';
import '../../../utils/get_util.dart';
import '../../../widgets/base/base_dialog.dart';

class ItemMenu extends StatelessWidget {
  ItemMenu({super.key, required this.menu});

  final Map<String, dynamic> menu;

  final ConnectivityController _connectivityController = GetUtil.find<ConnectivityController>()!;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_connectivityController.isOnline.value) {
          menu['tap'].call();
        } else {
          BaseDialog.show(message: 'required_internet_connection'.translate());
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(AppSize.getSize(12)),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: menu['icon'],
          ),
          Text(
            menu['label'],
            style: AppTextStyle.baseTextStyle(
              fontWeightType: FontWeightType.semiBold,
              fontSize: AppSize.getTextSize(14),
            ),
          )
        ],
      ),
    );
  }
}
