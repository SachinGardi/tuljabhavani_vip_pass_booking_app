// To parse this JSON data, do
//
//     final getStatusModal = getStatusModalFromJson(jsonString);

import 'dart:convert';

GetFilterStatusModal getStatusModalFromJson(String str) => GetFilterStatusModal.fromJson(json.decode(str));

String getStatusModalToJson(GetFilterStatusModal data) => json.encode(data.toJson());

class GetFilterStatusModal {
  int? id;
  String? status;

  GetFilterStatusModal({
    this.id,
    this.status,
  });

  factory GetFilterStatusModal.fromJson(Map<String, dynamic> json) => GetFilterStatusModal(
    id: json["id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
  };
}
