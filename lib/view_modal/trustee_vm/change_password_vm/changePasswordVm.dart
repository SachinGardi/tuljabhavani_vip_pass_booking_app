import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';



import '../../../modal/trustee_modal/change_password_modal/change_password_modal.dart';
import '../../../repository/trustee_respository/change_password_repo/change_password_repo.dart';

class ChangePasswordVm extends GetxController{


  passwordChange(ChangePasswordModal changePassword, String currentPass, String newPassword,BuildContext context,int userId)async{
    await ChangePasswordRepo.changePassword(currentPass, newPassword,context,userId);

  }






}