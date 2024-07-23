

import 'dart:convert';

GetEPassModal getEPassModalFromJson(String str) => GetEPassModal.fromJson(json.decode(str));

String getEPassModalToJson(GetEPassModal data) => json.encode(data.toJson());

class GetEPassModal {
  int id;
  String ePassName;

  GetEPassModal({
    required this.id,
    required this.ePassName,
  });

  factory GetEPassModal.fromJson(Map<String, dynamic> json) => GetEPassModal(
    id: json["id"],
    ePassName: json["ePassName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ePassName": ePassName,
  };
}
