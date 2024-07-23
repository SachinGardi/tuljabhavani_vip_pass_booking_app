import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/spl_donation_epass_repo/spl_epass_add_details_repo/delete_devotee_record.dart';




class DeleteDevoteeRecordVm extends GetxController{

  var isLoading = true.obs;
 String? statusCode;
 String? statusMessage;
  deleteDevoteeRecord(int recordId,
      int devoteeId,
      BuildContext context)async{
    await DeleteDevoteeRecordRepo.deleteDevoteeRecord(recordId, devoteeId,context);
    isLoading.value = false;
    statusCode = DeleteDevoteeRecordRepo.statusCode;
    statusMessage = DeleteDevoteeRecordRepo.statusMessage ;
  }

}