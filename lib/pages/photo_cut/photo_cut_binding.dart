import 'package:get/get.dart';

import 'photo_cut_logic.dart';

class PhotoCutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PhotoCutLogic(),
      permanent: true,
    );
  }
}
