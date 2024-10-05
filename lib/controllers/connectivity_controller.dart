import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityController extends GetxController {
  RxBool isOnline = true.obs;

  late final InternetConnection _internetConnection;
  late StreamSubscription<InternetStatus> _listener;

  @override
  void onInit() {
    super.onInit();

    _internetConnection = InternetConnection();

    // Listen to status changes and update `isOnline` accordingly
    _listener = _internetConnection.onStatusChange.listen((InternetStatus status) {
      isOnline.value = (status == InternetStatus.connected);
    });

    // Initial connection status check
    _checkInitialConnection();
  }

  // Check the initial connection status when the app starts
  Future<void> _checkInitialConnection() async {
    isOnline.value = await _internetConnection.hasInternetAccess;
  }

  @override
  void onClose() {
    // Cancel the stream listener to prevent memory leaks
    _listener.cancel();
    super.onClose();
  }
}
