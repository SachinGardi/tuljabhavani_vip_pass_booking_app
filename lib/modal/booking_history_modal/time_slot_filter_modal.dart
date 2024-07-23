

import 'dart:convert';

GetTimeSlotFilterModal getTimeSlotModalFromJson(String str) => GetTimeSlotFilterModal.fromJson(json.decode(str));

String getTimeSlotModalToJson(GetTimeSlotFilterModal data) => json.encode(data.toJson());

class GetTimeSlotFilterModal {
  int? id;
  String? timeSlot;

  GetTimeSlotFilterModal({
    this.id,
    this.timeSlot,
  });

  factory GetTimeSlotFilterModal.fromJson(Map<String, dynamic> json) => GetTimeSlotFilterModal(
    id: json["id"],
    timeSlot: json["timeSlot"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "timeSlot": timeSlot,
  };
}
