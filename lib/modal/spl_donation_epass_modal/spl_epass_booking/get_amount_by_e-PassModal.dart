// To parse this JSON data, do
//
//     final getPassAmountModal = getPassAmountModalFromJson(jsonString);

import 'dart:convert';

GetPassAmountModal getPassAmountModalFromJson(String str) => GetPassAmountModal.fromJson(json.decode(str));

String getPassAmountModalToJson(GetPassAmountModal data) => json.encode(data.toJson());

class GetPassAmountModal {
  int? id;
  double? amount;

  GetPassAmountModal({
    required this.id,
    required this.amount,
  });

  factory GetPassAmountModal.fromJson(Map<String, dynamic> json) => GetPassAmountModal(
    id: json["id"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
  };
}
