import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../baseUrl/base_url.dart';
import 'package:http/http.dart' as http;
import '../../../modal/spl_donation_epass_modal/spl_epass_add_details_modal/visitdate_time_details_modal.dart';

class VisitTimeAndDateDetailsRepo{


  static List<VisitDateAndTimeDetailsModal> visitDateAndTimeInfo = [];

  static getVisitDateAndTimeInfo(String mobileNo)async{

    var queryParams = {
      'MobileNo':mobileNo
    };

    Uri url = Uri.http(uatBaseUrl,'api/TuljapurEpassWebApi/ePassBooking/GetDevotteInfoForApp',queryParams);

    try{
      http.Response response = (await http.get(url));
      if(response.statusCode == 200){

        Map temp = jsonDecode(response.body);
        print(temp);
        temp['responseData'].forEach((v){
          visitDateAndTimeInfo.add(VisitDateAndTimeDetailsModal(
            id: v["id"],
            devoteeName: v["devoteeName"],
            emailId: v["emailId"],
            mobileNo: v["mobileNo"],
            totalAmount: v["totalAmount"],
            transactionId: v["transactionId"],
            referById: v["referById"],
            referBy: v["referBy"],
            noOfTotalDevotee: v["noOfTotalDevotee"],
            isExpired: v["isExpired"],
            statusId: v["statusId"],
            status: v["status"],
            visitDate: v["visitDate"] == null ? null : DateTime.parse(v["visitDate"]),
            visitTime: v["visitTime"],
            rejecteId: v["rejecteId"],
            rejectedRemark: v["rejectedRemark"],
            userTypeId: v["userTypeId"],
            isQuotaavailable: v["isQuotaavailable"],
          ));
        });

        return visitDateAndTimeInfo;
      }
    }catch(e){
      if(kDebugMode){
        print(e);
      }
      debugPrintStack();
    }

  }

}