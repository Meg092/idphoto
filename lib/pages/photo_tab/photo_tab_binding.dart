import 'package:get/get.dart';
import 'package:id_photo/pages/photo_first/photo_first_logic.dart';
import 'package:id_photo/pages/photo_second/photo_second_logic.dart';

import '../photo_third/photo_third_logic.dart';
import 'photo_tab_logic.dart';

class PhotoTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotoTabLogic());
    Get.lazyPut(() => PhotoFirstLogic());
    Get.lazyPut(() => PhotoSecondLogic());
    Get.lazyPut(() => PhotoThirdLogic());
  }
}