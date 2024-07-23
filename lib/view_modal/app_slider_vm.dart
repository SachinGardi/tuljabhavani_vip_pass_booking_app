import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tulajapur/internet_service/snackbar.dart';
import 'package:tulajapur/modal/notification_modal.dart';
import '../modal/app_slider_modal.dart';
import '../repository/app_slider_repo.dart';
import '../repository/trustee_respository/notification_repo.dart';

int? totalPages;
class AppSliderVM extends GetxController{
  List<AppSliderModal>  imageDetails=[];
  List<String>  sliderImagePath=[];
  var isLoading =true.obs;
  appSliderData(String pageno,String pageSize,String TextSearch,BuildContext context)async{
    var details =await AppSliderRepo.sliderInfo(pageno, pageSize,TextSearch, context);
    print("======$details");
    if(details!= null){
      imageDetails = details;
      print("======${imageDetails.length}");
      isLoading.value = false;
    }
   else if(details == null){
      Timer(Duration(seconds: 1),(){
        isLoading.value=false;
        //internetToastMessage();
      });
    }

    imageDetails.forEach((element) {
      sliderImagePath.add(element.imagePath!);
    });
  }
}