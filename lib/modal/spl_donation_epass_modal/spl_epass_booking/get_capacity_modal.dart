
import 'dart:convert';

GetCapacityModal getCapacityModalFromJson(String str) => GetCapacityModal.fromJson(json.decode(str));

String getCapacityModalToJson(GetCapacityModal data) => json.encode(data.toJson());

class GetCapacityModal {
  int? id;
  DateTime? effectivedate;
  String? timeSlot;
  int? total;
  int? value;
  String? ePassName;

  GetCapacityModal({
    required this.id,
    required this.effectivedate,
    required this.timeSlot,
    required this.total,
    required this.value,
    required this.ePassName,
  });

  factory GetCapacityModal.fromJson(Map<String, dynamic> json) => GetCapacityModal(
    id: json["id"],
    effectivedate: json["effectivedate"] == null ? null : DateTime.parse(json["effectivedate"]),
    timeSlot: json["timeSlot"],
    total: json["total"],
    value: json["value"],
    ePassName: json["ePassName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "effectivedate": effectivedate?.toIso8601String(),
    "timeSlot": timeSlot,
    "total": total,
    "value": value,
    "ePassName": ePassName,
  };
}
