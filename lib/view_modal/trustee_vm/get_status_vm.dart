

import 'package:get/get.dart';

import '../../modal/trustee_modal/get_status_modal.dart';
import '../../repository/trustee_respository/get_status_repo.dart';

int? Filterid;
String? FilterStatus;
class GetStatusVM extends GetxController {
  List <GetFilterStatusModal> filterStatusList = [];
  var isLoading = true.obs;

  getallStatus(int mode) async {
    var getStatusDetails = await FilterStatusRepo.getStatusData(mode);
    print(getStatusDetails);
    if(getStatusDetails != null){
      filterStatusList = getStatusDetails;
      isLoading.value = false;
    }
    filterStatusList.forEach((element) {
      Filterid = element.id;
      FilterStatus = element.status;
    });
  }
}