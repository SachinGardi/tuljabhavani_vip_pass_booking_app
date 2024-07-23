import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../modal/devotee/post_otp_modal.dart';
import '../../repository/devotee/post_devotee_otp.dart';
import '../../repository/devotee/post_otp_repo.dart';
import '../../view/forgot_password/forgot_password_string.dart';

class AddOTPVM extends GetxController{

  DevoteePostOTPModal devoteePostOTPModal = DevoteePostOTPModal();
  var isLoading = true.obs;

  @override
  void onReady() {

  }

  forgotPassOTP(DevoteePostOTPModal devoteePostOTPModal,BuildContext context) async {
    await PostOTPDevoteeRepo.PostData(
        otpNumber.text,
        "",
        "sendotp",
        context
    );}

  }