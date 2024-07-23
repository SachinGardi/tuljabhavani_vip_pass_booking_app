import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tulajapur/modal/devotee/verify_post_otp.dart';
import 'package:tulajapur/view/login_page/login_string.dart';
import '../../repository/devotee/verify_otp_repo.dart';
import '../../view/forgot_password/forgot_password_string.dart';



class VerifyOTPVM extends GetxController {
  DevoteeVerifyModal devoteeVerifyModal = DevoteeVerifyModal();
  var isLoading = true.obs;
  DevoteeVerifyModal verify = DevoteeVerifyModal();
  String? verifiedMobileNo;


  verifyForgotPassword(DevoteeVerifyModal devoteeVerifyModal,BuildContext context) async {
    await PostVerifyOTPRepo.PostVerifyData(
      otpNumber.text,
      fieldOne.text+fieldTwo.text+fieldThree.text+fieldFour.text+fieldFive.text,
      "sendotp",
      context,
    );
  }




}
