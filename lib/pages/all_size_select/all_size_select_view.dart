import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_photo/main.dart';
import 'package:styled_widget/styled_widget.dart';

import 'all_size_select_logic.dart';

class AllSizeSelectPage extends GetView<AllSizeSelectLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Size'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 167 / 56),
              itemCount: photoSizes.length,
              itemBuilder: (_, index) {
                final entity = photoSizes[index];
                return Container(
                        alignment: Alignment.center, child: Text(entity.name))
                    .decorated(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffdbdbdb)))
                    .gestures(onTap: () {
                  Get.toNamed('/photoDetail', arguments: photoSizes[index]);
                });
              }),
        ),
      ),
    );
  }
}
