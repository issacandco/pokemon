import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../base/base_view_model.dart';
import '../../utils/get_util.dart';

class SortViewModel extends BaseViewModel {
  RxList<String> sortByList = <String>['name'.translate(), 'id'.translate()].obs;
}
