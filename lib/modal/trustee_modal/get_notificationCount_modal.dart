// To parse this JSON data, do
//
//     final getNotificationCountModal = getNotificationCountModalFromJson(jsonString);

import 'dart:convert';

GetNotificationCountModal getNotificationCountModalFromJson(String str) => GetNotificationCountModal.fromJson(json.decode(str));

String getNotificationCountModalToJson(GetNotificationCountModal data) => json.encode(data.toJson());

class GetNotificationCountModal {
  int? userId;
  int? isReadcount;

  GetNotificationCountModal({
    this.userId,
    this.isReadcount,
  });

  factory GetNotificationCountModal.fromJson(Map<String, dynamic> json) => GetNotificationCountModal(
    userId: json["userId"],
    isReadcount: json["isReadcount"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "isReadcount": isReadcount,
  };
}
