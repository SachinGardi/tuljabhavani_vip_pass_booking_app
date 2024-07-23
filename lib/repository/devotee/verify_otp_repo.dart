import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tulajapur/modal/devotee/verify_post_otp.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import '../../baseUrl/base_url.dart';
import '../../internet_service/CheckInternetCon.dart';
import '../../internet_service/snackbar.dart';

import '../../view/forgot_password/forgot_password_string.dart';
import '../../view/forgot_password/forgot_password_widget.dart';
import '../../view_modal/devotee_vm/verify_otpVm.dart';

final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
final verifyOTPVM  = Get.put(VerifyOTPVM());
class PostVerifyOTPRepo {
  static DevoteeVerifyModal verifyOtpListD = DevoteeVerifyModal();
  static var headers = {
    'Content-Type': 'application/json',
  };

  static PostVerifyData(String mobileNo, String otp, String pageName,
      BuildContext context) async {
    var data = jsonEncode({
      "mobileNo": mobileNo,
      "otp": otp,
      "pageName": pageName,
    });
    Uri url = Uri.http(uatBaseUrl,
        '/api/TuljapurEpassWebApi/login/VerifyOTP');
    try {

        http.Response response =
        await http.post(url, body: data, headers: headers);
        if (response.statusCode == 200) {
          Map temp = json.decode(utf8.decode(response.bodyBytes));
          print("temp");
          print(temp);

          if (temp["statusMessage"] == "OTP verified successfully") {
            otpVarifiedSuccessfully.value = true;
            if (forgotPageVisited == true) {
              otpVarifiedSuccessfully.value = true;
              toastMessage(context, "otpVerification".tr,color: Colors.greenAccent);
              Get.toNamed("/newPassword");
              forgotPageVisited = false;
              Timer(const Duration(seconds: 1), () {
                otpVarifiedSuccessfully.value = false;
              });

            }
          }
          else if(temp["statusMessage"] == "Please enter valid OTP."){
            otpVarifiedSuccessfully.value = true;
            toastMessage(context, "dValidOtpSnackBar".tr,color: Colors.redAccent);
            Timer(const Duration(seconds: 1), () {
              otpVarifiedSuccessfully.value = false;

            });


          }
          final value = DevoteeVerifyModal.fromJson(temp["responseData"]['responseData']);
          print(value.mobileNo);
          verifyOtpListD = value;
          print(temp);
        }


    } catch (e) {
      if (kDebugMode) {
        if (networkManager.connectionType == 0) {
          internetToastMessage();
        }
        print(e);
      }
    }
  }
}

