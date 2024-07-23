
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulajapur/view/validator_module/scan_pass/scanpass_view.dart';

import '../../baseUrl/base_url.dart';
import '../../internet_service/CheckInternetCon.dart';
import 'package:http/http.dart' as http;

import '../../internet_service/snackbar.dart';
import '../../view/common_widget/snack_bar.dart';

final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());

class VisitConfirmByValidatorRepo {
  static var queryParameters;
  static String? statusCode;
  static String? statusMessage;

  static var headers = {
    'Content-Type': 'application/json',
  };

  static updateValidatorVisit(String id, String devoteeId,String modifiedBy, BuildContext context) async {

    var data = jsonEncode({
      "id": id,
      "devoteeId": devoteeId,
      "modifiedBy": modifiedBy,
    });
    Uri url = Uri.http(uatBaseUrl,
        "/api/TuljapurEpassWebApi/ePassBooking/VisitConfirmByValidator");
    print(url);
    try {
      print(data);
      http.Response response =
      await http.post(url, body: data, headers: headers);
      if (response.statusCode == 200) {
        Map temp = json.decode(utf8.decode(response.bodyBytes));
        print(temp);
        statusCode = temp["statusCode"] ;
        statusMessage = temp["statusMessage"] ;

       /* if (temp["statusMessage"] == "Record confirmed successfully with Id $id.") {
          toastMessage(context, "Pass confirmed successfully",color: Colors.greenAccent);

          Get.offAllNamed("/scanPass");


        } else if (temp["statusMessage"] == "Error while Confirmed epass.") {
          toastMessage(context, "Error while Confirmed epass.");
        }*/
      }

    } catch (e) {
      if (kDebugMode) {
        print(e);
        internetToastMessage();
      }
    }
  }
}
