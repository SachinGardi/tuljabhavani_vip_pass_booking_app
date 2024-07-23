
class PaymentResponseModal {
  int? id;
  int? devoteeId;
  String? devoteeName;
  DateTime? visitDate;
  String? timeSlot;
  String? merchantOrderNumber;
  String? atrn;
  String? transactionStatus;
  double? amount;
  int? noOfDevotee;
  String? mobileNo;
  int? statusId;
  String? status;
  String? transactionDate;
  String? transactionId;

  PaymentResponseModal({
    this.id,
    this.devoteeId,
    this.devoteeName,
    this.visitDate,
    this.timeSlot,
    this.merchantOrderNumber,
    this.atrn,
    this.transactionStatus,
    this.amount,
    this.noOfDevotee,
    this.mobileNo,
    this.statusId,
    this.status,
    this.transactionDate,
    this.transactionId,
  });

  factory PaymentResponseModal.fromJson(Map<String, dynamic> json) => PaymentResponseModal(
    id: json["id"],
    devoteeId: json["devoteeId"],
    devoteeName: json["devoteeName"],
    visitDate: json["visitDate"] == null ? null : DateTime.parse(json["visitDate"]),
    timeSlot: json["timeSlot"],
    merchantOrderNumber: json["merchantOrderNumber"],
    atrn: json["atrn"],
    transactionStatus: json["transactionStatus"],
    amount: json["amount"],
    noOfDevotee: json["noOfDevotee"],
    mobileNo: json["mobileNo"],
    statusId: json["statusId"],
    status: json["status"],
    transactionDate: json["transactionDate"],
    transactionId: json["transactionId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "devoteeId": devoteeId,
    "devoteeName": devoteeName,
    "visitDate": visitDate?.toIso8601String(),
    "timeSlot": timeSlot,
    "merchantOrderNumber": merchantOrderNumber,
    "atrn": atrn,
    "transactionStatus": transactionStatus,
    "amount": amount,
    "noOfDevotee": noOfDevotee,
    "mobileNo": mobileNo,
    "statusId": statusId,
    "status": status,
    "transactionDate": transactionDate,
    "transactionId": transactionId,
  };
}
