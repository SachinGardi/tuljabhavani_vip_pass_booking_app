import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import '../../baseUrl/base_url.dart';
import '../../internet_service/CheckInternetCon.dart';
import '../../modal/devotee/post_otp_modal.dart';


class SplDonationPassOtpRepo {
  static String? statusCode;
  static String? statusMessage;
  static postDonationPassOtp(
      String mobileNo,
      BuildContext context
      ) async {
    var data = jsonEncode({
      "mobileNo": mobileNo,
      "email": "",
      "otp": "",
      "pageName": "sendotp"
    }
    );
    try {
      Uri url = Uri.http(uatBaseUrl,'/api/TuljapurEpassWebApi/ePassBooking/AddOTP');
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

