import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../utils/get_util.dart';
import '../../widgets/base/base_animate.dart';
import '../landing/landing_page.dart';

class SplashPage extends BasePage {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage> with BasicPage {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (!mounted) return;

        await Future.delayed(const Duration(seconds: 3));

        GetUtil.navigateTo(const LandingPage());
      },
    );
  }

  @override
  Widget body() {
    return SafeArea(
      child: Container(
        height: AppSize.getBodyHeight(),
        alignment: Alignment.center,
        child: BaseAnimate(
          animationType: AnimationType.bounceInDown,
          child: Text(
            'pokemon'.translate(),
            style: AppTextStyle.baseTextStyle(
              fontWeightType: FontWeightType.bold,
              fontSize: AppSize.getTextSize(28),
            ),
          ),
        ),
      ),
    );
  }
}
