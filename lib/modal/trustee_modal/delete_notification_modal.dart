// To parse this JSON data, do
//
//     final deleteNotificationModal = deleteNotificationModalFromJson(jsonString);

import 'dart:convert';

DeleteNotificationModal deleteNotificationModalFromJson(String str) => DeleteNotificationModal.fromJson(json.decode(str));

String deleteNotificationModalToJson(DeleteNotificationModal data) => json.encode(data.toJson());

class DeleteNotificationModal {
  int? id;
  int? deletedBy;

  DeleteNotificationModal({
    this.id,
    this.deletedBy,
  });

  factory DeleteNotificationModal.fromJson(Map<String, dynamic> json) => DeleteNotificationModal(
    id: json["id"],
    deletedBy: json["deletedBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "deletedBy": deletedBy,
  };
}
