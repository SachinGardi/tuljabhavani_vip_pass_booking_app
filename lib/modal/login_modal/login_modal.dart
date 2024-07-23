// To parse this JSON data, do
//
//     final loginModal = loginModalFromJson(jsonString);

import 'dart:convert';

LoginModal loginModalFromJson(String str) => LoginModal.fromJson(json.decode(str));

String loginModalToJson(LoginModal data) => json.encode(data.toJson());

class LoginModal {
  int? id;
  String? name;
  String? mobileNo;
  String? emailId;
  int? userTypeId;
  String? userName;
  bool? isBlock;
  bool? protocol;
  int? deviceTypeId;
  String? userType;
  String? imagePath;
  String? designation;

  dynamic fcmId;
  dynamic version;
  dynamic msg;
  int? createdBy;
  List<dynamic>? pageLstModels;

  LoginModal({
    this.id,
    this.name,
    this.mobileNo,
    this.emailId,
    this.userTypeId,
    this.userName,
    this.isBlock,
    this.protocol,
    this.deviceTypeId,
    this.userType,
    this.imagePath,
    this.designation,
    this.fcmId,
    this.version,
    this.msg,
    this.createdBy,
    this.pageLstModels,
  });

  factory LoginModal.fromJson(Map<String, dynamic> json) => LoginModal(
    id: json["id"],
    name: json["name"],
    mobileNo: json["mobileNo"],
    emailId: json["emailId"],
    userTypeId: json["userTypeId"],
    userType: json["userType"],
    userName: json["userName"],
    isBlock: json["isBlock"],
    protocol: json["protocol"],
    deviceTypeId: json["deviceTypeId"],
    fcmId: json["fcmId"],
    imagePath: json["imagePath"],
    designation: json["designation"],
    version: json["version"],
    msg: json["msg"],
    createdBy: json["createdBy"],
    pageLstModels: json["pageLstModels"] == null ? [] : List<dynamic>.from(json["pageLstModels"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobileNo": mobileNo,
    "emailId": emailId,
    "userTypeId": userTypeId,
    "userType": userType,
    "userName": userName,
    "isBlock": isBlock,
    "protocol": protocol,
    "deviceTypeId": deviceTypeId,
    "fcmId": fcmId,
    "imagePath": imagePath,
    "designation": designation,
    "version": version,
    "msg": msg,
    "createdBy": createdBy,
    "pageLstModels": pageLstModels == null ? [] : List<dynamic>.from(pageLstModels!.map((x) => x)),
  };
}
