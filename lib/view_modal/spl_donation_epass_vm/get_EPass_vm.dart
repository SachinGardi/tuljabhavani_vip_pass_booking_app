

import 'dart:async';
import 'package:get/get.dart';
import '../../modal/spl_donation_epass_modal/spl_epass_booking/get_ePass_modal.dart';
import '../../repository/spl_donation_epass_repo/spl_epass_booking/get_ePass_repo.dart';


String? passName;
class GetEPassVm extends GetxController{
  List<GetEPassModal> getEPassList = [];
  var isLoading = true.obs;

  getEPassName(int ePassType) async {
    var getEPassDetails = await GetEPassRepo.getEPassData(ePassType);
    if(getEPassDetails != null){
      getEPassList = getEPassDetails;
      isLoading.value = false;
    }
    else if(getEPassDetails == null){
      Timer(const Duration(seconds: 2),(){
        isLoading.value = false;
      });
    }
    getEPassList.forEach((element) {
      passName = element.ePassName;
    });
  }
}