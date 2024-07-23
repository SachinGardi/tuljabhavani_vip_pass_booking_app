import 'dart:async';
import 'package:get/get.dart';
import '../../modal/spl_donation_epass_modal/spl_epass_booking/get_capacity_modal.dart';
import '../../repository/spl_donation_epass_repo/spl_epass_booking/get_capacity_repo.dart';

int? availableCapacity;
String? timeSlot;
class GetCapacityVm extends GetxController{
  List<GetCapacityModal> getCapacityList = [];
 String? statusCode;
 String? statusMessage;
  var isLoading = true.obs;
  getCapacity(String capacityDate,int timeSlot,int ePassId,double amount) async {
    var getCapacityDetails = await GetCapacityRepo.getCapacityByTime(capacityDate, timeSlot, ePassId, amount);
    if(getCapacityDetails != null){
      getCapacityList = getCapacityDetails;
      isLoading.value = false;
    }else if(getCapacityDetails == null){
      Timer(const Duration(seconds: 1),(){
        isLoading.value = false;
      });
    }

    statusCode = GetCapacityRepo.statusCode;
    statusMessage = GetCapacityRepo.statusMessage;
    getCapacityList.forEach((element) {
      availableCapacity = element.value ?? 0;
    });
    print("availableCapacity: $availableCapacity");
    print("timeSlot: $timeSlot");
  }
}