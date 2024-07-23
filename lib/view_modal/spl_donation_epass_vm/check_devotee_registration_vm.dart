import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../repository/spl_donation_epass_repo/check_devotee_registration_repo.dart';
import '../../repository/spl_donation_epass_repo/devotee_registration_repo.dart';



class CheckDevoteeRegistrationVM extends GetxController{
  var isLoading = true.obs;
  int? isRegister;
  checkDevoteeRegistration(
      String mobileNo,
      BuildContext context) async {
    var data = await CheckDevoteeRegistration.checkRegistration(mobileNo);
    isRegister = CheckDevoteeRegistration.isRegister;
    if(data!= null){
      isLoading.value = false;
    }
    else{
      Timer(const Duration(seconds: 1),(){
        isLoading.value = false;
      });
    }

  }
}