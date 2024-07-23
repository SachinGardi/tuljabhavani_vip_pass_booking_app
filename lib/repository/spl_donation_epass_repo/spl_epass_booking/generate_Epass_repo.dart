import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import '../../../baseUrl/base_url.dart';
import '../../../modal/spl_donation_epass_modal/spl_epass_booking/generate_ePass_modal.dart';


class GenerateEPassLinkRepo {
  static List<GenerateEPassLinkModal> generateLink = [];
  static String? statusCode;
  static String? statusMessage;
  static int? devoteeId;
  static postGeneratePassData(
      int createdBy,
      int modifiedBy,
      DateTime createdDate,
      DateTime modifiedDate,
      bool isDeleted,
      int id,
      int referrelId,
      String mobileNo,
      int noOfTotalDevotee,
      DateTime visitDate,
      int timeSlot,
      int totalAmount,
      bool isCall,
      int ePassId,
      List<GenerateBookingDetail> bookingDetails,
      BuildContext context
      ) async {
    Uri uri = Uri.http(uatBaseUrl,
        "/api/TuljapurEpassWebApi/ePassBooking/GenerateEpassLink");

    var data = jsonEncode({
      "createdBy": createdBy,
      "modifiedBy": modifiedBy,
      "createdDate": createdDate.toIso8601String(),
      "modifiedDate": modifiedDate.toIso8601String(),
      "isDeleted": isDeleted,
      "id": id,
      "referrelId":referrelId,
      "mobileNo": mobileNo,
      "noOfTotalDevotee": noOfTotalDevotee,
      "visitDate": visitDate.toIso8601String(),
      "timeSlot": timeSlot,
      "totalAmount":totalAmount,
      "isCall":isCall,
      "ePassId":ePassId,
      "bookingDetails": bookingDetails,

    });
    try {
      print(uri);
      print("--$data");

      var request = await http.post(uri,
          body: data,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
      print(request.statusCode);
      Map temp = jsonDecode(utf8.decode(request.bodyBytes));
      print("--$temp");
      if (request.statusCode == 200) {
        statusMessage = temp['statusMessage'];
        statusCode = temp['statusCode'];
        devoteeId = temp['responseData'];

        // print(request.statusCode);
        // if(temp["statusMessage"].toString().contains("ePass generated successfully")) {
        //   toastMessage(context, "toastPassSuccess".tr, color: Colors.greenAccent);
        // }
        // else if(temp["statusMessage"].toString().contains(
        //     "Record is not added as there is already a record with same devotee")) {
        //   toastMessage(context, "toastRecordExist".tr,color: Colors.redAccent);
        // }
        // else if(temp["statusMessage"].toString().contains(
        //     "Quota not available for one of the pass")) {
        //   toastMessage(context, "toastNoQuota".tr,color: Colors.redAccent);
        // }
        // else if(temp["statusMessage"] == 'User not allow to generate ePass against past time.'){
        //   toastMessage(context, "pastTimeSlotSnackBarMsg".tr,color: Colors.redAccent);
        // }
        // else if(temp["statusMessage"] == 'Quota not available against trustee or record already exists for devotee mobile no.'){
        //   toastMessage(context, "quotaNotAvailableMsg".tr,color: Colors.redAccent);
        // }
        // else if(temp["statusMessage"] == 'Quota/Capacity not available against trustee or record already exists for devotee mobile no.'){
        //   toastMessage(context, "capacityExceedMsg".tr,color: Colors.redAccent);
        // }

      }
    } catch (e){
      print(e);
    }
  }
}
