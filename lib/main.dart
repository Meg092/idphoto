import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:id_photo/db_photo/db_photo.dart';
import 'package:id_photo/pages/all_size_select/all_size_select_binding.dart';
import 'package:id_photo/pages/all_size_select/all_size_select_view.dart';
import 'package:id_photo/pages/photo_details/photo_details_binding.dart';
import 'package:id_photo/pages/photo_details/photo_details_view.dart';
import 'package:id_photo/pages/photo_first/photo_first_binding.dart';
import 'package:id_photo/pages/photo_first/photo_first_view.dart';
import 'package:id_photo/pages/photo_second/photo_second_binding.dart';
import 'package:id_photo/pages/photo_second/photo_second_view.dart';
import 'package:id_photo/pages/photo_tab/photo_tab_binding.dart';
import 'package:id_photo/pages/photo_tab/photo_tab_view.dart';
import 'package:id_photo/pages/photo_third/photo_third_binding.dart';
import 'package:id_photo/pages/photo_third/photo_third_view.dart';

import 'db_photo/photo_entity.dart';

Color primaryColor = const Color(0xffffda60);
Color bgColor = const Color(0xfffafafa);

final List<IDPhotoSize> photoSizes = [
  IDPhotoSize(name: '1 inch', widthMm: 25.0, heightMm: 35.0),
  IDPhotoSize(name: '2 inch', widthMm: 35.0, heightMm: 49.0),
  IDPhotoSize(name: '3 inch', widthMm: 63.5, heightMm: 88.9),
  IDPhotoSize(name: '4 inch', widthMm: 89.0, heightMm: 119.0),
  IDPhotoSize(name: 'Small 1 inch', widthMm: 22.0, heightMm: 32.0),
  IDPhotoSize(name: 'Large 1 inch', widthMm: 33.0, heightMm: 48.0),
  IDPhotoSize(name: 'Passport', widthMm: 33.0, heightMm: 48.0),
  IDPhotoSize(name: 'Visa', widthMm: 35.0, heightMm: 45.0),
  IDPhotoSize(name: 'ID Card', widthMm: 26.0, heightMm: 32.0),
  IDPhotoSize(name: 'Driver License', widthMm: 22.0, heightMm: 32.0),
];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Get.putAsync(() => DbPhoto().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: IDCollection,
      initialRoute:'/photoTab',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

List<GetPage<dynamic>> IDCollection = [
  GetPage(name: '/photoTab', page: () => PhotoTabPage(), binding: PhotoTabBinding()),
  GetPage(name: '/photoFirst', page: () => PhotoFirstPage(), binding: PhotoFirstBinding()),
  GetPage(name: '/photoSecond', page: () => PhotoSecondPage(), binding: PhotoSecondBinding()),
  GetPage(name: '/photoThird', page: () => PhotoThirdPage(), binding: PhotoThirdBinding()),
  GetPage(name: '/photoDetail', page: () => PhotoDetailsPage(), binding: PhotoDetailsBinding()),
  GetPage(name: '/allSizeSelect', page: () => AllSizeSelectPage(), binding: AllSizeSelectBinding()),
];
