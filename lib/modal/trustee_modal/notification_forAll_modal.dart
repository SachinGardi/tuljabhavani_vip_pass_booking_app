// To parse this JSON data, do
//
//     final notificationForAllModal = notificationForAllModalFromJson(jsonString);

import 'dart:convert';

NotificationForAllModal notificationForAllModalFromJson(String str) => NotificationForAllModal.fromJson(json.decode(str));

String notificationForAllModalToJson(NotificationForAllModal data) => json.encode(data.toJson());

class NotificationForAllModal {
  int? id;
  int? srNo;
  String? title;
  String? description;
  DateTime? addedDate;
  int? createdBy;
  List<NotificationForAllPageModal>? pageList;

  NotificationForAllModal({
    this.id,
    this.srNo,
    this.title,
    this.description,
    this.addedDate,
    this.createdBy,
    this.pageList
  });

  factory NotificationForAllModal.fromJson(Map<String, dynamic> json) => NotificationForAllModal(
    id: json["id"],
    srNo: json["srNo"],
    title: json["title"],
    description: json["description"],
    addedDate: json["addedDate"] == null ? null : DateTime.parse(json["addedDate"]),
    createdBy: json["createdBy"],
    pageList: json["pageList"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "srNo": srNo,
    "title": title,
    "description": description,
    "addedDate": addedDate?.toIso8601String(),
    "pageList": pageList,
  };
}



NotificationForAllPageModal notificationForAllPageModalFromJson(String str) => NotificationForAllPageModal.fromJson(json.decode(str));

String notificationForAllPageModalToJson(NotificationForAllPageModal data) => json.encode(data.toJson());

class NotificationForAllPageModal {
  int? pageNo;
  int? totalPages;
  int? pageCount;

  NotificationForAllPageModal({
    this.pageNo,
    this.totalPages,
    this.pageCount,
  });

  factory NotificationForAllPageModal.fromJson(Map<String, dynamic> json) => NotificationForAllPageModal(
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

