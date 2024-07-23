// To parse this JSON data, do
//
//     final postDevoteeInfoModal = postDevoteeInfoModalFromJson(jsonString);

import 'dart:convert';

PostDevoteeInfoModal postDevoteeInfoModalFromJson(String str) => PostDevoteeInfoModal.fromJson(json.decode(str));

String postDevoteeInfoModalToJson(PostDevoteeInfoModal data) => json.encode(data.toJson());

class PostDevoteeInfoModal {
  int? id;
  int? devoteeId;
  int? referById;
  String? devoteeName;
  String? mobileNo;
  String? emailId;
  int? amount;
  String? gender;
  DateTime? dateOfBirth;
  String? aadharNo;
  String? address;
  String? imagePath;
  int? createdBy;
  DateTime? createdDate;
  bool? isPaymentdone;
  String? transactionId;
  String? documentPath;
  String? referanceName;

  PostDevoteeInfoModal({
     this.id,
     this.devoteeId,
     this.referById,
     this.devoteeName,
     this.mobileNo,
     this.emailId,
     this.amount,
     this.gender,
     this.dateOfBirth,
     this.aadharNo,
     this.address,
     this.imagePath,
     this.createdBy,
     this.createdDate,
     this.isPaymentdone,
     this.transactionId,
     this.documentPath,
     this.referanceName
  });

  factory PostDevoteeInfoModal.fromJson(Map<String, dynamic> json) => PostDevoteeInfoModal(
    id: json["id"],
    devoteeId: json["devoteeId"],
    referById: json["referById"],
    devoteeName: json["devoteeName"],
    mobileNo: json["mobileNo"],
    emailId: json["emailId"],
    amount: json["amount"],
    gender: json["gender"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    aadharNo: json["aadharNo"],
    address: json["address"],
    imagePath: json["imagePath"],
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    isPaymentdone: json["isPaymentdone"],
    transactionId: json["transactionId"],
    documentPath: json["document"],
    referanceName: json["referanceName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "devoteeId": devoteeId,
    "referById": referById,
    "devoteeName": devoteeName,
    "mobileNo": mobileNo,
    "emailId":emailId,
    "amount": amount,
    "gender": gender,
    "dateOfBirth": dateOfBirth!.toIso8601String(),
    "aadharNo": aadharNo,
    "address": address,
    "imagePath": imagePath,
    "createdBy": createdBy,
    "createdDate": createdDate!.toIso8601String(),
    "isPaymentdone": isPaymentdone,
    "transactionId": transactionId,
    "documentPath":documentPath,
    "referanceName":referanceName,
  };
}
