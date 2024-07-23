// To parse this JSON data, do
//
//     final visitDateAndTimeDetailsModal = visitDateAndTimeDetailsModalFromJson(jsonString);

import 'dart:convert';

VisitDateAndTimeDetailsModal visitDateAndTimeDetailsModalFromJson(String str) => VisitDateAndTimeDetailsModal.fromJson(json.decode(str));

String visitDateAndTimeDetailsModalToJson(VisitDateAndTimeDetailsModal data) => json.encode(data.toJson());

class VisitDateAndTimeDetailsModal {
  int? id;
  dynamic devoteeName;
  dynamic emailId;
  String? mobileNo;
  int? totalAmount;
  dynamic transactionId;
  int? referById;
  dynamic referBy;
  int? noOfTotalDevotee;
  int? isExpired;
  int? statusId;
  String? status;
  DateTime? visitDate;
  String? visitTime;
  int? rejecteId;
  dynamic rejectedRemark;
  int? userTypeId;
  int? isQuotaavailable;

  VisitDateAndTimeDetailsModal({
    this.id,
    this.devoteeName,
    this.emailId,
    this.mobileNo,
    this.totalAmount,
    this.transactionId,
    this.referById,
    this.referBy,
    this.noOfTotalDevotee,
    this.isExpired,
    this.statusId,
    this.status,
    this.visitDate,
    this.visitTime,
    this.rejecteId,
    this.rejectedRemark,
    this.userTypeId,
    this.isQuotaavailable,
  });

  factory VisitDateAndTimeDetailsModal.fromJson(Map<String, dynamic> json) => VisitDateAndTimeDetailsModal(
    id: json["id"],
    devoteeName: json["devoteeName"],
    emailId: json["emailId"],
    mobileNo: json["mobileNo"],
    totalAmount: json["totalAmount"],
    transactionId: json["transactionId"],
    referById: json["referById"],
    referBy: json["referBy"],
    noOfTotalDevotee: json["noOfTotalDevotee"],
    isExpired: json["isExpired"],
    statusId: json["statusId"],
    status: json["status"],
    visitDate: json["visitDate"] == null ? null : DateTime.parse(json["visitDate"]),
    visitTime: json["visitTime"],
    rejecteId: json["rejecteId"],
    rejectedRemark: json["rejectedRemark"],
    userTypeId: json["userTypeId"],
    isQuotaavailable: json["isQuotaavailable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "devoteeName": devoteeName,
    "emailId": emailId,
    "mobileNo": mobileNo,
    "totalAmount": totalAmount,
    "transactionId": transactionId,
    "referById": referById,
    "referBy": referBy,
    "noOfTotalDevotee": noOfTotalDevotee,
    "isExpired": isExpired,
    "statusId": statusId,
    "status": status,
    "visitDate": visitDate?.toIso8601String(),
    "visitTime": visitTime,
    "rejecteId": rejecteId,
    "rejectedRemark": rejectedRemark,
    "userTypeId": userTypeId,
    "isQuotaavailable": isQuotaavailable,
  };
}
