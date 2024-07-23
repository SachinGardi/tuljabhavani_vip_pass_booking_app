import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../baseUrl/base_url.dart';



class SplePassVerifyOtpRepo {
  static String? statusCode;
  static String? statusMessage;
  static devoteePostVerifyOtp(
      String mobileNo,
      String otp,
      String pageName,
      String fcmId,
      BuildContext context
      ) async {
    var data = jsonEncode({
      "mobileNo": mobileNo,
      "otp": otp,
      "pageName": pageName,
      "fcmId": fcmId,
    }
    );
    try {
      print(data);
      Uri url = Uri.http(uatBaseUrl,'/api/TuljapurEpassWebApi/ePassBooking/VerifyOTP');
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
      }
    }catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

