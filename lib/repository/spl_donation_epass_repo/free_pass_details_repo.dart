import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../baseUrl/base_url.dart';


class FreePassDetailsRepo{

  static var queryParameters;
  static String? statusCode;


  static freePassDetails(int devoteeId)async{
    queryParameters = {
      'DevoteeId':'$devoteeId'
    };
    Uri url = Uri.http(uatBaseUrl,'/api/TuljapurEpassWebApi/ePassBooking/GetPassgenerated',FreePassDetailsRepo.queryParameters);
    try{
      http.Response response = (await http.get(url));
      if(response.statusCode == 200){
        print(url);
        Map temp = json.decode(response.body);
        statusCode = temp['statusCode'];
        String statusMessage = temp['statusMessage'];
        print(statusCode);
        print(statusMessage);
      }
    }
    catch(e){
      if(kDebugMode){
        print(e);
      }
    }
  }



}