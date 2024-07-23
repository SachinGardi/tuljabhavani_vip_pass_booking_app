import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../baseUrl/base_url.dart';
import '../../modal/paymentResponseModal.dart';




class PaymentResponseRepo {
  static List <PaymentResponseModal> paymentDetailsList = [];
  static var queryParameters;
  static getPaymentResponseData(String id) async {
    queryParameters = {
      "Id": id,
    };
    Uri uri = Uri.http(uatBaseUrl,
        '/api/TuljapurEpassWebApi/SBIPaymentResponse/GetPayMentResponse',PaymentResponseRepo.queryParameters);
    try {
      print(uri);
      http.Response response = await http.get(uri);
      if (response.statusCode == 200){
        Map temp = json.decode(response.body);
        print("temp$temp");
        final value = PaymentResponseModal.fromJson(temp['responseData']);
        paymentDetailsList.add(value);
        return paymentDetailsList;
      }

    }
    catch (e) {
      if (kDebugMode) {
        print(kDebugMode);
      }
    }
  }
}

