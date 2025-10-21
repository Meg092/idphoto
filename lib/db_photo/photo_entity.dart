import 'dart:typed_data';

class PhotoEntity{
  int id;
  DateTime createdTime;
  Uint8List image;

  PhotoEntity({required this.id, required this.createdTime, required this.image});

  factory PhotoEntity.fromJson(Map<String, dynamic> json) {
    return PhotoEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'image': image,
    };
  }

}

class IDPhotoSize {
  final String name;
  final double widthMm;
  final double heightMm;
  final double dpi;

  IDPhotoSize({
    required this.name,
    required this.widthMm,
    required this.heightMm,
    this.dpi = 300.0,
  });

  int get widthPx => (widthMm * dpi / 25.4).round();
  int get heightPx => (heightMm * dpi / 25.4).round();

  // 获取显示信息
  String get sizeInfo => '${widthPx}×${heightPx}px';
  String get mmInfo => '${widthMm}×${heightMm}mm';
}