import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../repository/spl_donation_epass_repo/spl_epass_add_details_repo/add_devotee_details_repo.dart';

class AddDevoteeDetailsVM extends GetxController{

  var isLoading = true.obs;
 String? statusCode;
 String? statusMessage;
  postDevoteeDetails(
      int id,
      int devoteeId,
      int referById,
      String devoteeName,
      String mobileNo,
      String emailId,
      int amount,
      String gender,
      DateTime dateOfBirth,
      String aadharNo,
      String address,
      String imagePath,
      int createdBy,
      DateTime createdDate,
      bool isPaymentdone,
      String transactionId,
      String documentPath,
      String referanceName,
      BuildContext context
      )async{
    var data = await AddDevoteeDetailsRepo.postDevoteeDetailsRepo(id,
        devoteeId,
        referById, devoteeName, mobileNo,
        emailId, amount, gender, dateOfBirth,
        aadharNo, address, imagePath,
        createdBy, createdDate, isPaymentdone,
        transactionId, documentPath, referanceName, context);

    print("data$data");
    if(statusCode != null){

      isLoading.value = false;
    }
    else{
      Timer(Duration(seconds: 1), () {
        isLoading.value = false;
      });
    }
    statusMessage = AddDevoteeDetailsRepo.statusMessage;
    statusCode = AddDevoteeDetailsRepo.statusCode;


  }



}