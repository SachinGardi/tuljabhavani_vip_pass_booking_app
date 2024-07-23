import 'dart:convert';
import 'package:flutter/material.dart';
import '../../baseUrl/base_url.dart';
import '../../modal/trustee_modal/delete_notification_modal.dart';
import 'package:http/http.dart' as http;


class DeleteNotificationRepo {
  static var headers = {
    'Content-Type': 'application/json',
  };
  List<DeleteNotificationModal> deleteNoti =[];

  static deleteNotification(int recordId,int trusteeId,BuildContext context) async {
   var data = jsonEncode({
     "notificationdeletes": [
       {
         "id": recordId,
         "deletedBy": trusteeId
       }
     ]
   });
    Uri uri = Uri.http(uatBaseUrl,
    "/api/Notification/DeleteNotification");
    try{
      http.Response response = (await http.delete(uri,body: data,headers: headers));

      if(response.statusCode == 200){
        print(response.body);
        // toastMessage(context, "notificationDelete".tr);
      }
    }catch(e){
      print(e);
    }
  }
}