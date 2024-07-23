import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../baseUrl/base_url.dart';
import '../../internet_service/CheckInternetCon.dart';
import '../../modal/devotee/login_passinfo_modal.dart';

final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
List<EPassInformationModal> informationList = [];
class EpassInformationRepo {
  static getEpassInstruction() async{
   Uri uri = Uri.http(uatBaseUrl, "/api/TuljapurEpassWebApi/EPassSettings/GetEPassSetting");
   print(uri);
    try{
      http.Response response = (await http.get(uri));
      if(response.statusCode == 200){
        Map temp= json.decode(response.body);
        print(temp);
        final value = EPassInformationModal.fromJson(temp["responseData"]);
        informationList.add(value);
        return informationList;
      }
     }catch(e){
       print('Exception in Data $e');
     }
  }
}
