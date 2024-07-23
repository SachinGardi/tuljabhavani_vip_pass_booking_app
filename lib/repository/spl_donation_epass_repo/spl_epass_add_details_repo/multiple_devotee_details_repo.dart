
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../baseUrl/base_url.dart';
import '../../../modal/spl_donation_epass_modal/spl_epass_add_details_modal/multiple_devotee_deatils_modal.dart';

class MultipleDevoteeDetailsRepo{
  static List<MultipleDevoteeDetailsModal> devoteeDetailsList= [];
  static getAllDevoteeDetails(String mobileNo)async{
    var queryParam = {
      'MobileNo':mobileNo,

    };
    Uri url = Uri.http(uatBaseUrl,'api/TuljapurEpassWebApi/ePassBooking/GetPassgeneratedByDevoteeForApp',queryParam);
    try{
      http.Response response = (await http.get(url));

      print(response.statusCode);
      if(response.statusCode == 200){

        Map res = jsonDecode(response.body);

        print("res$res");
        res['responseData']['responseData1'].forEach((data){
          devoteeDetailsList.add(MultipleDevoteeDetailsModal(
              id: data['id'],
              devoteeId: data['devoteeId'],
              devoteeName: data['devoteeName'],
              mobileNo: data['mobileNo'],
              emailId: data['emailId'],
              gender: data['gender'],
              dateOfBirth: data['dateOfBirth'],
              age: data['age'],
              address: data['address'],
              aadharNo: data['aadharNo'],
              referById: data['referById'],
              referBy: data['referBy'],
              visitDate: data['visitDate'],
              visitTime: data['visitTime'],
              donation: data['donation'],
              barcodeText: data['barcodeText'],
              statusId: data['statusId'],
              status: data['status'],
              imagePath: data['imagePath'],
              createdBy: data['createdBy'],
              createdDate: data['createdDate'],
              ePassName: data['ePassName'],
              scanDate: data['scanDate'],
              validatorName: data['validatorName'],
              rejectedRemark: data['rejectedRemark'],
              documentPath: data['documentPath']??'',
              referanceName: data["referanceName"]??''
          ));
        });
        return devoteeDetailsList;

      }
    }catch(e){
      if(kDebugMode){
        print(e);
      }
      debugPrintStack();
    }
  }


}