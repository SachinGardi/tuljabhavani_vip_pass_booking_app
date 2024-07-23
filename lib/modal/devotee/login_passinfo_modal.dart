// To parse this JSON data, do
//
//     final devoteeEPassModal = devoteeEPassModalFromJson(jsonString);

import 'dart:convert';

EPassInformationModal devoteeEPassModalFromJson(String str) => EPassInformationModal.fromJson(json.decode(str));

String devoteeEPassModalToJson(EPassInformationModal data) => json.encode(data.toJson());

class EPassInformationModal {
  int? id;
  String? leftImagePath;
  String? rightImagePath;
  String? centreImagePath;
  String? headerName;
  String? ePassTitle;
  String? information;
  String? information_M;
  int? createdBy;
  dynamic modifiedBy;
  DateTime? createdDate;
  dynamic modifiedDate;
  dynamic isDeleted;

  EPassInformationModal({
    this.id,
    this.leftImagePath,
    this.rightImagePath,
    this.centreImagePath,
    this.headerName,
    this.ePassTitle,
    this.information,
    this.information_M,
    this.createdBy,
    this.modifiedBy,
    this.createdDate,
    this.modifiedDate,
    this.isDeleted,
  });

  factory EPassInformationModal.fromJson(Map<String, dynamic> json) => EPassInformationModal(
    id: json["id"],
    leftImagePath: json["leftImagePath"],
    rightImagePath: json["rightImagePath"],
    centreImagePath: json["centreImagePath"],
    headerName: json["headerName"],
    ePassTitle: json["ePassTitle"],
    information: json["information"],
    information_M: json["information_M"],
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    modifiedDate: json["modifiedDate"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "leftImagePath": leftImagePath,
    "rightImagePath": rightImagePath,
    "centreImagePath": centreImagePath,
    "headerName": headerName,
    "ePassTitle": ePassTitle,
    "information": information,
    "information_M": information_M,
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "createdDate": createdDate?.toIso8601String(),
    "modifiedDate": modifiedDate,
    "isDeleted": isDeleted,
  };
}
