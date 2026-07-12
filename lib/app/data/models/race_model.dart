class RaceModel {
  int? id;
  String? name;
  String? imageLogo;
  int? serialNumber;
  String? createdAt;
  String? updatedAt;

  RaceModel({
    this.id,
    this.name,
    this.imageLogo,
    this.serialNumber,
    this.createdAt,
    this.updatedAt,
  });

  RaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageLogo = json['image_logo'];
    serialNumber = json['serial_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_logo'] = imageLogo;
    data['serial_number'] = serialNumber;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
