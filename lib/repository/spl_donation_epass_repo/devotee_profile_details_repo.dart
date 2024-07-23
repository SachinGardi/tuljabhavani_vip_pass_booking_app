import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:tulajapur/modal/spl_donation_epass_modal/devotee_profile_details.dart';

import '../../baseUrl/base_url.dart';
import 'package:http/http.dart' as http;

class DevoteeProfileDetailsRepo{
  static var queryParameters;
  static List<DevoteeProfileModal> devoteeDetailsList = [];

  static devoteeProfileDetails(String mobileNo)async{
    queryParameters ={
      "MobileNo":mobileNo,
    };
    try {
      Uri url = Uri.http(uatBaseUrl,
          'api/TuljapurEpassWebApi/UserRegistration/GetDevoteeProfile',
          DevoteeProfileDetailsRepo.queryParameters);
      print(url);
      http.Response response = ( await http.get(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map temp = json.decode(utf8.decode(response.bodyBytes));
        print("temp$temp");
        final value = DevoteeProfileModal.fromJson(temp['responseData']);
        devoteeDetailsList.add(value);
        return devoteeDetailsList;

      }
    }catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}