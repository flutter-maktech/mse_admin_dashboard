import 'event_model.dart';

class RaceModel {
  int? id;
  String? name;
  String? imageLogo;
  int? serialNumber;
  String? createdAt;
  String? updatedAt;
  List<EventModel>? events;

  RaceModel({
    this.id,
    this.name,
    this.imageLogo,
    this.serialNumber,
    this.createdAt,
    this.updatedAt,
    this.events,
  });

  RaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageLogo = json['image_logo'];
    serialNumber = json['serial_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['events'] != null) {
      events = <EventModel>[];
      json['events'].forEach((v) {
        events!.add(EventModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_logo'] = imageLogo;
    data['serial_number'] = serialNumber;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
