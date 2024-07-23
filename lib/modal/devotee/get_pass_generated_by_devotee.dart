// To parse this JSON data, do
//
//     final getPassGeneratedByDevoteeModal = getPassGeneratedByDevoteeModalFromJson(jsonString);

import 'dart:convert';

GetPassGeneratedByDevoteeModal getPassGeneratedByDevoteeModalFromJson(String str) => GetPassGeneratedByDevoteeModal.fromJson(json.decode(str));

String getPassGeneratedByDevoteeModalToJson(GetPassGeneratedByDevoteeModal data) => json.encode(data.toJson());

class GetPassGeneratedByDevoteeModal {
  int? id;
  int? devoteeId;
  String? devoteeName;
  String? mobileNo;
  String? emailId;
  String? gender;
  dynamic dateOfBirth;
  int? age;
  String? address;
  String? aadharNo;
  int? referById;
  String? referBy;
  dynamic visitDate;
  String? visitTime;
  double? donation;
  String? barcodeText;
  int? statusId;
  dynamic status;
  String? imagePath;
  int? createdBy;
  dynamic createdDate;
  String? ePassName;
  dynamic scanDate;
  dynamic validatorName;
  dynamic rejectedRemark;
  String? documentPath;
  String? referanceName;

  GetPassGeneratedByDevoteeModal({
     this.id,
     this.devoteeId,
     this.devoteeName,
     this.mobileNo,
     this.emailId,
     this.gender,
     this.dateOfBirth,
     this.age,
     this.address,
     this.aadharNo,
     this.referById,
     this.referBy,
     this.visitDate,
     this.visitTime,
     this.donation,
     this.barcodeText,
     this.statusId,
     this.status,
     this.imagePath,
     this.createdBy,
     this.createdDate,
     this.ePassName,
     this.scanDate,
     this.validatorName,
     this.rejectedRemark,
     this.documentPath,
     this.referanceName,
  });

  factory GetPassGeneratedByDevoteeModal.fromJson(Map<String, dynamic> json) => GetPassGeneratedByDevoteeModal(
    id: json["id"],
    devoteeId: json["devoteeId"],
    devoteeName: json["devoteeName"],
    mobileNo: json["mobileNo"],
    emailId: json["emailId"],
    gender: json["gender"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    age: json["age"],
    address: json["address"],
    aadharNo: json["aadharNo"],
    referById: json["referById"],
    referBy: json["referBy"],
    visitDate: DateTime.parse(json["visitDate"]),
    visitTime: json["visitTime"],
    donation: json["donation"],
    barcodeText: json["barcodeText"],
    statusId: json["statusId"],
    status: json["status"],
    imagePath: json["imagePath"],
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    ePassName: json["ePassName"],
    scanDate: DateTime.parse(json["scanDate"]),
    validatorName: json["validatorName"],
    rejectedRemark: json["rejectedRemark"],
    documentPath: json["documentPath"],
    referanceName: json["referanceName"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "devoteeId": devoteeId,
    "devoteeName": devoteeName,
    "mobileNo": mobileNo,
    "emailId":emailId,
    "gender": gender,
    "dateOfBirth": dateOfBirth!.toIso8601String(),
    "age": age,
    "address": address,
    "aadharNo": aadharNo,
    "referById": referById,
    "referBy": referBy,
    "visitDate": visitDate!.toIso8601String(),
    "visitTime": visitTime,
    "donation": donation,
    "barcodeText": barcodeText,
    "statusId": statusId,
    "status": status,
    "imagePath": imagePath,
    "createdBy": createdBy,
    "createdDate": createdDate!.toIso8601String(),
    "ePassName": ePassName,
    "scanDate": scanDate!.toIso8601String(),
    "validatorName": validatorName,
    "rejectedRemark": rejectedRemark,
    "documentPath":documentPath,
    "referanceName":referanceName
  };
}
