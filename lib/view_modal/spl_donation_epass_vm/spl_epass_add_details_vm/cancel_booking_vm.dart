import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/spl_donation_epass_repo/spl_epass_add_details_repo/cancel_booking_repo.dart';





class CancelSplePassBookingVM extends GetxController{
  var isLoading = true.obs;
  String? statusCode;
  String? statusMessage;
  cancelBookingRecord(
      int devoteeId,
      BuildContext context)async{
    await CancelSplePassBookingRepo.cancelBooking( devoteeId,context);
    isLoading.value = false;
    statusCode = CancelSplePassBookingRepo.statusCode;
    statusMessage = CancelSplePassBookingRepo.statusMessage ;
  }

}