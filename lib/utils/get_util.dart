import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';

/// REFERENCE:
/// 1. https://medium.com/flutterdevs/flutter-getx-package-cd4a5ce48ce8
/// 2. https://medium.com/flutter-community/the-flutter-getx-ecosystem-state-management-881c7235511d
/// 3. https://medium.com/flutter-community/the-flutter-getx-ecosystem-dependency-injection-8e763d0ec6b9 (Dependency Injection)

enum TransitionType {
  fade,
  fadeIn,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  rightToLeftWithFade,
  leftToRightWithFade,
  zoom,
  topLevel,
  noTransition,
  cupertino,
  cupertinoDialog,
  size,
  native,
}

enum SnackBarPositionType { top, bottom }

class GetUtil {
  static Transition getTransitionType(TransitionType? transitionType) {
    switch (transitionType) {
      case TransitionType.fade:
        return Transition.fade;
      case TransitionType.fadeIn:
        return Transition.fadeIn;
      case TransitionType.rightToLeft:
        return Transition.rightToLeft;
      case TransitionType.leftToRight:
        return Transition.leftToRight;
      case TransitionType.upToDown:
        return Transition.upToDown;
      case TransitionType.downToUp:
        return Transition.downToUp;
      case TransitionType.rightToLeftWithFade:
        return Transition.rightToLeftWithFade;
      case TransitionType.leftToRightWithFade:
        return Transition.leftToRightWithFade;
      case TransitionType.zoom:
        return Transition.zoom;
      case TransitionType.topLevel:
        return Transition.topLevel;
      case TransitionType.noTransition:
        return Transition.noTransition;
      case TransitionType.cupertino:
        return Transition.cupertino;
      case TransitionType.cupertinoDialog:
        return Transition.cupertinoDialog;
      case TransitionType.size:
        return Transition.size;
      case TransitionType.native:
        return Transition.native;
      default:
        return Transition.rightToLeft;
    }
  }

  static void showSnackBar(
    String title,
    String message, {
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    DismissDirection? dismissDirection,
    Color? backgroundColor,
    Color? textColor,
    Duration? duration,
  }) {
    if (Get.isSnackbarOpen) return;

    Get.snackbar(
      title,
      message,
      isDismissible: false,
      snackPosition: snackPosition,
      dismissDirection: dismissDirection ?? (snackPosition == SnackPosition.BOTTOM ? DismissDirection.down : DismissDirection.down),
      backgroundColor: backgroundColor ?? Colors.white,
      colorText: textColor ?? Colors.black,
      duration: duration,
      boxShadows: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  static void lightTheme() {
    Get.changeTheme(ThemeData.light());
  }

  static void darkTheme() {
    Get.changeTheme(ThemeData.dark());
  }

  static void changeTheme(ThemeData themeData) {
    Get.changeTheme(themeData);
  }

  static void changeThemeMode(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
  }

  static bool? isBottomSheetOpened() {
    return Get.isBottomSheetOpen;
  }

  static void showBottomSheet(
    Widget contentWidget, {
    Color? backgroundColor,
    Color? barrierColor,
    ShapeBorder? shapeBorder,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showFullScreen = true,
    bool useRootNavigator = false,
  }) {
    try {
      Get.bottomSheet(
        contentWidget,
        backgroundColor: backgroundColor ?? Colors.white,
        barrierColor: barrierColor,
        shape: shapeBorder ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        isScrollControlled: showFullScreen,
        useRootNavigator: useRootNavigator,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> showBottomSheetWithResult(
    Widget contentWidget, {
    Color? backgroundColor,
    Color? barrierColor,
    ShapeBorder? shapeBorder,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
  }) {
    return Get.bottomSheet(
      contentWidget,
      backgroundColor: backgroundColor ?? Colors.white,
      barrierColor: barrierColor,
      shape: shapeBorder ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
    );
  }

  static void navigateTo(
    Widget screenWidget, {
    TransitionType? transitionType,
    dynamic arguments,
    bool fullScreenDialog = false,
    bool preventDuplicates = true,
  }) {
    Get.to(
      screenWidget,
      transition: getTransitionType(transitionType),
      arguments: arguments,
      fullscreenDialog: fullScreenDialog,
      preventDuplicates: preventDuplicates,
    );
  }

  static Future<dynamic>? navigateToWithResult(
    Widget screenWidget, {
    TransitionType? transitionType,
    dynamic arguments,
    bool fullScreenDialog = false,
  }) {
    return Get.to(
      screenWidget,
      transition: getTransitionType(transitionType),
      arguments: arguments,
      fullscreenDialog: fullScreenDialog,
    );
  }

  static void navigateToNamed(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    Get.toNamed(
      page,
      arguments: arguments,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  static void back() {
    Get.back();
  }

  static void backWithResult(dynamic result) {
    Get.back(result: result);
  }

  static void backUntil(RoutePredicate predicate, {BuildContext? context}) {
    if (context != null) {
      Navigator.of(context).popUntil(predicate);
    } else {
      Get.until(predicate);
    }
  }

  /// Go back to desire page but no option to return previous screen
  static void off(Widget screenWidget, {dynamic arguments}) {
    Get.off(
      screenWidget,
      arguments: arguments,
    );
  }

  /// Go back to desire page & close all previous screens
  static void offAll(
    Widget screenWidget, {
    dynamic arguments,
    TransitionType? transitionType,
  }) {
    Get.offAll(
      () => screenWidget,
      arguments: arguments,
      transition: getTransitionType(transitionType),
    );
  }

  static Future<T?>? navigateAndRemoveUntil<T>(RoutePredicate predicate, Widget screenWidget, {BuildContext? context, String? name, dynamic arguments}) {
    return context != null
        ? Navigator.pushAndRemoveUntil<T>(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => screenWidget,
              settings: RouteSettings(
                name: name,
                arguments: arguments,
              ),
            ),
            predicate,
          )
        : Get.offUntil<T>(
            GetPageRoute(
              page: () => screenWidget,
              settings: RouteSettings(arguments: arguments),
            ),
            predicate,
          );
  }

  static Future pushNamedAndRemoveUntil(BuildContext context, String page, {String? name, dynamic arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
      page,
      (route) => false,
      arguments: arguments,
    );
  }

  static void offWithClose(
    Widget screenWidget,
    int times, {
    TransitionType? transitionType,
    dynamic arguments,
    bool preventDuplicates = true,
    bool fullScreenDialog = false,
  }) {
    Get.close(times);
    navigateTo(
      screenWidget,
      transitionType: transitionType,
      arguments: arguments,
      preventDuplicates: preventDuplicates,
      fullScreenDialog: fullScreenDialog,
    );
  }

  static dynamic getArguments() {
    return Get.arguments;
  }

  static dynamic getParameters() {
    return Get.parameters;
  }

  static String getCurrentRoute() {
    return Get.currentRoute;
  }

  static String getPreviousRoute() {
    return Get.previousRoute;
  }

  /// Dependencies will be created immediately,
  /// the dependencies load immediately and it will allocate memory for it.
  static T put<T>(
    T dependencyInjection, {
    String? tag,
    bool permanent = false,
    InstanceBuilderCallback<T>? builder,
  }) {
    return Get.put(dependencyInjection, tag: tag, permanent: permanent);
  }

  /// Asynchronous dependencies will be created immediately,
  /// the dependencies load immediately and it will allocate memory for it.
  static Future<T> putAsync<T>(Future<T> Function() builder, {String? tag, bool permanent = false}) {
    return Get.putAsync(builder, tag: tag, permanent: permanent);
  }

  /// Dependencies will be created immediately, but will be loaded to memory ONLY when Get.find is called
  static void lazyPut<T>(InstanceBuilderCallback<T> builder, {String? tag, bool permanent = false}) {
    Get.lazyPut(builder, tag: tag, fenix: permanent);
  }

  /// Creates a NEW INSTANCE of the dependency every time Get.find is called.
  /// Mostly use in the list if depends on the same controller & need to update individually.
  /// For instance:
  /// A list of check boxes
  /// Create dependency in main screen, call Get.find in item
  static void create<T>(
    InstanceBuilderCallback<T> builder, {
    String? tag,
    bool permanent = true,
  }) {
    Get.create<T>(builder, tag: tag, permanent: permanent);
  }

  static T? find<T>({String? tag}) {
    try {
      return Get.find<T>(tag: tag);
    } catch (e) {
      return null;
    }
  }

  static Widget getX<T extends DisposableInterface>({
    T? init,
    String? tag,
    required GetXControllerBuilder<T> builder,
  }) {
    return GetX<T>(
      init: init,
      tag: tag,
      builder: builder,
    );
  }

  static Widget getBuilder<T extends GetxController>({
    T? init,
    String? tag,
    required GetXControllerBuilder<T> builder,
  }) {
    return GetBuilder<T>(
      init: init,
      tag: tag,
      builder: builder,
    );
  }

  static Widget getObx(WidgetCallback builder) {
    return Obx(builder);
  }

  static Bindings bindingBuilder(BindingBuilderCallback builder) {
    return BindingsBuilder(builder);
  }

  static String translate(String text) {
    return text.tr;
  }

  static void updateLanguage(Locale language) {
    Get.updateLocale(language);
  }

  static Future<T?> showDialog<T>(Widget dialogContentWidget, {bool? barrierDismissible}) async {
    if (isDialogOpen()) Get.back();

    return Get.dialog<T>(
      dialogContentWidget,
      barrierDismissible: barrierDismissible ?? true,
    );
  }

  static bool isDialogOpen() {
    return Get.isDialogOpen ?? false;
  }
}

extension TranslationExtension on String {
  String translate() {
    return tr;
  }

  String translateWithParams(Map<String, String> params) {
    return trParams(params);
  }
}

abstract class GetUtilGetView<T> extends StatelessWidget {
  const GetUtilGetView({super.key});

  final String? tag = null;

  T get controller => GetInstance().find<T>(tag: tag)!;

  @override
  Widget build(BuildContext context);
}

abstract class GetUtilGetWidget<S extends GetLifeCycleBase?> extends GetWidgetCache {
  const GetUtilGetWidget({super.key});

  @protected
  final String? tag = null;

  S get controller => GetUtilGetWidget._cache[this] as S;

  // static final _cache = <GetWidget, GetLifeCycleBase>{};

  static final _cache = Expando<GetLifeCycleBase>();

  @protected
  Widget build(BuildContext context);

  @override
  WidgetCache createWidgetCache() => _GetCache<S>();
}

class _GetCache<S extends GetLifeCycleBase?> extends WidgetCache<GetUtilGetWidget<S>> {
  S? _controller;
  bool _isCreator = false;
  InstanceInfo? info;

  @override
  void onInit() {
    info = GetInstance().getInstanceInfo<S>(tag: widget!.tag);

    _isCreator = info!.isPrepared && info!.isCreate;

    if (info!.isRegistered) {
      _controller = Get.find<S>(tag: widget!.tag);
    }

    GetUtilGetWidget._cache[widget!] = _controller;
    super.onInit();
  }

  @override
  void onClose() {
    if (_isCreator) {
      Get.asap(() {
        widget!.controller!.onDelete();
        Get.log('"${widget!.controller.runtimeType}" onClose() called');
        Get.log('"${widget!.controller.runtimeType}" deleted from memory');
        GetUtilGetWidget._cache[widget!] = null;
      });
    }
    info = null;
    super.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return widget!.build(context);
  }
}
