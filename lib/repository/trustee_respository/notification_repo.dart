

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tulajapur/modal/notification_modal.dart';
import 'dart:convert';

import '../../baseUrl/base_url.dart';
import '../../internet_service/CheckInternetCon.dart';
import '../../internet_service/snackbar.dart';
final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
List<NotificationModal> notificationList = [];



class NotificationRepo {

  static var queryParameters;
  static List<PageDetailsModal> pageDetails = [];
  static Map temp ={};
  static notificationInfo(String pageno,String pagesize ,String textSearch,String userId,String userTypeId,BuildContext context) async {
    queryParameters = {
      "pageno": pageno,
      "pagesize": pagesize,
      "TextSearch":textSearch,
      "userId":userId,
      "userTypeId":userTypeId
    };

  Uri uri = Uri.http(uatBaseUrl,
      '/api/Notification/GetAllNotification',NotificationRepo.queryParameters);
  print(uri);

  try{
        print(uri);
        Map temp = {};
        http.Response response = (await http.get(uri));
        if(response.statusCode == 200){
          print(uri);
          temp = json.decode(response.body);
          // print(temp);

          final value = PageDetailsModal.fromJson(temp['responseData']['responseData2']);
          pageDetails.add(value);
          temp['responseData']['responseData1'].forEach((v) {
            notificationList.add(NotificationModal(
              id: v["id"],
              userId: v["userId"],
              srNo: v["srNo"],
              title: v["title"],
              ePass: v["ePass"],
              reason: v["reason"],
              addedDate: v["addedDate"] == null ? null : DateTime.parse(v["addedDate"]),
              fromDate: v["fromDate"] == null ? null : DateTime.parse(v["fromDate"]),
              toDate: v["toDate"] == null ? null : DateTime.parse(v["toDate"]),
              statusId: v["statusId"],
              status: v["status"],
              createdBy: v["createdBy"],
              msgId: v["msgId"],
              pageDetailsList:pageDetails,
              createdDate: v["createdDate"] == null ? null : DateTime.parse(v["createdDate"]),
            ));
          });
          return notificationList;
      }
    } catch(e){
      print("Exception in Data $e");
    }
  }
}