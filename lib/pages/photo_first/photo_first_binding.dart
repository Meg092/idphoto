import 'package:get/get.dart';

import 'photo_first_logic.dart';

class PhotoFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotoFirstLogic());
  }
}