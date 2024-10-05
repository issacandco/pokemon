import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../appearance/app_themes.dart';
import '../../../dependencies/dependencies.dart';
import '../../../languages/messages.dart';
import '../../../routes/app_router.dart';
import '../../constants/constants.dart';
import '../../pages/error/error_page.dart';
import '../../pages/unknown/unknown_page.dart';
import '../../utils/general_util.dart';
import '../../utils/get_storage_util.dart';
import '../../utils/get_util.dart';
import '../appearance/app_theme_manager.dart';
import 'flavors.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppThemeManager _appThemeManager = GetUtil.put(AppThemeManager());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _initAppTheme();
    });
  }

  Future<void> _initAppTheme() async {
    await _appThemeManager.initAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: GeneralUtil.getDeviceSize(context),
      builder: (context, _) => _buildGetMaterialApp(),
    );
  }

  Widget _buildGetMaterialApp() {
    return GetX<AppThemeManager>(
      builder: (controller) {
        ThemeMode themeMode;
        switch (controller.appThemeTypeStream.value) {
          case AppThemeModeType.light:
            themeMode = ThemeMode.light;
            break;
          case AppThemeModeType.dark:
            themeMode = ThemeMode.dark;
            break;
          default:
            themeMode = ThemeMode.system;
            break;
        }

        return GetMaterialApp(
          title: F.title,
          translations: Messages(),
          fallbackLocale: const Locale('en', 'US'),
          locale: _getLocale(),
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: themeMode,
          initialBinding: Dependencies(),
          defaultTransition: GetUtil.getTransitionType(TransitionType.rightToLeft),
          getPages: AppRouter.route,
          initialRoute: '/splashPage',
          unknownRoute: GetPage(
            name: '/unknownPage',
            page: () => const UnknownPage(),
            transition: Transition.fade,
          ),
          navigatorObservers: const [
            // Add your navigator observers here if needed
          ],
          builder: (context, widget) {
            ErrorWidget.builder = (errorDetails) {
              return ErrorPage(
                errorMessage: errorDetails.summary.toString(),
              );
            };
            return widget!;
          },
        );
      },
    );
  }

  Locale _getLocale() {
    final storedLang = GetStorageUtil.readFromGetStorage<String>(key: Constants.keyLang);
    return storedLang == null || storedLang == 'en' ? const Locale('en', 'US') : const Locale('zh', 'CN');
  }
}
