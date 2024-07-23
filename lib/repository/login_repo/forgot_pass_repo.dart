import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tulajapur/view/common_widget/snack_bar.dart';

import '../../baseUrl/base_url.dart';
import '../../internet_service/CheckInternetCon.dart';
import '../../internet_service/snackbar.dart';
import '../../view/forgot_password/forgot_password_widget.dart';
import '../../view/forgot_password/new_password_view.dart';

final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
class NewPasswordRpo {
  static var queryParameters;
  static Map temp ={};
  static updatePass(String newPass, String mobileNo,BuildContext context) async {

    queryParameters = {
      "NewPassword": newPass,
      "MobileNo": mobileNo,

    };
    final uri = Uri.http(uatBaseUrl,
        '/api/TuljapurEpassWebApi/login/ForgotPassword',NewPasswordRpo.queryParameters);



    try {
      var request = await http.put(uri, headers: <String, String>{
        'Content-Type': 'application/json',
      });
      print(request.body);
      print(request.statusCode);
      print("Forgot Password $uri");
      Map temp = json.decode(utf8.decode(request.bodyBytes));

      if (request.statusCode == 200) {
        if(temp["statusMessage"] == "Password updated successfully"){
          passwordUpdated = true;
          toastMessage(context, "passwordMatching".tr,color: Colors.greenAccent);
          Timer(const Duration( seconds: 1), () {
           Get.offAllNamed("/loginView");
         });
        }
       else if(temp["statusMessage"] == "New password must not be same as old password!..."){
          toastMessage(context, "oldPasswordValidation".tr,color: Colors.redAccent);
        }
       else
       {
          toastMessage(context, "invalidPatternOfPasswordSnackBar".tr,color: Colors.redAccent);
       }


      }


    }catch (e) {
      print(e);
      internetToastMessage();
    }
  }
}
