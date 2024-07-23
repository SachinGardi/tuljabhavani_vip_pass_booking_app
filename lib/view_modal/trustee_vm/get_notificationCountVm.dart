import 'package:get/get.dart';
import '../../modal/trustee_modal/get_notificationCount_modal.dart';
import '../../repository/trustee_respository/get_notificationCount_repo.dart';

int notificationCount = 0;
class GetNotificationCountVM extends GetxController {
  List <GetNotificationCountModal> notificationCountList = [];
  var isLoading = true.obs;
  getNotificationCount(String userId) async {
    var getNotificationCountDetail = await NotificationCountRepo.getCountData(userId);
    if(getNotificationCountDetail != null){
      notificationCountList = getNotificationCountDetail;
      isLoading.value = false;
    }
    else if(getNotificationCountDetail == null){
      isLoading.value = false;

    }
    notificationCountList.forEach((element) {
      notificationCount = element.isReadcount!;
      print(notificationCount);
    });
    print(notificationCountList);
  }
}