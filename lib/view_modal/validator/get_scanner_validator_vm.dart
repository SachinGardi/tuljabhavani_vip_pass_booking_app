



import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../internet_service/snackbar.dart';
import '../../modal/validator/validator_scannar_modal.dart';
import '../../repository/validator_repo/get_scannar_validator_repo.dart';
import '../../view/validator_module/scan_pass/scan_pass_string.dart';




class ValidatorScannerDetailsVM extends GetxController {
  List<ValidatorScannarModal> scannerDetails =[];
  var isLoading = true.obs;


  getValidatingDetails(String devoteeId,BuildContext context) async {
    var data = await GetScannarDetailsRepo.validate(devoteeId, context);
    print("__$data");
    if(data != null){
      scannerDetails = data;
      isLoading.value = false;

    }
    else  if(data == null){

   Timer(Duration(seconds: 1),(){
     isLoading.value = false;
   // internetToastMessage();

   });

    }


    print(scannerDetails);
    scannerDetails.forEach((element) {
       devoteeName = element.devoteeName;
       mobileNo= element.mobileNo;
       gender = element.gender;
       dateOfBirth = DateFormat('dd/MM/yyyy').format(DateTime.parse(element.dateOfBirth.toString()));
       age = element.age;
       address = element.address;
       adharNo = element.aadharNo;
       referBy = element.referBy;
       visitDate =DateFormat('dd/MM/yyyy').format(DateTime.parse(element.visitDate.toString()));
       visitTime = element.visitTime;
       donation = element.donation.toString();
       imagePath = element.imagePath;
       barcodeText= element.barcodeText;
       id = element.id;
       verifyDId = element.devoteeId;
       validatorStatusId = element.statusId;
       passName =element.ePassName;
       passTransactionDate =element.transactionDate == null ? "": DateFormat('dd/MM/yyyy').format(DateTime.parse(element.transactionDate.toString()));
       passTransactionId = element.transactionId.toString();
       passScanDate  = element.scanDate == null ? "" :DateFormat('dd/MM/yyyy').format(DateTime.parse(element.scanDate.toString()));
       passValidatorName = element.validatorName.toString();
       passBookingId = element.bookingId.toString();
       passBookingDate  = element.bookingDate == null ? "" :DateFormat('dd/MM/yyyy').format(DateTime.parse(element.bookingDate.toString()));

    });
  }
}





