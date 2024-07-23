import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Repository/logout_repo.dart';




class LogoutViewModal extends GetxController {
  var isLoading = true.obs;
  String? statusCode ;
  String? statusMessage ;
  @override
  void onInit() {
    super.onInit();
  }
  logoutCurrentUser(String userId,String userTypeId,BuildContext context) async {
    await LogoutRepo.logoutUser("0", userId,userTypeId,context);
    statusCode = LogoutRepo.statusCode;
    statusMessage = LogoutRepo.statusMessage;
  }
}
