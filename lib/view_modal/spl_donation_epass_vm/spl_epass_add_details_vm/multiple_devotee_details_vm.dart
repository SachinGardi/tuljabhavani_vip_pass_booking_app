import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../modal/spl_donation_epass_modal/spl_epass_add_details_modal/multiple_devotee_deatils_modal.dart';
import '../../../repository/spl_donation_epass_repo/spl_epass_add_details_repo/multiple_devotee_details_repo.dart';

class MultipleDevoteeDetailsVM extends GetxController{

  List<MultipleDevoteeDetailsModal> allDevoteeDetailsList = [];
  var isLoading = true.obs;
  String? devoteeId;
  getAllDevoteeDetails(String mobileNumber)async{
    var data = await MultipleDevoteeDetailsRepo.getAllDevoteeDetails(
        mobileNumber,

    );
    print(data);
    if(data != null){
      allDevoteeDetailsList = data;
      isLoading.value = false;
    }
    else{
     Timer(Duration(seconds: 1), () {
       isLoading.value = false;
     });
    }

    allDevoteeDetailsList.forEach((element) {
      devoteeId= element.devoteeId.toString();
    });
  }

}