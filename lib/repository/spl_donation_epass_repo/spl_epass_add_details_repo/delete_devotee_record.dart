import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../baseUrl/base_url.dart';



class DeleteDevoteeRecordRepo {
  static var headers = {
    'Content-Type': 'application/json',
  };

  static String? statusCode;
  static String? statusMessage;
  static deleteDevoteeRecord(int recordId, int devoteeId,BuildContext context) async {
    var data = jsonEncode({'id': recordId,
      'modifiedBy': devoteeId});
    Uri url = Uri.http(uatBaseUrl,'/api/TuljapurEpassWebApi/ePassBooking/deleteDevoteeDetails');
    try{
      http.Response response = (await http.delete(url,body: data,headers: headers));
      if(response.statusCode == 200){
        print(response.body);
        Map temp = jsonDecode(response.body);
        statusMessage = temp['statusMessage'];
        statusCode = temp['statusCode'];
      }
    }catch(e){
      if(kDebugMode){
        print(e);
      }
      debugPrintStack();
    }
  }
}
