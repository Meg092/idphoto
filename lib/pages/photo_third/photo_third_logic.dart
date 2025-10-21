import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_photo/db_photo/db_photo.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PhotoThirdLogic extends GetxController {

  DbPhoto dbPhoto = Get.find();

  var appVersion = '1.0.0'.obs;

  cleanPhotoData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all data?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbPhoto.cleanPhotoData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    var info = await PackageInfo.fromPlatform();
    appVersion.value = info.version;
    super.onInit();
  }

}
