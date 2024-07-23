// To parse this JSON data, do
//
//     final trusteeLinkModal = trusteeLinkModalFromJson(jsonString);

import 'dart:convert';

GenerateEPassLinkModal trusteeLinkModalFromJson(String str) => GenerateEPassLinkModal.fromJson(json.decode(str));

String trusteeLinkModalToJson(GenerateEPassLinkModal data) => json.encode(data.toJson());

class GenerateEPassLinkModal {
  int? createdBy;
  int? modifiedBy;
  DateTime? createdDate;
  DateTime? modifiedDate;
  bool? isDeleted;
  int? id;
  int? referrelId;
  String? mobileNo;
  int? noOfTotalDevotee;
  DateTime? visitDate;
  int? timeSlot;
  int? totalAmount;
  bool? isCall;
  int? ePassId;
  List<GenerateBookingDetail>? bookingDetails;

  GenerateEPassLinkModal({
    this.createdBy,
    this.modifiedBy,
    this.createdDate,
    this.modifiedDate,
    this.isDeleted,
    this.id,
    this.referrelId,
    this.mobileNo,
    this.noOfTotalDevotee,
    this.visitDate,
    this.timeSlot,
    this.totalAmount,
    this.isCall,
    this.ePassId,
    this.bookingDetails,
  });

  factory GenerateEPassLinkModal.fromJson(Map<String, dynamic> json) => GenerateEPassLinkModal(
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
    isDeleted: json["isDeleted"],
    id: json["id"],
    referrelId: json["referrelId"],
    mobileNo: json["mobileNo"],
    noOfTotalDevotee: json["noOfTotalDevotee"],
    visitDate: json["visitDate"] == null ? null : DateTime.parse(json["visitDate"]),
    timeSlot: json["timeSlot"],
    totalAmount: json["totalAmount"],
    isCall: json["isCall"],
    ePassId: json["ePassId"],
    bookingDetails: json["bookingDetails"] == null ? [] : List<GenerateBookingDetail>.from(json["bookingDetails"]!.map((x) => GenerateBookingDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "createdDate": createdDate?.toIso8601String(),
    "modifiedDate": modifiedDate?.toIso8601String(),
    "isDeleted": isDeleted,
    "id": id,
    "referrelId":referrelId,
    "mobileNo": mobileNo,
    "noOfTotalDevotee": noOfTotalDevotee,
    "visitDate": visitDate?.toIso8601String(),
    "timeSlot": timeSlot,
    "totalAmount":totalAmount,
    "isCall":isCall,
    "ePassId":ePassId,
    "bookingDetails": bookingDetails == null ? [] : List<dynamic>.from(bookingDetails!.map((x) => x.toJson())),
  };
}

class GenerateBookingDetail {
  int? id;
  int? bookingId;
  double? amount;
  int? noOfdevotee;
  int? createdBy;
  String? ePassName;

  GenerateBookingDetail({
    this.id,
    this.bookingId,
    this.amount,
    this.noOfdevotee,
    this.createdBy,
    this.ePassName,
  });

  factory GenerateBookingDetail.fromJson(Map<String, dynamic> json) => GenerateBookingDetail(
      id: json["id"],
      bookingId: json["bookingId"],
      amount: json["amount"],
      noOfdevotee: json["noOfdevotee"],
      createdBy: json["createdBy"],
      ePassName: json["ePassName"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookingId": bookingId,
    "amount": amount,
    "noOfdevotee": noOfdevotee,
    "createdBy": createdBy,
    "ePassName":ePassName
  };
}
