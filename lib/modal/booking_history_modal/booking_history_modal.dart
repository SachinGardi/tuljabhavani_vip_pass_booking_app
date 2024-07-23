import 'dart:convert';

BookingHistoryModal bookingHistoryModalFromJson(String str) => BookingHistoryModal.fromJson(json.decode(str));

String bookingHistoryModalToJson(BookingHistoryModal data) => json.encode(data.toJson());

class BookingHistoryModal {
  int? srNo;
  int? ePassId;
  int? userTypeId;
  String? devoteeName;
  String? mobileNo;
  String? emailId;
  int? noOfVisitors;
  int? referById;
  String? referredBy;
  num? totalAmount;
  DateTime? visitDate;
  DateTime? transactionDate;
  String? timeSlot;
  int? statusId;
  String? status;
  bool? protocol;
  String? acceptRemark;
  String? rejectedRemark;
  String? referanceName;
  String? ePassName;
  String? transactionId;
  String? bookingId;
  List<BookingPassDetail>? bookingPassDetails;
  List<TrusteeBookingPageModal>? bookingPageDetails;

  BookingHistoryModal({
    this.srNo,
    this.ePassId,
    this.userTypeId,
    this.devoteeName,
    this.mobileNo,
    this.emailId,
    this.noOfVisitors,
    this.referById,
    this.referredBy,
    this.totalAmount,
    this.visitDate,
    this.transactionDate,
    this.timeSlot,
    this.statusId,
    this.status,
    this.protocol,
    this.acceptRemark,
    this.rejectedRemark,
    this.referanceName,
    this.ePassName,
    this.transactionId,
    this.bookingId,
    this.bookingPassDetails,
    this.bookingPageDetails,
  });

  factory BookingHistoryModal.fromJson(Map<String, dynamic> json) => BookingHistoryModal(
    srNo: json["srNo"],
    ePassId: json["ePassId"],
    userTypeId: json["userTypeId"],
    devoteeName: json["devoteeName"],
    mobileNo: json["mobileNo"],
    emailId: json["emailId"],
    noOfVisitors: json["noOfVisitors"],
    referById: json["referById"],
    referredBy: json["referredBy"],
    totalAmount: json["totalAmount"],
    visitDate: json["visitDate"] == null ? null : DateTime.parse(json["visitDate"]),
    transactionDate: json["transactionDate"] == null ? null : DateTime.parse(json["transactionDate"]),
    timeSlot: json["timeSlot"],
    statusId: json["statusId"],
    status: json["status"],
    protocol: json["protocol"],
    acceptRemark: json["acceptRemark"],
    rejectedRemark: json["rejectedRemark"],
    referanceName: json["referanceName"],
    ePassName: json["ePassName"],
    transactionId: json["transactionId"],
    bookingId: json["bookingId"],
    bookingPassDetails: json["bookingPassDetails"] == null ? [] : List<BookingPassDetail>.from(json["bookingPassDetails"]!.map((x) => BookingPassDetail.fromJson(x))),
    bookingPageDetails: json["bookingPageDetails"],
  );

  Map<String, dynamic> toJson() => {
    "srNo": srNo,
    "ePassId": ePassId,
    "userTypeId": userTypeId,
    "devoteeName": devoteeName,
    "mobileNo": mobileNo,
    "emailId": emailId,
    "noOfVisitors": noOfVisitors,
    "referById": referById,
    "referredBy": referredBy,
    "totalAmount": totalAmount,
    "visitDate": visitDate?.toIso8601String(),
    "transactionDate": transactionDate?.toIso8601String(),
    "timeSlot": timeSlot,
    "statusId": statusId,
    "status": status,
    "protocol": protocol,
    "acceptRemark": acceptRemark,
    "rejectedRemark": rejectedRemark,
    "referanceName": referanceName,
    "ePassName": ePassName,
    "transactionId": transactionId,
    "bookingId": bookingId,
    "bookingPassDetails": bookingPassDetails == null ? [] : List<dynamic>.from(bookingPassDetails!.map((x) => x.toJson())),
    "bookingPageDetails":bookingPageDetails,
  };
}

class BookingPassDetail {
  int? id;
  double? amount;
  int? noOfdevotee;

  BookingPassDetail({
    this.id,
    this.amount,
    this.noOfdevotee,
  });

  factory BookingPassDetail.fromJson(Map<String, dynamic> json) => BookingPassDetail(
    id: json["id"],
    amount: json["amount"],
    noOfdevotee: json["noOfdevotee"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "noOfdevotee": noOfdevotee,
  };
}


TrusteeBookingPageModal trusteeBookingPageModalFromJson(String str) => TrusteeBookingPageModal.fromJson(json.decode(str));

String trusteeBookingPageModalToJson(TrusteeBookingPageModal data) => json.encode(data.toJson());

class TrusteeBookingPageModal {
  int? pageNo;
  int? totalPages;
  int? pageCount;

  TrusteeBookingPageModal({
    this.pageNo,
    this.totalPages,
    this.pageCount,
  });

  factory TrusteeBookingPageModal.fromJson(Map<String, dynamic> json) => TrusteeBookingPageModal(
    pageNo: json["pageNo"],
    totalPages: json["totalPages"],
    pageCount: json["pageCount"],
  );

  Map<String, dynamic> toJson() => {
    "pageNo": pageNo,
    "totalPages": totalPages,
    "pageCount": pageCount,
  };
}



