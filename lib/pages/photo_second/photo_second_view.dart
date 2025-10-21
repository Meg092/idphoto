import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../main.dart';
import 'photo_second_logic.dart';

class PhotoSecondPage extends GetView<PhotoSecondLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Saved'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(child: Obx(() {
          return controller.list.isEmpty
              ? const Center(
                  child: Text('No saved photos'),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 104 / 135),
                  itemCount: controller.list.length,
                  itemBuilder: (_, index) {
                    final entity = controller.list[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(
                        entity.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  });
        })),
      ).decorated(
          gradient: LinearGradient(
              colors: [const Color(0xfffaf1dc), bgColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.7])),
    );
  }
}
