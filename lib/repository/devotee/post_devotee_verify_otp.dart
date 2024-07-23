import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tulajapur/modal/devotee/verify_post_otp.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import '../../baseUrl/base_url.dart';
import '../../view_modal/devotee_vm/verify_otpVm.dart';
final verifyOTPVM  = Get.put(VerifyOTPVM());
class PostDevoteeVerifyOTPRepo {
  static DevoteeVerifyModal verifyOtpListD = DevoteeVerifyModal();
  static var headers = {
    'Content-Type': 'application/json',
  };

  static postDevoteeVerifyData(String mobileNo, String otp, String pageName,
      BuildContext context) async {
    var data = jsonEncode({
      "mobileNo": mobileNo,
      "otp": otp,
      "pageName": pageName,
    });
    Uri url = Uri.http(uatBaseUrl,
        '/api/TuljapurEpassWebApi/ePassBooking/VerifyOTP');
    try {
      print(url);
      print(data);
        http.Response response =
        await http.post(url, body: data, headers: headers);
        if (response.statusCode == 200) {
          Map temp = json.decode(utf8.decode(response.bodyBytes));
          print(temp);
          if (temp["statusMessage"] == "OTP verified successfully") {

          }
          else if(temp["statusMessage"] == "Please enter valid OTP."){

            toastMessage(context, "dValidOtpSnackBar".tr,color: Colors.redAccent);
            Timer(const Duration(seconds: 1), () {

            });

          }
          else{

          }

          final value = DevoteeVerifyModal.fromJson(temp["responseData"]['responseData']);
          print(value.mobileNo);
          verifyOtpListD = value;
          print(temp);
        }


    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

