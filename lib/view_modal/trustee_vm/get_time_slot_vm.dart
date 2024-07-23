
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modal/trustee_modal/get_time_slot_modal.dart';
import '../../repository/trustee_respository/get_time_slot_repo.dart';
import '../../view/common_widget/snack_bar.dart';
String? timeSlotssforPass;
String? timeidsforPass;
TimeSlotRepo timeSlotRepo = TimeSlotRepo();
class GetTimeSlotVM extends GetxController {
  List <GetTimeSlotModal> timeslotLists = [];
  var isLoading = true.obs;
  getallTime(BuildContext context,String timeSlot) async {
    var getTimeDetails = await TimeSlotRepo.getTimeSlotData(context,timeSlot);
    if(getTimeDetails != null){
      timeslotLists = getTimeDetails;
      isLoading.value = false;
    }

    timeslotLists.forEach((element) {

      timeSlotssforPass = element.timeSlot!;
      timeidsforPass = element.id!.toString();
      print("####$timeSlotssforPass");
    });
  }
}