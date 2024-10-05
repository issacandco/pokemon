import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../appearance/app_themes.dart';
import '../constants/constants.dart';
import '../utils/get_storage_util.dart';
import '../utils/get_util.dart';

enum AppThemeModeType { system, light, dark }

class AppThemeManager extends GetxController {
  Rx<AppThemeModeType> appThemeTypeStream = AppThemeModeType.system.obs;

  Future<void> initAppTheme() async {
    await getAppTheme();
    _changeAppTheme();
  }

  void setAppThemeType(AppThemeModeType value) {
    appThemeTypeStream.value = value;
    saveAppTheme();
    _changeAppTheme();
  }

  _changeAppTheme() {
    if (appThemeTypeStream.value == AppThemeModeType.light) {
      GetUtil.changeTheme(AppThemes.lightTheme);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    } else if (appThemeTypeStream.value == AppThemeModeType.dark) {
      GetUtil.changeTheme(AppThemes.darkTheme);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      if (brightness == Brightness.dark) {
        GetUtil.changeTheme(AppThemes.darkTheme);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      } else {
        GetUtil.changeTheme(AppThemes.lightTheme);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      }
    }
  }

  void saveAppTheme() {
    GetStorageUtil.saveIntoGetStorage(key: Constants.keyAppTheme, value: appThemeTypeStream.value.name.toString());
  }

  Future<void> getAppTheme() async {
    String? appThemeType = GetStorageUtil.readFromGetStorage<String>(key: Constants.keyAppTheme);

    switch (appThemeType) {
      case 'light':
        appThemeTypeStream.value = AppThemeModeType.light;
        break;
      case 'dark':
        appThemeTypeStream.value = AppThemeModeType.dark;
        break;
      default:
        appThemeTypeStream.value = AppThemeModeType.system;
        break;
    }
  }
}
