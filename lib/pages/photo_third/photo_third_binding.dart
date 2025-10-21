import 'package:get/get.dart';

import 'photo_third_logic.dart';

class PhotoThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotoThirdLogic());
  }
}