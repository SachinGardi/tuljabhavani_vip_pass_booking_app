import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../baseUrl/base_url.dart';
import 'package:http/http.dart' as http;

class CheckDevoteeRegistration{
  static var queryParameters;
  static int? isRegister ;
  static checkRegistration(String MobileNo)async{
    queryParameters ={
      "MobileNo":MobileNo,
    };
    try {
      Uri url = Uri.http(uatBaseUrl,
          'api/TuljapurEpassWebApi/UserRegistration/CheckDevoteeRegistration',
          CheckDevoteeRegistration.queryParameters);
      print(url);
      http.Response response = ( await http.get(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map temp = json.decode(utf8.decode(response.bodyBytes));
        print("temp$temp");
        temp['responseData'].forEach((key,value){
           isRegister = value;
           print(isRegister);
        });
      }
    }catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}