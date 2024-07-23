import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../baseUrl/base_url.dart';

class CancelSplePassBookingRepo {
  static String? statusCode;
  static String? statusMessage;
  static cancelBooking(int devoteeId,BuildContext context)async{
    var queryParams = {
      'Id':'$devoteeId'
    };
    Uri url = Uri.http(uatBaseUrl,'/api/TuljapurEpassWebApi/ePassBooking/DeleteDevoteeInfo',queryParams);
    http.Response response = (await http.delete(url));
      if(response.statusCode == 200){
        print(response.body);
        Map temp = jsonDecode(response.body);
        statusMessage = temp['statusMessage'];
        statusCode = temp['statusCode'];
      }
  }

}