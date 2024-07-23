import 'dart:convert';

ConfirmVisitByValidatorModal confirmVisitByValidatorFromJson(String str) => ConfirmVisitByValidatorModal.fromJson(json.decode(str));

String confirmVisitByValidatorToJson(ConfirmVisitByValidatorModal data) => json.encode(data.toJson());

class ConfirmVisitByValidatorModal {
  int? id;
  int? devoteeId;
  int? modifiedBy;

  ConfirmVisitByValidatorModal({
    this.id,
    this.devoteeId,
    this.modifiedBy,
  });

  factory ConfirmVisitByValidatorModal.fromJson(Map<String, dynamic> json) => ConfirmVisitByValidatorModal(
    id: json["id"],
    devoteeId: json["devoteeId"],
    modifiedBy: json["modifiedBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "devoteeId": devoteeId,
    "modifiedBy": modifiedBy,
  };
}
