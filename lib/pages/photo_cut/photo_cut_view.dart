import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'photo_cut_logic.dart';

class PhotoCutView extends GetView<PhotoCutLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.stracke.value
              ? const CircularProgressIndicator(color: Colors.yellow)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.hyvqr();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
