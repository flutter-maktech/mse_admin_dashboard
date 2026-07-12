class RaceReportModel {
  String? userEmail;
  String? reportDetails;
  String? userName;
  String? createdAt;
  String? updatedAt;

  RaceReportModel({
    this.userEmail,
    this.reportDetails,
    this.userName,
    this.createdAt,
    this.updatedAt,
  });

  RaceReportModel.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'];
    reportDetails = json['report_details'];
    userName = json['user_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_email'] = userEmail;
    data['report_details'] = reportDetails;
    data['user_name'] = userName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
