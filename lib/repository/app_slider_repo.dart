
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tulajapur/modal/notification_modal.dart';
import 'dart:convert';

import '../baseUrl/base_url.dart';
import '../internet_service/CheckInternetCon.dart';
import '../internet_service/snackbar.dart';
import '../modal/app_slider_modal.dart';
final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
List<AppSliderModal> imageList = [];



class AppSliderRepo {

  static var queryParameters;
 // static List<PageDetailsModal> pageDetails = [];
  static Map temp ={};
  static sliderInfo(String pageno,String pagesize ,String TextSearch,BuildContext context) async {
    queryParameters = {
      "pageno": pageno,
      "pagesize": pagesize,
      "TextSearch":TextSearch

    };

    Uri uri = Uri.http(uatBaseUrl,
        '/api/TuljapurEpassWebApi/AppSlider/GetAllAppSliders',AppSliderRepo.queryParameters);
    print(uri);

    try{
      Map temp = {};
      http.Response response = (await http.get(uri));
      if(response.statusCode == 200){
        print(uri);
        temp = json.decode(response.body);
        print(temp);
        temp['responseData'].forEach((v) {
          imageList.add(AppSliderModal(
            id: v["id"],
            imageName: v["imageName"],
            imagePath: v["imagePath"],
            status: v["status"],
            statusId: v["statusId"],
            createdBy: v["createdBy"],
            createdDate: v["createdDate"] == null ? null : DateTime.parse(v["createdDate"]),
          ));
        });
        return imageList;
      }
    } catch(e){
      print("Exception in Data $e");
    }
  }
}