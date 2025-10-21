import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_photo/main.dart';
import 'package:styled_widget/styled_widget.dart';

import 'photo_third_logic.dart';

class PhotoThirdPage extends GetView<PhotoThirdLogic> {
  Widget _item(int index, BuildContext context) {
    final titles = ['Clean all data', 'App version'];
    return Container(
      color: Colors.transparent,
      height: 40,
      child: <Widget>[
        Text(titles[index]),
        index == 0
            ? const Icon(
                Icons.keyboard_arrow_right,
                size: 20,
                color: Colors.grey,
              )
            : Obx(() {
                return Text(
                  controller.appVersion.value,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                );
              })
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).gestures(onTap: () {
      if (index == 0) {
        controller.cleanPhotoData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Setting"),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: <Widget>[_item(0, context), _item(1, context)].toColumn(
                  separator: Divider(
                height: 15,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12))
          ].toColumn(),
        ).marginAll(15)),
      ).decorated(
          gradient: LinearGradient(
              colors: [const Color(0xfffaf1dc), bgColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops:const [0.0, 0.7])),
    );
  }
}
