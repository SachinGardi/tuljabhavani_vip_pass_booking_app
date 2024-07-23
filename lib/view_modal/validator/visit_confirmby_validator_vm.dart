import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../internet_service/snackbar.dart';
import '../../modal/validator/visitconfirmbyvalidator.dart';
import '../../repository/validator_repo/visit_confirm_by_validator.dart';
import '../../view/validator_module/scan_pass/scan_pass_string.dart';
import '../login_vm/login_vm.dart';

LoginVM _loginVM = Get.put(LoginVM());
class VisitConfirmByValidatorVM extends GetxController{
  String? statusCode;
  String? statusMessage;
  var isLoading =true.obs;
  List<ConfirmVisitByValidatorModal> visitDataList = [];
  visitData(ConfirmVisitByValidatorModal confirmVisitByValidatorModal,BuildContext context)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var details =await VisitConfirmByValidatorRepo.updateValidatorVisit(
        id.toString(),
        verifyDId.toString(),
        pref.getString("loginUserId").toString(),
        context);
    print("======$details");
    if(details!= null){

      visitDataList = details;
      isLoading.value = false;
      internetToastMessage();

    }
     statusCode = VisitConfirmByValidatorRepo.statusCode;
     statusMessage =VisitConfirmByValidatorRepo.statusMessage;



  }
}