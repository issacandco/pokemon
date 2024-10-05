import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_color.dart';
import '../constants/app_size.dart';
import '../constants/app_text_style.dart';
import '../widgets/base/base_radio_button.dart';
import 'app_theme_manager.dart';

class AppThemeChoice extends StatelessWidget {
  const AppThemeChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<AppThemeManager>(
          builder: (manager) {
            AppThemeModeType appThemeModeType = manager.appThemeTypeStream.value;

            return Container(
              padding: EdgeInsets.all(AppSize.standardSize),
              height: AppSize.getScreenHeight(),
              color: Theme.of(context).bottomSheetTheme.backgroundColor,
              child: Column(
                children: [
                  _buildTitleBar(),
                  _buildAppThemeChoiceList(appThemeModeType, manager),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitleBar() {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Appearance',
            style: AppTextStyle.baseTextStyle(
              fontSize: AppSize.getTextSize(22),
              fontWeightType: FontWeightType.bold,
            ),
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              radius: AppSize.getSize(18),
              backgroundColor: AppColor.primaryColor,
              child: const Icon(
                Icons.close,
                color: AppColor.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAppThemeChoiceList(AppThemeModeType appThemeModeType, AppThemeManager manager) => Column(
        children: [
          BaseRadioButton<AppThemeModeType>(
            value: AppThemeModeType.system,
            groupValue: appThemeModeType,
            label: 'Same as device',
            labelWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Same as device',
                  style: AppTextStyle.baseTextStyle(
                    fontSize: AppSize.getTextSize(16),
                  ),
                ),
                Text(
                  'Uses light or dark theme based on your device settings',
                  style: AppTextStyle.baseTextStyle(
                    fontSize: AppSize.getTextSize(14),
                    color: AppColor.gray,
                  ),
                ),
              ],
            ),
            onChanged: (value) {
              manager.setAppThemeType(value);
            },
          ),
          BaseRadioButton<AppThemeModeType>(
            value: AppThemeModeType.light,
            groupValue: appThemeModeType,
            label: 'Light',
            onChanged: (value) {
              manager.setAppThemeType(value);
            },
          ),
          BaseRadioButton<AppThemeModeType>(
            value: AppThemeModeType.dark,
            groupValue: appThemeModeType,
            label: 'Dark',
            onChanged: (value) {
              manager.setAppThemeType(value);
            },
          ),
        ],
      );
}
