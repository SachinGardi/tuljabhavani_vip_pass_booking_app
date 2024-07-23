import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../baseUrl/base_url.dart';
import 'package:http/http.dart' as http;

class DevoteePaymentInfo {
  static String? paymentResponse;
  static String? statusCode;
  static String? statusMessage;

  static postPaymentData(
      String? createdBy,
      String? modifiedBy,
      DateTime? createdDate,
      DateTime? modifiedDate,
      bool? isDeleted,
      String? devoteeId,
      String? toatlPayable,
      DateTime? date,
      String? timeSlot,
      String? ePassId,
      String? amount,
      BuildContext context) async {
    var data = jsonEncode({
      "createdBy": createdBy,
      "modifiedBy": modifiedBy,
      "createdDate": createdDate!.toIso8601String(),
      "modifiedDate": modifiedDate!.toIso8601String(),
      "isDeleted": isDeleted,
      "devoteeId": devoteeId,
      "toatlPayable": toatlPayable,
      "date": date!.toIso8601String(),
      "timeSlot": timeSlot,
      "ePassId": ePassId,
      "amount": amount,
      "lan": "English"
    });
    print(data);
    try {
      print(data);
      Uri url = Uri.http(
          uatBaseUrl, '/api/TuljapurEpassWebApi/SBIPayment/AddPaymentrequest');
      http.Response response = (await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      }));

      print('payment_res${response.statusCode}');

      if (response.statusCode == 200) {
        Map temp = json.decode(utf8.decode(response.bodyBytes));
        print(temp);
        paymentResponse = temp['responseData'];
        statusCode = temp['statusCode'];
        statusMessage = temp['statusMessage'];
      }
      else{
        statusCode = response.statusCode.toString();
      }
    } catch (e) {
      if (kDebugMode) {
        print('payment_error$e');
        print(e);
      }
    }
  }
}
