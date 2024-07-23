import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../baseUrl/base_url.dart';
import '../../modal/booking_history_modal/time_slot_filter_modal.dart';




class TimeSlotFilterRepo {
  static List <GetTimeSlotFilterModal> getTimeList = [];
  static getTimeSlotFilterData() async {


    Uri uri = Uri.http(uatBaseUrl,
        '/api/TuljapurEpassWebApi/CommonDropdown/GetTimseSlots');

    try {
      print(uri);
      http.Response response = await http.get(uri);
      if (response.statusCode == 200){
        print(response.body);
        Map temp = json.decode(response.body);
        temp['responseData'].forEach((v){
          getTimeList.add(GetTimeSlotFilterModal(
            id: v["id"],
            timeSlot: v["timeSlot"],
          ));
        });
        return getTimeList;
      }
    }
    catch (e) {
      if (kDebugMode) {
        print(kDebugMode);
      }
    }
  }
}

