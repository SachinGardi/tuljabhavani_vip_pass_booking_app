import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../baseUrl/base_url.dart';
import '../../modal/trustee_modal/get_status_modal.dart';
import 'package:http/http.dart' as http;

class FilterStatusRepo {
  static List<GetFilterStatusModal> getStatusList = [];
  static var queryParameters;
  static getStatusData(int mode) async {
    queryParameters = {
      "Mode": "$mode",
    };

    Uri uri = Uri.http(uatBaseUrl,
        "/api/TuljapurEpassWebApi/CommonDropdown/GetAllStatusforBookingHistory",FilterStatusRepo.queryParameters);

    try {
      print(uri);
      http.Response response = await http.get(uri);
      if(response.statusCode == 200){
        print(response.body);
        Map temp = json.decode(response.body);
        temp['responseData'].forEach((v){
         getStatusList.add(GetFilterStatusModal(
           id: v["id"],
           status: v["status"],
         ));
        });
        return getStatusList;
      }
    }
    catch (e) {
      if (kDebugMode){
        print(kDebugMode);
      }
    }
  }
}