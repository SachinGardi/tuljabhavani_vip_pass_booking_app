import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modal/forgot_password_modal.dart';
import '../repository/login_repo/forgot_pass_repo.dart';
import '../view/forgot_password/forgot_password_string.dart';

class UpdatePassVM extends GetxController {
  var isLoading = true.obs;
  String? message;

  updatePassword(ForgotPasswordModal forgotPasswordModal,BuildContext context) async {
    await NewPasswordRpo.updatePass(
        forgotReEnterPass.text,
        otpNumber.text,
        context
    );
  }

}
