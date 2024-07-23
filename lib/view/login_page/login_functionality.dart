import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import 'package:tulajapur/view/login_page/login_view.dart';
import '../../firebase_notification_service/firebase_noti_service.dart';
import '../../view_modal/login_vm/login_vm.dart';
import 'login_string.dart';
import 'login_widgets.dart';

LoginVM loginVM = Get.put(LoginVM());
var loginTap = false.obs;
loggedIn(BuildContext context) async {
  if (isTrusteeSelected == true) {
    loginTap.value = true;
    loginVM.isLoading.value = true;
    await loginVM.getLoginData(loginUserName.text, loginPassword.text,fcmToken!,userLoginId.toString(), context);
    if (loginVM.loginCredential.isNotEmpty) {
      if(blockStatus == true){
        toastMessage(context, "This user is blocked");
      }
    else  if(loginMessage == "Invalid UserName For Trustee."){
        toastMessage(context, "invalidUserName".tr,color: Colors.redAccent);
    }
     else  if(loginMessage == "Invalid Password For Trustee."    || loginMessage == "Invalid Password For Temple Staff."){
        toastMessage(context, "invalidPassword".tr,color: Colors.redAccent);
    }
     else{
        if(loginUserTypeId == 1 || loginUserTypeId == 5){
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('login', loginUserTypeId.toString());
          preferences.setString("loginUserId", loginId.toString());
          preferences.setBool("trusteeLogin", true);
          preferences.setBool("protocol", loginProtocol!);
          Get.offAllNamed("/mapDesign");
          loginPressed = true;
          toastMessage(context, "loginSuccessSnackBar".tr,color: Colors.greenAccent);
        }
        else{
          toastMessage(context, "invalidUserName".tr,color: Colors.red);
        }
        loginVM.loginCredential.clear();
      }

    }
  } else if (isValidatorSelected == true) {
    loginTap.value = true;
    loginVM.loginCredential.clear();
    loginVM.isLoading.value = true;
    await loginVM.getLoginData(loginUserName.text, loginPassword.text,fcmToken!,userLoginId.toString(), context);
    if (loginVM.loginCredential.isNotEmpty) {
      if(blockStatus == true){
        toastMessage(context, "This user is blocked");
      }

      else  if(loginMessage == "Invalid UserName For Validator."){
        toastMessage(context, "invalidUserName".tr,color: Colors.redAccent);
      }
      else  if(loginMessage == "Invalid Password For Validator."){
        toastMessage(context, "invalidPassword".tr,color: Colors.redAccent);
      }

      else{
        if(loginUserTypeId == 2){
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('login', loginUserTypeId.toString());
          preferences.setString("loginUserId", loginId.toString());
          preferences.setString("userName", name.toString());
          preferences.setBool("trusteeLogin", true);
          Get.offAllNamed("/scanPass");
          loginPressed = true;
          toastMessage(context, "loginSuccessSnackBar".tr,color: Colors.greenAccent);
        }
        else{
          toastMessage(context, "invalidUserName".tr,color: Colors.red);
        }
        loginVM.loginCredential.clear();
      }
      }
  }
}
