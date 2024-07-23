// To parse this JSON data, do
//
//     final validatorScannarModal = validatorScannarModalFromJson(jsonString);

import 'dart:convert';

ValidatorScannarModal validatorScannarModalFromJson(String str) => ValidatorScannarModal.fromJson(json.decode(str));

String validatorScannarModalToJson(ValidatorScannarModal data) => json.encode(data.toJson());

class ValidatorScannarModal {
  int? id;
  int? devoteeId;
  String? devoteeName;
  String? mobileNo;
  String? gender;
  DateTime? dateOfBirth;
  int? age;
  String? address;
  String? aadharNo;
  int? referById;
  String? referBy;
  DateTime? visitDate;
  String? visitTime;
  double? donation;
  String? imagePath;
  String? barcodeText;
  String? ePassName;
  int?  statusId;
  String?  transactionId;
  DateTime? transactionDate;
  DateTime? scanDate;
  String? validatorName;
   String? bookingId;
  DateTime? bookingDate;

  ValidatorScannarModal({
    this.id,
    this.devoteeId,
    this.devoteeName,
    this.mobileNo,
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
    this.imagePath,
    this.barcodeText,
    this.ePassName,
    this.statusId,
    this.transactionId,
    this.transactionDate,
    this.scanDate,
    this.validatorName,
    this.bookingId,
    this.bookingDate,
  });

  factory ValidatorScannarModal.fromJson(Map<String, dynamic> json) => ValidatorScannarModal(
    id: json["id"],
    devoteeId: json["devoteeId"],
    devoteeName: json["devoteeName"],
    mobileNo: json["mobileNo"],
    gender: json["gender"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    age: json["age"],
    address: json["address"],
    aadharNo: json["aadharNo"],
    referById: json["referById"],
    referBy: json["referBy"],
    visitDate: json["visitDate"] == null ? null : DateTime.parse(json["visitDate"]),
    visitTime: json["visitTime"],
    donation: json["donation"],
      imagePath: json["imagePath"],
    barcodeText: json["barcodeText"],
    ePassName: json["ePassName"],
    statusId: json["statusId"],
    transactionId: json["transactionId"],
    transactionDate: json["transactionDate"],
    scanDate: json["scanDate"],
    validatorName: json["validatorName"],
    bookingId: json["bookingId"],
    bookingDate: json["bookingDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "devoteeId": devoteeId,
    "devoteeName": devoteeName,
    "mobileNo": mobileNo,
    "gender": gender,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "age": age,
    "address": address,
    "aadharNo": aadharNo,
    "referById": referById,
    "referBy": referBy,
    "visitDate": visitDate?.toIso8601String(),
    "visitTime": visitTime,
    "donation": donation,
    "imagePath": imagePath,
    "barcodeText": barcodeText,
    "ePassName": ePassName,
    "statusId": statusId,
    "transactionId": transactionId,
    "transactionDate": transactionDate,
    "scanDate": scanDate,
    "validatorName": validatorName,
    "bookingId": bookingId,
    "bookingDate": bookingDate,
  };
}
