import 'package:get/get.dart';
import 'en_us.dart';
import 'zh_cn.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': english,
        'zh_CN': chinese,
      };
}
