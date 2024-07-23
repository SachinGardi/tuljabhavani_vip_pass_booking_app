// To parse this JSON data, do
//
//     final changePassword = changePasswordFromJson(jsonString);

import 'dart:convert';

ChangePasswordModal changePasswordFromJson(String str) => ChangePasswordModal.fromJson(json.decode(str));

String changePasswordToJson(ChangePasswordModal data) => json.encode(data.toJson());

class ChangePasswordModal {
  int? userId;
  String? currentPassword;
  String? newPassword;

  ChangePasswordModal({
    this.userId,
    this.currentPassword,
    this.newPassword,
  });

  factory ChangePasswordModal.fromJson(Map<String, dynamic> json) => ChangePasswordModal(
    userId: json["userId"],
    currentPassword: json["currentPassword"],
    newPassword: json["newPassword"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "currentPassword": currentPassword,
    "newPassword": newPassword,
  };
}
