import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:id_photo/db_photo/db_photo.dart';
import 'package:image_picker/image_picker.dart';

import '../../db_photo/photo_entity.dart';

class PhotoDetailsLogic extends GetxController {

  DbPhoto dbPhoto = Get.find();

  IDPhotoSize currentSize = Get.arguments;

  var style = 0.obs;
  var currentClothes = 0.obs;
  bool isCreate = false;

  Uint8List? selectedImage;

  void imageSelected() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(imageQuality: 90,maxWidth: 1024,source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        selectedImage = imageBytes;
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Please check album permissions or select a new image');
      return;
    }
  }

}
