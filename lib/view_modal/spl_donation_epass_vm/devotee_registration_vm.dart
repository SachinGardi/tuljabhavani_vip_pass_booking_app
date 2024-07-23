import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../repository/spl_donation_epass_repo/devotee_registration_repo.dart';



class DevoteeRegistrationVM extends GetxController{
  var isLoading = true.obs;
  String? statusCode;
  String? statusMessage;
  String? registrationId;
  postDevoteeRegistrationData(
      int id,
      String devoteeName,
      String mobileNo,
      String dob,
      String gender,
      String aadhaarNo,
      String imagePath,
      String fcmId,
      BuildContext context) async {
    var data = await DevoteeRegistrationRepo.postRegistrationData(
        id,
        devoteeName,
        mobileNo,
        dob,
        gender,
        aadhaarNo,
        imagePath,
        fcmId

    );
    if(data!= null){
      isLoading.value = false;
    }
    else{
      Timer(const Duration(seconds: 2),(){
        isLoading.value = false;
      });
    }
    statusCode = DevoteeRegistrationRepo.statusCode;
    statusMessage = DevoteeRegistrationRepo.statusMessage;
    registrationId = DevoteeRegistrationRepo.registrationId.toString();
  }
}