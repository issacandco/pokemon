import 'package:flutter/material.dart';

import '../constants/app_size.dart';
import '../constants/app_text_style.dart';
import '../utils/general_util.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BaseState<Page extends BasePage> extends State<Page> with AutomaticKeepAliveClientMixin {
}

mixin BasicPage<Page extends BasePage> on BaseState<Page> {
  PreferredSizeWidget? appBar() => null;
  Widget body();
  Widget? sideMenuDrawer() => null;
  Widget? bottomNavigationBar() => null;
  Widget? floatingActionButton() => null;

  bool extendBodyBehindAppBar = false;
  bool? resizeToAvoidBottomInset;
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  final bool _keepAlive = false;
  // final ConnectivityController connectivityController = GetUtil.find<ConnectivityController>()!;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => GeneralUtil.hideKeyboard(context),
      child: Scaffold(
        key: globalKey,
        appBar: appBar(),
        body: Container(
          color: Theme.of(context).colorScheme.surface,
          child: body(),
        ),
        drawer: sideMenuDrawer(),
        bottomNavigationBar: bottomNavigationBar(),
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        extendBodyBehindAppBar: appBar() == null ? true : extendBodyBehindAppBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      ),
    );
  }

  Widget _buildNoInternetStatusBar() {
    return Container(
      width: AppSize.getScreenWidth(),
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.all(AppSize.getSize(8)),
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, color: Colors.white),
          SizedBox(width: AppSize.getSize(8)),
          Text('No internet connection', style: AppTextStyle.baseTextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => _keepAlive;
}
