
import 'package:get/get.dart';

import '../../modal/booking_history_modal/time_slot_filter_modal.dart';
import '../../repository/booking_history_repo/get_timeSlot_filter_repo.dart';




String? timeSlotssforPass;
String? timeidsforPass;
class GetTimeSlotFilterVM extends GetxController {
  List <GetTimeSlotFilterModal> timeslotLists = [];
  var isLoading = true.obs;
  getallTime() async {
    var getTimeDetails = await TimeSlotFilterRepo.getTimeSlotFilterData();
    print(getTimeDetails);
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