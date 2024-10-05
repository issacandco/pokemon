import 'dart:async';

import 'package:flutter/material.dart';

import 'app/app.dart';
import 'controllers/connectivity_controller.dart';
import 'utils/get_util.dart';

FutureOr<void> main() async {
  GetUtil.put(ConnectivityController(), permanent: true);
  runApp(const App());
}
