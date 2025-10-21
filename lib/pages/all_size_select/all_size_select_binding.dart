import 'package:get/get.dart';

import 'all_size_select_logic.dart';

class AllSizeSelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllSizeSelectLogic());
  }
}