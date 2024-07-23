import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../baseUrl/base_url.dart';
import 'package:http/http.dart' as http;

class AddDevoteeDetailsRepo {



  static var headers = {
    'Content-Type': 'application/json',
  };
  static String? statusCode;
  static String? statusMessage;
  static postDevoteeDetailsRepo(
      int id,
      int devoteeId,
      int referById,
      String devoteeName,
      String mobileNo,
      String emailId,
      int amount,
      String gender,
      DateTime dateOfBirth,
      String aadharNo,
      String address,
      String imagePath,
      int createdBy,
      DateTime createdDate,
      bool isPaymentdone,
      String transactionId,
      String documentPath,
      String referanceName,
      BuildContext context) async {
    var data = jsonEncode({
      'id': id,
      'devoteeId': devoteeId,
      'referById': referById,
      'devoteeName': devoteeName,
      'mobileNo': mobileNo,
      'emailId': emailId,
      'amount': amount,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'aadharNo': aadharNo,
      'address': address,
      'imagePath': imagePath,
      'createdBy': createdBy,
      'createdDate': createdDate.toIso8601String(),
      'isPaymentdone': isPaymentdone,
      'transactionId': transactionId,
      'documentPath': documentPath,
      'referanceName':referanceName,
    });

    Uri url = Uri.http(
        uatBaseUrl, '/api/TuljapurEpassWebApi/ePassBooking/CreateDevoteeEpass');


    try {
      http.Response response = (await http.post(url, body: data, headers: headers));
      print(response.statusCode);
      print(data);
      if (response.statusCode == 200) {

        Map temp = jsonDecode(response.body);
        print(url);
        print(temp);
        statusCode = temp["statusCode"];
        statusMessage = temp["statusMessage"];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      debugPrintStack();
    }
  }
}