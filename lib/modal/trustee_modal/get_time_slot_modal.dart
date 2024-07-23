

import 'dart:convert';

GetTimeSlotModal getTimeSlotModalFromJson(String str) => GetTimeSlotModal.fromJson(json.decode(str));

String getTimeSlotModalToJson(GetTimeSlotModal data) => json.encode(data.toJson());

class GetTimeSlotModal {
  int? id;
  String? timeSlot;

  GetTimeSlotModal({
    this.id,
    this.timeSlot,
  });

  factory GetTimeSlotModal.fromJson(Map<String, dynamic> json) => GetTimeSlotModal(
    id: json["id"],
    timeSlot: json["timeSlot"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "timeSlot": timeSlot,
  };
}
