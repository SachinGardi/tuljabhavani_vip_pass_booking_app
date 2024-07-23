

import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../../../modal/spl_donation_epass_modal/spl_epass_add_details_modal/visitdate_time_details_modal.dart';
import '../../../repository/spl_donation_epass_repo/spl_epass_add_details_repo/visitdate_time_deatils_repo.dart';

class VisitDateAndTimeDetailsVM extends GetxController
{
  String?  visitDate;
  String?  timeSlot;
  int?     noOfDevotees;
  int?   totalAmount;
  int?   devoteeID;
  int? isExpired;
  List<VisitDateAndTimeDetailsModal> visitDateAndTimeDetailsList = [];
  var isLoading = true.obs;

  getVisitDateTimeDetails(String mobileNo)async{
    var data = await VisitTimeAndDateDetailsRepo.getVisitDateAndTimeInfo(mobileNo);
    print("data$data");
    if(data != null){
      visitDateAndTimeDetailsList = data;
      isLoading.value = false;
    }
    else{
      Timer(Duration(seconds: 1), () {
        isLoading.value = false;

      });
    }


    visitDateAndTimeDetailsList.forEach((element) {

      print(element.visitDate);
      devoteeID =element.id;
      visitDate =  DateFormat('dd/MM/yyyy').format(element.visitDate!) ;
      timeSlot = element.visitTime;
      noOfDevotees = element.noOfTotalDevotee;
      totalAmount =  element.totalAmount;
      isExpired = element.statusId;
    });
  }
}