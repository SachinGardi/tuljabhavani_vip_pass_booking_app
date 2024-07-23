import 'dart:convert';

ContactUsModal contactUsFromJson(String str) => ContactUsModal.fromJson(json.decode(str));
String contactUsToJson(ContactUsModal data) => json.encode(data.toJson());
class ContactUsModal {
  int? id;
  String? sansthanName;
  String? emailId1;
  String? emailId2;
  String? contactNo1;
  String? contactNo2;
  String? contactPerson;
  String? contactPersonDesignation;
  String? workingHours;
  String? address;
  String? information;
  String? photoPath;
  int? createdBy;
  int? modifiedBy;
  DateTime? createdDate;
  DateTime? modifiedDate;
  bool? isDeleted;

  ContactUsModal({
    this.id,
    this.sansthanName,
    this.emailId1,
    this.emailId2,
    this.contactNo1,
    this.contactNo2,
    this.contactPerson,
    this.contactPersonDesignation,
    this.workingHours,
    this.address,
    this.information,
    this.photoPath,
    this.createdBy,
    this.modifiedBy,
    this.createdDate,
    this.modifiedDate,
    this.isDeleted,
  });

  factory ContactUsModal.fromJson(Map<String, dynamic> json) => ContactUsModal(
    id: json["id"],
    sansthanName: json["sansthanName"],
    emailId1: json["emailId1"],
    emailId2: json["emailId2"],
    contactNo1: json["contactNo1"],
    contactNo2: json["contactNo2"],
    contactPerson: json["contactPerson"],
    contactPersonDesignation: json["contactPersonDesignation"],
    workingHours: json["workingHours"],
    address: json["address"],
    information: json["information"],
    photoPath: json["photoPath"],
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sansthanName": sansthanName,
    "emailId1": emailId1,
    "emailId2": emailId2,
    "contactNo1": contactNo1,
    "contactNo2": contactNo2,
    "contactPerson": contactPerson,
    "contactPersonDesignation": contactPersonDesignation,
    "workingHours": workingHours,
    "address": address,
    "information": information,
    "photoPath": photoPath,
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "createdDate": createdDate?.toIso8601String(),
    "modifiedDate": modifiedDate?.toIso8601String(),
    "isDeleted": isDeleted,
  };
}
