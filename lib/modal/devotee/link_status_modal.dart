// To parse this JSON data, do
//
//     final linkCheckModal = linkCheckModalFromJson(jsonString);

import 'dart:convert';

LinkCheckModal linkCheckModalFromJson(String str) => LinkCheckModal.fromJson(json.decode(str));

String linkCheckModalToJson(LinkCheckModal data) => json.encode(data.toJson());

class LinkCheckModal {
  int? isExpired;

  LinkCheckModal({
     this.isExpired,
  });

  factory LinkCheckModal.fromJson(Map<String, dynamic> json) => LinkCheckModal(
    isExpired: json["isExpired"],
  );

  Map<String, dynamic> toJson() => {
    "isExpired": isExpired,
  };
}
