import 'package:get/get.dart';

import '../pages/landing/landing_page.dart';
import '../pages/splash/splash_page.dart';

/// REFERENCE:
/// https://www.appwithflutter.com/flutter-state-management-with-getx/
/// https://pub.dev/packages/get/changelog
///
/// NOTE:
/// If without route Get.toNamed('/homeScreen/discoverScreen?Name=Law&Age=37') will thrown NoSuchMethodError.
/// Meaning to say won't be able to use dynamic link for navigation

class AppRouter {
  static final route = [
    GetPage(
      name: '/splashPage',
      page: () => const SplashPage(),
    ),
    GetPage(
      name: '/landingPage',
      page: () => const LandingPage(),
    ),
  ];
}
