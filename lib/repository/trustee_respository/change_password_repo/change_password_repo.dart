import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../baseUrl/base_url.dart';
import '../../../internet_service/CheckInternetCon.dart';
import '../../../view/change_password/password_design.dart';
import '../../../view/common_widget/snack_bar.dart';
import '../../../view_modal/login_vm/login_vm.dart';


final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
class ChangePasswordRepo{
  static final loginVm = Get.put(LoginVM());
  static var headers = {
    'Content-Type': 'application/json',
  };


  static changePassword(
      String currentPass,
      String newPass,
      BuildContext context,
      int userId,
      )async{
    Uri url = Uri.http(uatBaseUrl,'/api/TuljapurEpassWebApi/login/change-password');
    var data = jsonEncode({
      'userId':'$userId',
      'currentPassword':currentPass,
      'newPassword':newPass
    });
    try{
      http.Response response = await(http.post(url,body:data,headers: headers ));
        if(response.statusCode == 200){
          Map temp = jsonDecode(response.body);
          print(response.body);


          if(temp['responseData'] == 'Please enter valid current password'){
            toastMessage(context,'invalidCurrentPasswordSnackBar'.tr);
          }



          else if(temp['responseData'] == 'Password changed successfully...'){
            toastMessage(context,'successMsgSnackBar'.tr);
            changePassUpdated = true;
            //SharedPreferences pref = await SharedPreferences.getInstance();
            Get.back();
            // pref.clear();
            // loginVm.userIdStorage.remove('userId');
            currentPasswordController.text = '';
            newPasswordController.text = '';
            confirmPasswordController.text = '';
          }
          else if(temp['statusMessage'] == 'Old password and new password should not be same'){
            toastMessage(context,'oldNewShouldNotMatch'.tr);
          }
          else {
            toastMessage(context,'invalidPatternOfPasswordSnackBar'.tr);
          }


        }



    }catch(e){

      if(kDebugMode){
        print(e);
      }
      debugPrintStack();
    }
  }

}