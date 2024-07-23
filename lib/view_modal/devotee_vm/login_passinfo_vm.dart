import 'dart:async';

import 'package:get/get.dart';

import '../../modal/devotee/login_passinfo_modal.dart';
import '../../repository/devotee/login_passinfo_repo.dart';


String? header;
String? instructionss;
String? marathiInstructions;
String? ePasstitle;
String? leftImagePath1;
String? rightImagePath;


class DevoteeLoginInstruction extends GetxController {
  List<EPassInformationModal> devoteeInstructionList =[];
  var isLoading = true.obs;

  getInstruction() async {
    var data = await EpassInformationRepo.getEpassInstruction();
    print("data $data");
    if(data != null){
      devoteeInstructionList = data;
      isLoading.value = false;
    }
    else{
    Timer(Duration(seconds: 1), () {
      isLoading.value = false;
    });

    }
    devoteeInstructionList.forEach((element) {
      header= element.headerName;
      instructionss = element.information;
      ePasstitle = element.ePassTitle;
      leftImagePath1 = element.leftImagePath;
      rightImagePath = element.rightImagePath;
      marathiInstructions = element.information_M;
    });
    print("header${devoteeInstructionList.first.information_M}");
  }
}


