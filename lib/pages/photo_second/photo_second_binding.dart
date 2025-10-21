import 'package:get/get.dart';

import 'photo_second_logic.dart';

class PhotoSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotoSecondLogic());
  }
}