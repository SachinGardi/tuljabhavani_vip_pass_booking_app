import 'dart:convert';
AboutTempleModal aboutTempleModalFromJson(String str) => AboutTempleModal.fromJson(json.decode(str));
String aboutTempleModalToJson(AboutTempleModal data) => json.encode(data.toJson());
class AboutTempleModal {
  int? id;
  String? imagePath;
  String? heading;
  String? description;
  int? status;
  int? createdBy;
  DateTime? createdDate;
  int? modifiedBy;
  DateTime? modifiedDate;
  bool? isDeleted;

  AboutTempleModal({
    this.id,
    this.imagePath,
    this.heading,
    this.description,
    this.status,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    this.isDeleted,
  });

  factory AboutTempleModal.fromJson(Map<String, dynamic> json) => AboutTempleModal(
    id: json["id"],
    imagePath: json["imagePath"],
    heading: json["heading"],
    description: json["description"],
    status: json["status"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    modifiedBy: json["modifiedBy"],
    modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imagePath": imagePath,
    "heading": heading,
    "description": description,
    "status": status,
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "modifiedBy": modifiedBy,
    "modifiedDate": modifiedDate?.toIso8601String(),
    "isDeleted": isDeleted,
  };
}
