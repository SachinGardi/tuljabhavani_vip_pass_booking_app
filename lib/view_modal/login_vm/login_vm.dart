import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
//import 'package:get_storage/get_storage.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import '../../internet_service/snackbar.dart';
import '../../modal/login_modal/login_modal.dart';
import '../../repository/login_repo/login_repository.dart';
import '../../view/login_page/login_functionality.dart';

int? loginUserTypeId;
int? loginId;
String? userType;
String? trusteeName;
String? trusteeProfile;
String? trusteeDesignation;
String? loginMessage;
bool? blockStatus;
String? name;
bool? loginProtocol;

class LoginVM extends GetxController {
  List<LoginModal> loginCredential = [];
  RxBool isLoading = true.obs;
  // final userIdStorage = GetStorage();
  // final userTypeStorage = GetStorage();


  getLoginData(String username, String password, String fcmId, String id,
      BuildContext context) async {
    var details = await LoginDetailsRepo.loginDetailsRepo(
        username, password, fcmId, id, context);
    if (details != null) {
      loginCredential = details;
      isLoading.value = false;
    } else if (details == null) {
      Timer(const Duration(seconds: 1), () {
        isLoading.value = false;
        loginTap.value=false;
        internetToastMessage();
      });
    }
    for (var element in loginCredential) {
      loginUserTypeId = element.userTypeId;
    }
    for (var element in loginCredential) {
      // userIdStorage.write('userId', element.id);
      // userTypeStorage.write('userType', element.userType);
      blockStatus = element.isBlock;
      loginId = element.id;
      name = element.name;
      loginProtocol = element.protocol;
      loginMessage = element.msg;
    }
  }
}
