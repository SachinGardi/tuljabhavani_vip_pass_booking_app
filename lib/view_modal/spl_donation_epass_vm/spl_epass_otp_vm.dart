import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../repository/spl_donation_epass_repo/spl_epass_otp_repo.dart';


class SplDonationPassOTPVM extends GetxController{
  var isLoading = true.obs;
  String? statusCode;
  String? statusMessage;
  postOTPInfo(String mobileNo,BuildContext context) async {
    var data = await SplDonationPassOtpRepo.postDonationPassOtp(
        mobileNo,
        context
    );
    if(data!= null){
      isLoading.value = false;
    }
    else{
      Timer(const Duration(seconds: 2),(){
        isLoading.value = false;
      });
    }

    statusCode = SplDonationPassOtpRepo.statusCode;
    statusMessage = SplDonationPassOtpRepo.statusMessage;


  }
}