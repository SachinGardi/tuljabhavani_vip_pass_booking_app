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
import '../../internet_service/snackbar.dart';
import '../../modal/devotee/post_otp_modal.dart';

import '../../view/forgot_password/forgot_password_view.dart';
import '../../view/forgot_password/forgot_password_widget.dart';

final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
class PostOTPDevoteeRepo {
  static List<DevoteePostOTPModal> postotpListD=[];

  static PostData(
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
      Uri url = Uri.http(uatBaseUrl,
            '/api/TuljapurEpassWebApi/login/AddOTP');
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

          if (temp["statusMessage"] ==
              "Please enter registered mobile number.") {
            toastMessage(context, "numberisnotregister".tr,color: Colors.redAccent);
          Timer(Duration(seconds: 2), () {
            isPressed.value = false;
          });


          }
          else if (temp["statusMessage"] ==
              "OTP sent successfully.") {
            isShowResendBtn.value = false;
            getotp.value = true;
            isPressed.value = true;
            sentOTPDone = true;
            resendOtpbtn = true;
            toastMessage(context, "otp".tr,color: Colors.greenAccent);

            Timer(Duration(seconds: 1), () {
              isPressed.value = false;
            });
          }
          else if(temp["statusMessage"] == "OTP sending limit is exceeded for a minute, please try again later"){
            isPressed.value = true;

            toastMessage(context, "dOtpLimitExceedSnackBar".tr);

            Timer(Duration(seconds: 1), () {
              isPressed.value = false;
            });


        }
          else{
            Timer(Duration(seconds: 2), () {
              isPressed.value = false;
            });

          }
      }

            }catch (e) {
      if (kDebugMode) {
        print(e);
        isPressed.value = false;
        internetToastMessage();
      }
    }
  }
}

