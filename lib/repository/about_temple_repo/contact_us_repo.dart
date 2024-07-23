import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../baseUrl/base_url.dart';
import '../../internet_service/CheckInternetCon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../modal/about_temple_modal/contact_us.dart';
final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
List<ContactUsModal> contactDetails = [];

class TempleContactUs {


  static getContactDetails() async {
    Uri uri = Uri.http(uatBaseUrl,
        "/api/TuljapurEpassWebApi/TempleProfile/GetTempleProfile");
    try{
      Map temp = {};
        http.Response response = (await http.get(uri));
        if(response.statusCode == 200){
          temp = json.decode(response.body);
          final value = ContactUsModal.fromJson(temp["responseData"]);
          contactDetails.add(value);
          if(temp["statusMessage"] == "EPassSettingController-GetTempleProfile : Completed GetTempleProfile"){

          }
          return contactDetails;
        }


    } catch(e){
      if (kDebugMode) {
        print("Exception in Data $e");
      }
    }
  }
}