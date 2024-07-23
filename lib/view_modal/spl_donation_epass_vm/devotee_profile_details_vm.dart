import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../modal/spl_donation_epass_modal/devotee_profile_details.dart';
import '../../repository/spl_donation_epass_repo/devotee_profile_details_repo.dart';
import '../../view/non_referral_pass/devotee_profile/image_uploading_file.dart';




class DevoteeProfileDetailsVM extends GetxController{
  int? id;
  String? devoteeName;
  String? mobileNumber;
  String? gender;
  String? dob;
  String? aadhaarNo;
  var isLoading = true.obs;
  List<DevoteeProfileModal> devoteeProfileDetailsList = [];
  getDevoteeProfileDetails(
      String mobileNo,
      BuildContext context) async {
    var data = await DevoteeProfileDetailsRepo.devoteeProfileDetails(mobileNo);

    print(data);
    if(data!= null){
      devoteeProfileDetailsList = data;
      isLoading.value = false;
      devoteeProfileDetailsList.forEach((element) {
        id = element.id;
        devoteeName = element.devoteeName;
        mobileNumber = element.mobileNo;
        gender = element.gender;
        dob = DateFormat("dd-MM-yyyy").format(element.dateOfBirth!);
        aadhaarNo = element.aadharNo ?? "";
        imgLink.value = element.imagePath ?? "";
      });
      print(imgLink);

    }
    else{
      Timer(const Duration(seconds: 1),(){
        isLoading.value = false;
      });
    }

  }
}