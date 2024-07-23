import 'dart:async';
import 'package:get/get.dart';
import '../../modal/trustee_modal/notification_forAll_modal.dart';
import '../../repository/trustee_respository/notification_ForAll_Repo.dart';


NotificationForAllRepo notificationForAllRepo = NotificationForAllRepo();

class NotificationForAllVm extends GetxController{
  List<NotificationForAllModal> notiAllList=[];
  List<NotificationForAllPageModal> notiAllListPage=[];
  var isLoading = true.obs;
  getAllNotification(String pageNo, String pageSize) async{
    var details = await notificationForAllRepo.allNotificationInfo(pageNo,pageSize);
    if(details != null){
      notiAllList = details;
      isLoading.value = false;
    }
    if(details == null){
      Timer(const Duration(seconds: 1),(){
        isLoading.value = false;
      });
    }
  }
}