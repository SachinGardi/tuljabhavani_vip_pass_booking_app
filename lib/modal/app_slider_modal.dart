import 'dart:convert';

AppSliderModal appSlideModalFromJson(String str) => AppSliderModal.fromJson(json.decode(str));

String appSlideModalToJson(AppSliderModal data) => json.encode(data.toJson());

class AppSliderModal {
  int? id;
  String? imageName;
  String? imagePath;
  String? status;
  int? statusId;
  int? createdBy;
  DateTime? createdDate;

  AppSliderModal({
    this.id,
    this.imageName,
    this.imagePath,
    this.status,
    this.statusId,
    this.createdBy,
    this.createdDate,
  });

  factory AppSliderModal.fromJson(Map<String, dynamic> json) => AppSliderModal(
    id: json["id"],
    imageName: json["imageName"],
    imagePath: json["imagePath"],
    status: json["status"],
    statusId: json["statusId"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imageName": imageName,
    "imagePath": imagePath,
    "status": status,
    "statusId": statusId,
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
  };
}
