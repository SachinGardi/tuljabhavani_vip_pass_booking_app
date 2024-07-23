import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../baseUrl/base_url.dart';
import '../../../modal/spl_donation_epass_modal/spl_donation_epass_payable_deatils_modal/spl_epass_payable_details_modal.dart';


class SplePassPayableDetailsRepo{
  static List<SplePassPayableDetailsModal> paymentDetailsList = [];
  static var queryParameters;


  static getDevoteePayableDetail(int devoteeId)async{
    queryParameters = {
      'DevoteeId':'$devoteeId'
    };
    Uri url = Uri.http(uatBaseUrl,'/api/TuljapurEpassWebApi/ePassBooking/GetDevoteePayableDetails',SplePassPayableDetailsRepo.queryParameters);
    try{
      http.Response response = (await http.get(url));
      if(response.statusCode == 200){
        print(url);
        Map temp = json.decode(response.body);
        final value = SplePassPayableDetailsModal.fromJson(temp['responseData']);
        paymentDetailsList.add(value);
        return paymentDetailsList;
      }
    }
    catch(e){
      if(kDebugMode){
        print(e);
      }
    }
  }



}