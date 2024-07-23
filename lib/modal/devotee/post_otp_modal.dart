class DevoteePostOTPModal {

  String? mobileNo;
  String? otp;
  String? pageName;

  DevoteePostOTPModal({this.mobileNo,this.otp,this.pageName});
  ///convert from json to object
  factory DevoteePostOTPModal.fromJson(Map<String, dynamic> json)=>
      DevoteePostOTPModal(
        mobileNo: json["mobileNo"],
        otp: json["otp"],
        pageName: json["pageName"],

      );

  /// convert object to json
  Map<String, dynamic> toJson() =>
      {
        "mobileNo": mobileNo,
        "otp": otp,
        "pageName": pageName,

      };
}