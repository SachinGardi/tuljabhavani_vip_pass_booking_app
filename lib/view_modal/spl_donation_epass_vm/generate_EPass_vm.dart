





import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulajapur/view/non_referral_pass/spl_donation_epass_booking/e-pass_booking.dart';
import '../../modal/spl_donation_epass_modal/spl_epass_booking/generate_ePass_modal.dart';
import '../../repository/spl_donation_epass_repo/spl_epass_booking/generate_Epass_repo.dart';




class GenerateSpecialPassVM extends GetxController {
  var isLoading = true.obs;
  String? statusCode;
   String? statusMessage;
   int? devoteeId;
   specialPassGenerateLink(
      int       createdBy,
      int        modifiedBy,
      DateTime   createdDate,
      DateTime    modifiedDate,
      bool        isDeleted,
      int           id,
      int           referrelId,
      String        mobileNo,
      int           noOfTotalDevotee,
      DateTime      visitDate,
      int         timeSlot,
      int          totalAmount,
      bool         isCall,
      int             ePassId,
      List<GenerateBookingDetail> bookingDetails,
      BuildContext context
      ) async {
    await GenerateEPassLinkRepo.postGeneratePassData(
      createdBy,
      modifiedBy,
      createdDate,
      modifiedDate,
      isDeleted,
      id,
      referrelId,
      mobileNo,
      noOfTotalDevotee,
      visitDate,
      timeSlot,
      totalAmount,
      isCall,
      ePassId,
      bookingDetails,
      context,
    );
    isLoading.value = false;

    statusCode = GenerateEPassLinkRepo.statusCode;
    statusMessage = GenerateEPassLinkRepo.statusMessage ;
    devoteeId = GenerateEPassLinkRepo.devoteeId ;


  }
}