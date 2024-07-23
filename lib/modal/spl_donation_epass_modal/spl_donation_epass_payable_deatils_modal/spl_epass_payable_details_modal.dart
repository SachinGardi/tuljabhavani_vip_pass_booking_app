import 'dart:convert';

SplePassPayableDetailsModal splePassPayableDetailsModalFromJson(String str) => SplePassPayableDetailsModal.fromJson(json.decode(str));

String splePassPayableDetailsModalToJson(SplePassPayableDetailsModal data) => json.encode(data.toJson());

class SplePassPayableDetailsModal {
  int? id;
  String? devoteeName;
  String? mobileNo;
  int? noOfDevotees;
  DateTime? visitDate;
  String? visitTime;
  double? total;
  int? referById;
  dynamic referBy;
  List<TotalPayMentDetail>? totalPayMentDetails;

  SplePassPayableDetailsModal({
    this.id,
    this.devoteeName,
    this.mobileNo,
    this.noOfDevotees,
    this.visitDate,
    this.visitTime,
    this.total,
    this.referById,
    this.referBy,
    this.totalPayMentDetails,
  });

  factory SplePassPayableDetailsModal.fromJson(Map<String, dynamic> json) => SplePassPayableDetailsModal(
    id: json["id"],
    devoteeName: json["devoteeName"],
    mobileNo: json["mobileNo"],
    noOfDevotees: json["noOfDevotees"],
    visitDate: json["visitDate"] == null ? null : DateTime.parse(json["visitDate"]),
    visitTime: json["visitTime"],
    total: json["total"],
    referById: json["referById"],
    referBy: json["referBy"],
    totalPayMentDetails: json["totalPayMentDetails"] == null ? [] : List<TotalPayMentDetail>.from(json["totalPayMentDetails"]!.map((x) => TotalPayMentDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "devoteeName": devoteeName,
    "mobileNo": mobileNo,
    "noOfDevotees": noOfDevotees,
    "visitDate": visitDate?.toIso8601String(),
    "visitTime": visitTime,
    "total": total,
    "referById": referById,
    "referBy": referBy,
    "totalPayMentDetails": totalPayMentDetails == null ? [] : List<dynamic>.from(totalPayMentDetails!.map((x) => x.toJson())),
  };
}

class TotalPayMentDetail {
  int? srNo;
  int? devoteeId;
  String? ePassName;
  double? amount;
  int? totalPass;
  double? totalAmount;

  TotalPayMentDetail({
    this.srNo,
    this.devoteeId,
    this.ePassName,
    this.amount,
    this.totalPass,
    this.totalAmount,
  });

  factory TotalPayMentDetail.fromJson(Map<String, dynamic> json) => TotalPayMentDetail(
    srNo: json["srNo"],
    devoteeId: json["devoteeId"],
    ePassName: json["ePassName"],
    amount: json["amount"],
    totalPass: json["totalPass"],
    totalAmount: json["totalAmount"],
  );

  Map<String, dynamic> toJson() => {
    "srNo": srNo,
    "devoteeId": devoteeId,
    "ePassName": ePassName,
    "amount": amount,
    "totalPass": totalPass,
    "totalAmount": totalAmount,
  };
}
