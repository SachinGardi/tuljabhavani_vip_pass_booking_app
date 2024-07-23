// To parse this JSON data, do
//
//     final updateProfile = updateProfileFromJson(jsonString);

import 'dart:convert';

ForgotPasswordModal updateProfileFromJson(String str) => ForgotPasswordModal.fromJson(json.decode(str));

String updateProfileToJson(ForgotPasswordModal data) => json.encode(data.toJson());

class ForgotPasswordModal {
  ForgotPasswordModal({
    this.newPass,
    this.mobileNumber,

  });

  String? newPass;
  String? mobileNumber;



  factory ForgotPasswordModal.fromJson(Map<String, dynamic> json) => ForgotPasswordModal(
    newPass: json["newPass"],
    mobileNumber: json["mobileNumber"],

  );

  Map<String, dynamic> toJson() => {
    "id": newPass,
    "MobileNo": mobileNumber,

  };
}
