class EventModel {
  int? id;
  String? tvBroadcastChanel;
  String? radioBroadcastChanel;
  String? location;
  String? startedAt;
  int? raceId;
  String? createdAt;
  String? updatedAt;

  EventModel({
    this.id,
    this.tvBroadcastChanel,
    this.radioBroadcastChanel,
    this.location,
    this.startedAt,
    this.raceId,
    this.createdAt,
    this.updatedAt,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tvBroadcastChanel = json['tv_broadcast_chanel'];
    radioBroadcastChanel = json['radio_broadcast_chanel'];
    location = json['location'];
    startedAt = json['started_at'];
    raceId = json['race_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tv_broadcast_chanel'] = tvBroadcastChanel;
    data['radio_broadcast_chanel'] = radioBroadcastChanel;
    data['location'] = location;
    data['started_at'] = startedAt;
    data['race_id'] = raceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
