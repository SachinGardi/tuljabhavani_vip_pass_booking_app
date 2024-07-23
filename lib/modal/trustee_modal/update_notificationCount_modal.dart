// To parse this JSON data, do
//
//     final updateNotificationCountModal = updateNotificationCountModalFromJson(jsonString);

import 'dart:convert';

List<UpdateNotificationCountModal> updateNotificationCountModalFromJson(String str) => List<UpdateNotificationCountModal>.from(json.decode(str).map((x) => UpdateNotificationCountModal.fromJson(x)));

String updateNotificationCountModalToJson(List<UpdateNotificationCountModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateNotificationCountModal {
  int? id;
  int? userId;

  UpdateNotificationCountModal({
    this.id,
    this.userId,
  });

  factory UpdateNotificationCountModal.fromJson(Map<String, dynamic> json) => UpdateNotificationCountModal(
    id: json["id"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
  };
}
