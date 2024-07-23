import 'dart:async';

import 'package:get/get.dart';
import '../../repository/spl_donation_epass_repo/free_pass_details_repo.dart';

class FreePassDetailsVM extends GetxController{
  var isLoading = true.obs;
  String? statusCode;
  freePassDetails(int devoteeId)async{
    var data = await FreePassDetailsRepo.freePassDetails(devoteeId);
    print("data:$data");
    if(data != null){
      isLoading.value = false;
      statusCode = FreePassDetailsRepo.statusCode;
    }
    else{
      Timer(Duration(seconds: 1), () {
        isLoading.value = false;
        statusCode = FreePassDetailsRepo.statusCode;

      });
    }


  }


}