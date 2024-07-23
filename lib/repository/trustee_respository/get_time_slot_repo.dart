import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../baseUrl/base_url.dart';
import '../../modal/trustee_modal/get_time_slot_modal.dart';


class TimeSlotRepo {
  static List <GetTimeSlotModal> getTimeList = [];
  static var queryParameters;
  static getTimeSlotData(BuildContext context,String timeslot) async {
    queryParameters = {
      "VisitDate": timeslot,
      // "VisitDate": selectedDate.toString(),
    };

    Uri uri = Uri.http(uatBaseUrl,
        '/api/TuljapurEpassWebApi/ePassBooking/GetTimeSlotAgainstDate',
        TimeSlotRepo.queryParameters);

    try {
      print(uri);
      http.Response response = await http.get(uri);
      if (response.statusCode == 200){

        print(response.body);
        Map temp = json.decode(response.body);

        temp['responseData'].forEach((v){
          getTimeList.add(GetTimeSlotModal(
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