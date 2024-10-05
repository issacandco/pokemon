import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/flavors.dart';
import 'main.dart' as runner;
import 'utils/get_storage_util.dart';

Future<void> main() async {
  F.appFlavor = Flavor.production;
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await GetStorageUtil.initGetStorage();
  await runner.main();
}
