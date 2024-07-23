import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tulajapur/firebase_notification_service/firebase_noti_service.dart';
import '../../repository/spl_donation_epass_repo/spl_epass_verifyotp_repo.dart';


class SplePassVerifyOTPVM extends GetxController{
  var isLoading = true.obs;
  String? statusCode;
  String? statusMessage;
  postVerifyOtpVm(String mobileNo,String otp,BuildContext context) async {
    var data = await SplePassVerifyOtpRepo.devoteePostVerifyOtp(
        mobileNo,
        otp,
        "sendotp",
        fcmToken!,
        context
    );

    if(data!= null){
      isLoading.value = false;
    }
    else{
      Timer(const Duration(seconds: 1),(){
        isLoading.value = false;
      });
    }
    statusCode = SplePassVerifyOtpRepo.statusCode;
    statusMessage = SplePassVerifyOtpRepo.statusMessage;
  }
}