import 'dart:typed_data';

class PromotionModel {
  int? id;
  String? title;
  String? subtitle;
  String? url;
  String? imageUrl;
  Uint8List? imageBytes;

  PromotionModel({
    this.id,
    this.title,
    this.subtitle,
    this.url,
    this.imageUrl,
    this.imageBytes,
  });
}
