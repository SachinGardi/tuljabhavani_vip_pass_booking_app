// To parse this JSON data, do
//
//     final notificationModal = notificationModalFromJson(jsonString);

import 'dart:convert';

NotificationModal notificationModalFromJson(String str) => NotificationModal.fromJson(json.decode(str));

String notificationModalToJson(NotificationModal data) => json.encode(data.toJson());

class NotificationModal {
  int? id;
  int? userId;
  int? srNo;
  String? title;
  String? ePass;
  String? reason;
  DateTime? addedDate;
  DateTime? fromDate;
  DateTime? toDate;
  int? statusId;
  String? status;
  int? createdBy;
  DateTime? createdDate;
  int? msgId;
  List<PageDetailsModal>? pageDetailsList;

  NotificationModal({
    this.id,
    this.userId,
    this.srNo,
    this.title,
    this.ePass,
    this.reason,
    this.addedDate,
    this.fromDate,
    this.toDate,
    this.statusId,
    this.status,
    this.createdBy,
    this.createdDate,
    this.msgId,
    this.pageDetailsList
  });

  factory NotificationModal.fromJson(Map<String, dynamic> json) => NotificationModal(
    id: json["id"],
    userId: json["userId"],
    srNo: json["srNo"],
    title: json["title"],
    ePass: json["ePass"],
    reason: json["reason"],
    addedDate: json["addedDate"] == null ? null : DateTime.parse(json["addedDate"]),
    fromDate: json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
    toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
    statusId: json["statusId"],
    status: json["status"],
    createdBy: json["createdBy"],
    msgId: json["msgId"],
    pageDetailsList:  json["pageDetailsList"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "srNo": srNo,
    "title": title,
    "ePass": ePass,
    "reason": reason,
    "addedDate": addedDate?.toIso8601String(),
    "fromDate": fromDate?.toIso8601String(),
    "toDate": toDate?.toIso8601String(),
    "statusId": statusId,
    "status": status,
    "createdBy": createdBy,
    "msgId": msgId,
    "pageDetailsList":pageDetailsList,
    "createdDate": createdDate?.toIso8601String(),
  };
}



class PageDetailsModal {
  PageDetailsModal({
  this.pageNo,
   this.totalPages,
    this.pageCount,
  });

  int? pageNo;
  int? totalPages;
  int? pageCount;

  factory PageDetailsModal.fromJson(Map<String, dynamic> json) => PageDetailsModal(
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
