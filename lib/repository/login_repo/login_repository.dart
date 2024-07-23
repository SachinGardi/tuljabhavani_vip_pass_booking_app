import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import '../../baseUrl/base_url.dart';
import '../../internet_service/CheckInternetCon.dart';
import '../../modal/login_modal/login_modal.dart';
import 'package:http/http.dart'as http;

import '../../view/login_page/login_functionality.dart';
List<LoginModal> loginData = [];
final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
class LoginDetailsRepo {
  static var queryParameters;
  static Map temp ={};
  static loginDetailsRepo(String username,String password,String fcmId,String id,BuildContext context) async {
    queryParameters = {
      "UserName": username,
      "Password": password,
      "FCMId": fcmId,
      "LoginDeviceTypeId": "1",
      "Id": id,
    };

    Uri uri = Uri.http(
        uatBaseUrl,
            '/api/TuljapurEpassWebApi/AppLogin/GetUserLogin',
        LoginDetailsRepo.queryParameters);


    try {
      http.Response response = (await http.get(uri));
        print(response.statusCode);
        print("response.statusCode");
        if (response.statusCode == 200) {
          temp = json.decode(utf8.decode(response.bodyBytes));
          print(temp["statusMessage"]);
          if(temp["statusMessage"] == "User is incorrect." ){
            loginTap.value = false;
            toastMessage(context, "invalidUserName".tr,color: Colors.redAccent);
          }
          else if(temp["statusMessage"] == "Password is incorrect."){
            loginTap.value = false;
            toastMessage(context, "invalidPassword".tr,color: Colors.redAccent);
          }
          else if (temp["statusMessage"] == "Logged in successfully"){
            loginTap.value = false;
            print(temp);
            final value = LoginModal.fromJson(temp["responseData"]);
            loginData.add(value);

            return loginData;
          }

        }





    } catch (e) {
      print('Exception in Data $e');
    }
  }
}
