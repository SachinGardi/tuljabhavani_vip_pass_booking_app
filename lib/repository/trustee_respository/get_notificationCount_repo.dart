import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../baseUrl/base_url.dart';
import '../../modal/trustee_modal/get_notificationCount_modal.dart';
import 'package:http/http.dart' as http;

class NotificationCountRepo {
  static List<GetNotificationCountModal> getCountList = [];
  static var queryParameters;
  static getCountData(String userId) async {
    queryParameters = {
      "UserId": userId,
    };
    Uri uri = Uri.http(uatBaseUrl,
      "/api/Notification/GetNotificationCountByUserId",NotificationCountRepo.queryParameters);

    try{
      http.Response response = await http.get(uri);
      if(response.statusCode == 200){
        print(uri);
        Map temp = jsonDecode(response.body);
        print(temp);
        temp['responseData'].forEach((v){
          getCountList.add(GetNotificationCountModal(
          userId: v["userId"],
          isReadcount: v["isReadcount"],
          ));
        });
        return getCountList;
      }
    } catch (e){
      if (kDebugMode) {
        print(kDebugMode);
      }
    }
  }
}