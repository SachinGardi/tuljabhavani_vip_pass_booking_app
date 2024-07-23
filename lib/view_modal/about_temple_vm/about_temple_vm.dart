import 'dart:async';

import 'package:get/get.dart';

import '../../modal/about_temple_modal/about_temple_modal.dart';
import '../../repository/about_temple_repo/about_temple_repo.dart';

String? imagePathTemple;
String? headingTemple;
String? descriptionTemple;
AboutTempleRepo aboutTempleRepo =AboutTempleRepo();
class AbouttempleVM extends GetxController{
  List<AboutTempleModal> templeList=[];
  var isLoading = true.obs;

  getTempleInfo() async {
    var templeInformation = await aboutTempleRepo.getAboutTemple();
    print("--$templeInformation");
    if(templeInformation != null){
      templeList = templeInformation;
      isLoading.value = false;
    }
    if(templeInformation == null){
    Timer(Duration(seconds: 1), () {
      isLoading.value = false;
    });

    }
    templeList.forEach((element) {
      imagePathTemple = element.imagePath;
      headingTemple = element.heading;
      descriptionTemple = element.description;
    });
  }
}