import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../internet_service/CheckInternetCon.dart';
import '../baseUrl/base_url.dart';
import '../internet_service/snackbar.dart';


final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
class LogoutRepo {
  static Map temp ={};
  static String? statusCode ;
  static String? statusMessage ;
  static logoutUser(String appId,String userId,String userTypeId,BuildContext context) async {
    var data = jsonEncode({
        "appId":appId,
        "userId":userId,
        "userTypeId":userTypeId});
    final uri = Uri.http(uatBaseUrl,
        '/api/TuljapurEpassWebApi/Logout/LogOut');
    try {
      var request = await http.put(uri,body: data, headers: <String, String>{
        'Content-Type': 'application/json',
      });
      Map temp = json.decode(utf8.decode(request.bodyBytes));
      if (request.statusCode == 200) {
        statusMessage = temp["statusMessage"];
        statusCode = temp["statusCode"];
      }
    }catch (e) {
      if (kDebugMode) {
        internetToastMessage();
      }

    }
  }
}
