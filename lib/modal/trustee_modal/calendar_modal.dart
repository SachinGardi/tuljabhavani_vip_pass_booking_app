// To parse this JSON data, do
//
//     final calendarmodal = calendarmodalFromJson(jsonString);

import 'dart:convert';

Calendarmodal calendarmodalFromJson(String str) => Calendarmodal.fromJson(json.decode(str));

String calendarmodalToJson(Calendarmodal data) => json.encode(data.toJson());

class Calendarmodal {
  int? srNo;
  DateTime? date;
  String? status;

  Calendarmodal({
    this.srNo,
    this.date,
    this.status,
  });

  factory Calendarmodal.fromJson(Map<String, dynamic> json) => Calendarmodal(
    srNo: json["srNo"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "srNo": srNo,
    "date": date?.toIso8601String(),
    "status": status,
  };
}
