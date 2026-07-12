class RaceRequestModel {
  String? userEmail;
  String? requestDetails;
  String? userName;
  String? createdAt;
  String? updatedAt;

  RaceRequestModel({
    this.userEmail,
    this.requestDetails,
    this.userName,
    this.createdAt,
    this.updatedAt,
  });

  RaceRequestModel.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'];
    requestDetails = json['request_details'];
    userName = json['user_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_email'] = userEmail;
    data['request_details'] = requestDetails;
    data['user_name'] = userName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
