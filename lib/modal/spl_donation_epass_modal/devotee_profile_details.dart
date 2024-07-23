import 'dart:convert';
DevoteeProfileModal devoteeProfileModalFromJson(String str) => DevoteeProfileModal.fromJson(json.decode(str));
String devoteeProfileModalToJson(DevoteeProfileModal data) => json.encode(data.toJson());
class DevoteeProfileModal{
  int? id;
  String? devoteeName;
  String? mobileNo;
  DateTime? dateOfBirth;
  String? gender;
  String? aadharNo;
  int? createdBy;
  dynamic modifiedBy;
  DateTime? createdDate;
  dynamic modifiedDate;
  bool? isDeleted;
  String? imagePath;

  DevoteeProfileModal({
    this.id,
    this.devoteeName,
    this.mobileNo,
    this.dateOfBirth,
    this.gender,
    this.aadharNo,
    this.createdBy,
    this.modifiedBy,
    this.createdDate,
    this.modifiedDate,
    this.isDeleted,
    this.imagePath
  });

  factory DevoteeProfileModal.fromJson(Map<String, dynamic> json) => DevoteeProfileModal(
    id: json["id"],
    devoteeName: json["devoteeName"],
    mobileNo: json["mobileNo"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    gender: json["gender"],
    aadharNo: json["aadharNo"],
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    modifiedDate: json["modifiedDate"],
    isDeleted: json["isDeleted"],
    imagePath: json["imagePath"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "devoteeName": devoteeName,
    "mobileNo": mobileNo,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "gender": gender,
    "aadharNo": aadharNo,
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "createdDate": createdDate?.toIso8601String(),
    "modifiedDate": modifiedDate,
    "isDeleted": isDeleted,
    "imagePath": imagePath,
  };
}
