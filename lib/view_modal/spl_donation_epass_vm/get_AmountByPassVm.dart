import 'dart:async';
import 'package:get/get.dart';
import '../../repository/spl_donation_epass_repo/spl_epass_booking/get_amount_bye-PassRepo.dart';
import '../../modal/spl_donation_epass_modal/spl_epass_booking/get_amount_by_e-PassModal.dart';



double? passAmount;

class GetAmountByPassVm extends GetxController{
  List<GetPassAmountModal> getAmountByPassList = [];
  var isLoading = true.obs;

  getAmountByPassDetails(int id) async {
    var getAmountDetails = await GetAmountByPassRepo.getAmountbyPassData(id);
    if(getAmountDetails != null){
      getAmountByPassList = getAmountDetails;
      isLoading.value = false;
    } else if(getAmountDetails == null){
      Timer(const Duration(seconds: 2),(){
        isLoading.value = false;
      });
    }

    getAmountByPassList.forEach((element) {
      passAmount = element.amount;
    });
  }
}