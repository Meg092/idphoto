import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_photo/pages/photo_first/photo_first_view.dart';
import 'package:id_photo/pages/photo_second/photo_second_logic.dart';
import 'package:id_photo/pages/photo_second/photo_second_view.dart';
import 'package:id_photo/pages/photo_third/photo_third_view.dart';

import 'photo_tab_logic.dart';

class PhotoTabPage extends GetView<PhotoTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          PhotoFirstPage(),
          PhotoSecondPage(),
          PhotoThirdPage()
        ],
      ),
      bottomNavigationBar: Obx(()=>_navPhBars()),
    );
  }

  Widget _navPhBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/item0Grey.png',fit: BoxFit.cover,width: 22,height: 22,),
          activeIcon:Image.asset('assets/item0Light.png',fit: BoxFit.cover,width: 22,height: 22,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/item1Grey.png',fit: BoxFit.cover,width: 22,height: 22,),
          activeIcon:Image.asset('assets/item1Light.png',fit: BoxFit.cover,width: 22,height: 22,),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/item2Grey.png',fit: BoxFit.cover,width: 22,height: 22,),
          activeIcon:Image.asset('assets/item2Light.png',fit: BoxFit.cover,width: 22,height: 22,),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        controller.currentIndex.value = index;
        controller.pageController.jumpToPage(index);
        if (index == 1) {
          PhotoSecondLogic photoSecondLogic = Get.find<PhotoSecondLogic>();
          photoSecondLogic.getData();
        }
      },
    );
  }
}
