import 'dart:convert';
import 'package:tulajapur/baseUrl/base_url.dart';
import '../../../modal/spl_donation_epass_modal/spl_epass_booking/get_ePass_modal.dart';
import 'package:http/http.dart' as http;


class GetEPassRepo {
  static List <GetEPassModal> getEPass = [];
  static var queryParameters;
  static getEPassData(int ePassType) async {
      queryParameters = {
        "epassType" : "$ePassType",
      };

      Uri uri = Uri.http(uatBaseUrl,"/api/TuljapurEpassWebApi/CommonDropdown/GetAllEPassByTypeForBooking",GetEPassRepo.queryParameters);
      try{
        http.Response response = await http.get(uri);
        print(uri);
        print(response.body);
        Map temp = json.decode(response.body);
        temp['responseData'].forEach((v){
          getEPass.add(GetEPassModal(
            id: v["id"],
            ePassName: v["ePassName"],
          ));
        });
        return getEPass;
      } catch(e){
        print(e);
      }
  }
}