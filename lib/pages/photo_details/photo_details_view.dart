import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:id_photo/db_photo/photo_entity.dart';
import 'package:id_photo/main.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:styled_widget/styled_widget.dart';

import 'photo_details_logic.dart';

class PhotoDetailsPage extends GetView<PhotoDetailsLogic> {
  GlobalKey _containerKey = GlobalKey();

  ui.Image? _originalImage;

  Widget _buildTopBottomAnnotation(String text) {
    return <Widget>[
      Expanded(
          child: Container(
        height: 1,
      ).decorated(color: Colors.grey)),
      Text(
        text,
        style: const TextStyle(color: Colors.grey),
      ).marginSymmetric(horizontal: 10),
      Expanded(
          child: Container(
        height: 1,
      ).decorated(color: Colors.grey)),
    ].toRow();
  }

  Widget _buildLeftRightAnnotation(String text) {
    return SizedBox(
      height: 375,
      child: <Widget>[
        Expanded(
            child: Container(
          width: 1,
        ).decorated(color: Colors.grey)),
        RotatedBox(
          quarterTurns: 1,
          child: Text(
            text,
            style: const TextStyle(color: Colors.grey),
          ),
        ).marginSymmetric(vertical: 10),
        Expanded(
            child: Container(
          width: 1,
        ).decorated(color: Colors.grey)),
      ].toColumn(),
    );
  }

  Future<bool> _requestPermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> _captureWidget() async {
    if (controller.isCreate) {
      return;
    }
    controller.isCreate = true;
    try {
      RenderRepaintBoundary boundary = _containerKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      _originalImage = image;
      final Uint8List? imageData = await _generateActualSizePhoto();
      if (imageData == null) {
        Fluttertoast.showToast(msg: 'Screenshot failed');
        return;
      }
      final permissionStatus = await _requestPermission();
      if (!permissionStatus) {
        Fluttertoast.showToast(msg: 'Please grant the permission for storage');
        return;
      }
      final result = await ImageGallerySaverPlus.saveImage(
        imageData,
        quality: 100,
        name:
            '${controller.currentSize.name}_${DateTime.now().millisecondsSinceEpoch}',
      );
      if (result['isSuccess'] == true) {
        await controller.dbPhoto.insertPhoto(
            PhotoEntity(id: 0, createdTime: DateTime.now(), image: imageData));
        Fluttertoast.showToast(msg: 'Save successful');
      } else {
        Fluttertoast.showToast(msg: 'Save failed');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Save failed');
    } finally {
      controller.isCreate = false;
    }
  }

  Future<Uint8List?> _generateActualSizePhoto() async {
    try {
      final int targetWidth = controller.currentSize.widthPx;
      final int targetHeight = controller.currentSize.heightPx;
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final paint = Paint();
      final double imageAspect = _originalImage!.width / _originalImage!.height;
      final double targetAspect = targetWidth / targetHeight;

      double srcLeft = 0;
      double srcTop = 0;
      double srcWidth = _originalImage!.width.toDouble();
      double srcHeight = _originalImage!.height.toDouble();

      if (imageAspect > targetAspect) {
        srcWidth = _originalImage!.height * targetAspect;
        srcLeft = (_originalImage!.width - srcWidth) / 2;
      } else {
        srcHeight = _originalImage!.width / targetAspect;
        srcTop = (_originalImage!.height - srcHeight) / 2;
      }

      final srcRect = Rect.fromLTWH(srcLeft, srcTop, srcWidth, srcHeight);
      final dstRect =
          Rect.fromLTWH(0, 0, targetWidth.toDouble(), targetHeight.toDouble());

      canvas.drawImageRect(_originalImage!, srcRect, dstRect, paint);
      final picture = recorder.endRecording();
      final ui.Image image = await picture.toImage(targetWidth, targetHeight);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      return byteData?.buffer.asUint8List();
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error occurred while generating the actual size image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.currentSize.name),
        actions: [
          Container(
            width: 100,
            height: 30,
            alignment: Alignment.center,
            child: const Text(
              'Export Save',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
              .decorated(
                  color: primaryColor, borderRadius: BorderRadius.circular(15))
              .marginOnly(right: 20)
              .gestures(onTap: () {
            if (controller.selectedImage == null) {
              Fluttertoast.showToast(msg: 'Please select an image');
              return;
            }
            _captureWidget();
          })
        ],
      ),
      body: GetBuilder<PhotoDetailsLogic>(builder: (_) {
        return SafeArea(
            bottom: false,
            child: <Widget>[
              Expanded(
                  child: SizedBox(
                width: double.infinity,
                child: Center(
                    child: <Widget>[
                  RepaintBoundary(
                    key: _containerKey,
                    child: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                                width: 289,
                                height: 375,
                                child: controller.selectedImage == null
                                    ? const Center(
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.grey,
                                          size: 50,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.memory(
                                          controller.selectedImage!,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                            .decorated(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Positioned(
                          bottom: 20,
                          child: Obx(() {
                            return Visibility(
                                visible: controller.currentClothes.value == 0
                                    ? false
                                    : true,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Obx(() {
                                    return Image.asset(
                                      'assets/${controller.style.value == 0 ? 'girl${controller.currentClothes.value}' : 'boy${controller.currentClothes.value}'}.png',
                                      width: 289,
                                      fit: BoxFit.cover,
                                    );
                                  }),
                                ));
                          })),
                    ].toStack(alignment: Alignment.center),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: _buildTopBottomAnnotation(
                              '${controller.currentSize.widthPx.toStringAsFixed(0)}px')
                          .marginSymmetric(horizontal: 40)),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _buildTopBottomAnnotation(
                              '${controller.currentSize.widthMm.toStringAsFixed(0)}mm')
                          .marginSymmetric(horizontal: 40)),
                  <Widget>[
                    _buildLeftRightAnnotation(
                        '${controller.currentSize.heightPx.toStringAsFixed(0)}px'),
                    const SizedBox(
                      width: 289,
                    ),
                    _buildLeftRightAnnotation(
                        '${controller.currentSize.heightMm.toStringAsFixed(0)}mm')
                  ]
                      .toRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min)
                      .marginSymmetric(horizontal: 30)
                ].toStack(alignment: Alignment.center).gestures(onTap: () {
                  controller.imageSelected();
                })),
              )),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: <Widget>[
                  <Widget>[
                    InkWell(
                      onTap: () {
                        controller.style.value = 0;
                      },
                      child: <Widget>[
                        Obx(() {
                          return Text(
                            '''Women's''',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    controller.style.value == 0 ? 20 : 16),
                          );
                        }),
                        const SizedBox(
                          height: 7,
                        ),
                        Obx(() {
                          return Visibility(
                              visible: controller.style.value == 0,
                              child: Container(
                                width: 34,
                                height: 4,
                              ).decorated(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(2)));
                        })
                      ].toColumn(),
                    ),
                    InkWell(
                      onTap: () {
                        controller.style.value = 1;
                      },
                      child: <Widget>[
                        Obx(() {
                          return Text(
                            '''Men's''',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    controller.style.value == 1 ? 20 : 16),
                          );
                        }),
                        const SizedBox(
                          height: 7,
                        ),
                        Obx(() {
                          return Visibility(
                              visible: controller.style.value == 1,
                              child: Container(
                                width: 34,
                                height: 4,
                              ).decorated(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(2)));
                        })
                      ].toColumn(),
                    )
                  ]
                      .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                      .marginSymmetric(horizontal: 15),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 73,
                    child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 57 / 73),
                        itemCount: 5,
                        itemBuilder: (_, index) {
                          return Obx(() {
                            return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        controller.currentClothes.value == index
                                            ? Border.all(
                                                color: const Color(0xffdbdbdb))
                                            : null),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/${index == 0 ? 'none' : controller.style.value == 0 ? 'girl$index' : 'boy$index'}.png',
                                  fit: BoxFit.cover,
                                )).gestures(onTap: () {
                              controller.currentClothes.value = index;
                            });
                          });
                        }),
                  )
                ].toColumn(),
              ).decorated(color: Colors.white)
            ].toColumn());
      }),
    );
  }
}
