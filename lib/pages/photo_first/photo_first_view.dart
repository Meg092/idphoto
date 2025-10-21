import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_photo/main.dart';
import 'package:styled_widget/styled_widget.dart';

import 'photo_first_logic.dart';

class PhotoFirstPage extends GetView<PhotoFirstLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            const Text(
              'ID Photo',
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 157 / 210),
                itemCount: 4,
                itemBuilder: (_, index) {
                  return Container(
                    child: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          controller.titles[index],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                      ).decorated(
                          color: primaryColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/img$index.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                  ).decorated(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xffdbdbdb))).gestures(onTap: (){
                        Get.toNamed('/photoDetail',arguments: photoSizes[index]);
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: <Widget>[
                const Text(
                  'Other more sizes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                Image.asset('assets/icon0.png',fit: BoxFit.cover,)
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            ).decorated(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xffdbdbdb))).gestures(onTap: (){
                  Get.toNamed('/allSizeSelect');
            })
          ].toColumn(),
        ).marginSymmetric(horizontal: 20)),
      ),
    );
  }
}
