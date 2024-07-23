import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../baseUrl/base_url.dart';
import '../../../modal/spl_donation_epass_modal/spl_epass_booking/get_capacity_modal.dart';
import 'package:http/http.dart' as http;

class GetCapacityRepo {
  static List<GetCapacityModal> getCapacity = [];
  static var queryParameters;
  static String? statusCode;
  static String? statusMessage;
  static getCapacityByTime(String capacityDate,int timeSlot,int ePassId,double amount)async {
    queryParameters = {
      "Date": capacityDate,
      "TimeSlot": "$timeSlot",
      "ePassId": "$ePassId",
      "Amount": "$amount",
    };

    Uri uri = Uri.http(uatBaseUrl,"/api/Capacity/GetCapAmountValue",GetCapacityRepo.queryParameters);

    try {

      http.Response response = await http.get(uri);
      if(response.statusCode == 200){
        print(uri);
        print(response.body);
        Map temp = json.decode(response.body);
        statusCode = temp["statusCode"];
        statusMessage = temp["statusMessage"];
        temp['responseData'].forEach((v){
          getCapacity.add(GetCapacityModal(
            id: v["id"],
            effectivedate: v["effectivedate"] == null ? null : DateTime.parse(v["effectivedate"]),
            timeSlot: v["timeSlot"],
            total: v["total"],
            value: v["value"],
            ePassName: v["ePassName"],
          ));
        });
        return getCapacity;
      }
    }
    catch (e) {
      if (kDebugMode) {
        print(kDebugMode);
      }
    }
  }
}