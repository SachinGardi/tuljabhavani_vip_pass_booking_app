import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../baseUrl/base_url.dart';
import '../../internet_service/CheckInternetCon.dart';
import '../../modal/about_temple_modal/about_temple_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
List<AboutTempleModal> templeList = [];
class AboutTempleRepo {
  Uri uri = Uri.http(uatBaseUrl,
      "/api/AboutUs/GetAllAboutUs");
  getAboutTemple() async {
    try{
      Map temp = {};
      http.Response response = (await http.get(uri));
      if(response.statusCode == 200){
        temp = json.decode(response.body);
        final value = AboutTempleModal.fromJson(temp["responseData"]);
        templeList.add(value);
        if(temp["statusMessage"] == "AboutUsController-GetAllAboutUs : Completed GetAllAboutUs"){

        }
        return templeList;
      }

    }
     catch(e){
      if (kDebugMode) {
        print("Exception in Data $e");
      }
    }
  }
}