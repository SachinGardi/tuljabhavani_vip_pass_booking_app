import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import '../../baseUrl/base_url.dart';

import '../../modal/devotee/post_otp_modal.dart';


class PostDevoteeOTPDevoteeRepo {
  static List<DevoteePostOTPModal> postotpListD=[];

  static PostDevoteeOtp(
      String mobileNo,
      String otp,
      String pageName,
      BuildContext context
      ) async {

    var data = jsonEncode({
      "mobileNo": mobileNo,
      "otp": otp,
      "pageName": pageName,
    }
    );
    try {
      print(data);
      Uri url = Uri.http(uatBaseUrl,
          '/api/TuljapurEpassWebApi/ePassBooking/AddOTP');
      http.Response response = ( await http.post(
          url,
          body: data,
          headers: {
            HttpHeaders.contentTypeHeader: 'text/json',
            'Content-Transfer-Encoding': 'base64'
          }));
      if (response.statusCode == 200) {
        Map temp = json.decode(utf8.decode(response.bodyBytes));
        print(temp);

        if (temp["statusMessage"] == "Please enter registered mobile number.") {
          toastMessage(context, "invalidMobileNumber".tr,color: Colors.redAccent);
          Timer(const Duration(seconds: 2), () {

          });
        }

        else if(temp["statusMessage"] == "Object reference not set to an instance of an object."){
          toastMessage(context, temp["statusMessage"],color: Colors.redAccent);
          Timer(const Duration(seconds: 2), () {

          });
        }
        else if(temp["statusMessage"] == "Mobile number is registered with trustee/validator."){
          toastMessage(context, 'mobileAlreadyRegisteredMsg'.tr);
          Timer(const Duration(seconds: 2), () {

          });
        }

        else if (temp["statusMessage"] ==
            "OTP sent successfully") {
          toastMessage(context, "otp".tr,color: Colors.greenAccent);

          Timer(Duration(seconds: 1), () {

          });
        }
        else if(temp["statusMessage"] == "OTP sending limit is exceeded for a minute, please try again later"){


          toastMessage(context, "dOtpLimitExceedSnackBar".tr);

          Timer(Duration(seconds: 1), () {

          });
        }
      }

    }catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

