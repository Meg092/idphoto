import 'package:get/get.dart';
import 'package:id_photo/db_photo/db_photo.dart';
import 'package:id_photo/db_photo/photo_entity.dart';

class PhotoSecondLogic extends GetxController {

  DbPhoto dbPhoto = Get.find();

  var list = <PhotoEntity>[].obs;

  void getData() async {
    list.value = await dbPhoto.getPhotoAllData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
