import 'dart:convert';
import 'package:tulajapur/baseUrl/base_url.dart';
import '../../../modal/spl_donation_epass_modal/spl_epass_booking/get_amount_by_e-PassModal.dart';
import 'package:http/http.dart' as http;


class GetAmountByPassRepo {
  static List<GetPassAmountModal> getAmountByPass = [];
  static var queryParameters;
  static getAmountbyPassData(int id) async {
    queryParameters = {
      "Id" : "$id"
    };

    Uri uri = Uri.http(uatBaseUrl,"/api/TuljapurEpassWebApi/CommonDropdown/GetAmountByePass",GetAmountByPassRepo.queryParameters);
    try{
      http.Response response = await http.get(uri);
      print(uri);
      print(response.body);
      Map temp = json.decode(response.body);
      temp['responseData'].forEach((v){
        getAmountByPass.add(GetPassAmountModal(
          id: v["id"],
          amount: v["amount"].toDouble(),
        ));
      });
      return getAmountByPass;
    } catch(e){
      print(e);
    }
  }
}