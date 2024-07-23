class DevoteeVerifyModal {
  String? mobileNo;
  String? otp;
  String? pageName;

  DevoteeVerifyModal({this.mobileNo,this.otp,this.pageName});
  ///convert from json to object
  factory DevoteeVerifyModal.fromJson(Map<String, dynamic>json) =>
      DevoteeVerifyModal(
        mobileNo: json["mobileNo"],
        otp: json["otp"],
        pageName: json["pageName"],
      );

/// convert object to json
  Map<String,dynamic> tojson() =>
      {
        "mobileNo": mobileNo,
        "otp": otp,
        "pageName": pageName,
      };
}