import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulajapur/modal/notification_modal.dart';
import '../../repository/trustee_respository/notification_repo.dart';

int? notificationTotalPages;
int? notificationTotal;
class NotificationVM extends GetxController{
  List<NotificationModal>  notificationDetails=[];
  var isLoading =true.obs;
  getnotificationData(String pageno,String pageSize,String textSearch,String userId,String userTypeId,BuildContext context)async{
    var details = await NotificationRepo.notificationInfo(pageno, pageSize,textSearch,userId,userTypeId, context);
    print("======$details");
    if(details!= null){
      notificationDetails = details;
      print(notificationDetails.length);
      isLoading.value = false;
    }
    else if(details == null){
      Timer(const Duration(seconds:1),(){
        isLoading.value=false;
      });
    }

    notificationDetails.forEach((element) {
      element.pageDetailsList?.forEach((ele) {
        notificationTotalPages = ele.totalPages;
        notificationTotal = ele.pageCount;
      });

    });

  }
}