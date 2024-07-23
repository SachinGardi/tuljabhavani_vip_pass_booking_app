import 'package:get/get.dart';
import '../../modal/trustee_modal/update_notificationCount_modal.dart';
import '../../repository/trustee_respository/update_notificationCount_repo.dart';




class NotificationFlagCountVm extends GetxController {
  List<UpdateNotificationCountModal> flagCountData = [];

  var isLoading = true.obs;

  putNotificationFlag(int recordId,int userId) async {
   var putCount = await UpdateNotificationCountRepo.putNotiFlag(recordId,userId);
   // print(putCount);
    if(putCount != null){
      flagCountData = putCount;
      isLoading.value = false;
    }
    
  }
}