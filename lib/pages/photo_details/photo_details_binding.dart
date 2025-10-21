import 'package:get/get.dart';

import 'photo_details_logic.dart';

class PhotoDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotoDetailsLogic());
  }
}