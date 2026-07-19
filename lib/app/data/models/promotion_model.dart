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

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      subtitle: (json['description'] as String?) ?? (json['subtitle'] as String?),
      url: json['url'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': '',
      'description': subtitle,
      'url': url,
      'image_url': imageUrl,
    };
  }
}
