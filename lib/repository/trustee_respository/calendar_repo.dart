import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;

import '../../baseUrl/base_url.dart';
import '../../modal/trustee_modal/calendar_modal.dart';

class CalendarRepo {
static List<Calendarmodal> calendarStatusList = [];
static var queryParameters;

  static getCalendarStatus(int ePassID) async {
    queryParameters = {
      "ePassId": "$ePassID"
    };

    Uri uri = Uri.http(uatBaseUrl,
        "/api/TuljapurEpassWebApi/ePassBooking/GetVisitDateCalender",CalendarRepo.queryParameters);
    try {
      http.Response response = (await http.get(uri));
      if(response.statusCode == 200){
        print(uri);
        Map calendarData = jsonDecode(response.body);
        print(calendarData);
        calendarData['responseData'].forEach((v){
         calendarStatusList.add(Calendarmodal(
           srNo: v["srNo"],
           date: v["date"] == null ? null : DateTime.parse(v["date"]),
           status: v["status"],
         ));
        });
        return calendarStatusList;
      }
    } catch(e){
      print(e);
    }
    debugPrintStack();
  }
}