
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../baseUrl/base_url.dart';
import 'package:http/http.dart' as http;

class DevoteeRegistrationRepo{
  static String? statusCode;
  static String? statusMessage;
  static int? registrationId;
  static postRegistrationData(
      int id,
      String devoteeName,
      String mobileNo,
      String dob,
      String gender,
      String aadhaarNo,
      String imagePath,
      String fcmId,

      )async{
    var data = jsonEncode({
      "id": id,
      "devoteeName": devoteeName,
      "mobileNo": mobileNo,
      "dateOfBirth": dob,
      "gender": gender,
      "aadharNo": aadhaarNo,
      "createdBy": 0,
      "modifiedBy": 0,
      "createdDate": DateTime.now().toIso8601String(),
      "modifiedDate": DateTime.now().toIso8601String(),
      "isDeleted": true,
      "imagePath":imagePath,
      "userTypeId":4,
      "designation":"",
      "fcmId":fcmId,
      "deviceTypeId":1,
    });
    try {
      print(data);
      Uri url = Uri.http(uatBaseUrl,'/api/TuljapurEpassWebApi/UserRegistration/RegisterDevotee');
      print(url);
      http.Response response = ( await http.post(url, body: data,
      headers: {
      HttpHeaders.contentTypeHeader: 'text/json',
      'Content-Transfer-Encoding': 'base64'
      }));
    print(response.statusCode);
    if (response.statusCode == 200) {
    Map temp = json.decode(utf8.decode(response.bodyBytes));
    print("temp$temp");
    statusCode = temp['statusCode'];
    statusMessage = temp['statusMessage'];
    registrationId = temp['responseData'];
    }
    }catch (e) {
    if (kDebugMode) {
    print(e);
    }
    }
  }
}