import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../modal/trustee_modal/delete_notification_modal.dart';
import '../../repository/trustee_respository/delete_notification_repo.dart';


class DeleteNotificationVm extends GetxController{
  List <DeleteNotificationModal> notiDeleteLists = [];
  var isLoading = true.obs;


  deleteNotification(DeleteNotificationModal DeleteNotificationModal, int recordId,int trusteeId,BuildContext context) async {
    var deleteNotification = await DeleteNotificationRepo.deleteNotification(recordId,trusteeId,context);
    print(deleteNotification);
    if(deleteNotification != null){
      notiDeleteLists = deleteNotification;
      isLoading.value = false;
    }
    else{
      Timer(Duration(seconds: 1), () {
        isLoading.value = false;
      });
    }

  }
}