// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import '../../baseUrl/base_url.dart';
// import '../../modal/devotee/link_status_modal.dart';
// import 'package:http/http.dart' as http;
// import '../../modal/devotee/post_otp_modal.dart';
// import '../../view/common_widget/snack_bar.dart';
// import '../../view/devotee_login/devotee_pass_login.dart';
// import '../../view/devotee_login/devotee_widgets.dart';
//
// class LinkStatusRepo{
//
//   static LinkCheckModal linkStatus = LinkCheckModal();
//
//  static getLinkStatus(String mobileNo,BuildContext context)async{
//    var queryParams = {
//      'MobileNo':mobileNo
//    };
//    Uri url = Uri.http(uatBaseUrl,'/api/TuljapurEpassWebApi/ePassBooking/CheckExpiredFlagForApp',queryParams);
//    try{
//      http.Response response = (await http.get(url));
//      if(response.statusCode == 200){
//        linkStatus.isExpired = null;
//        print(response.body);
//        Map res = jsonDecode(response.body);
//        if(res['responseData'] != null){
//          var data = LinkCheckModal.fromJson(res['responseData']);
//          linkStatus = data;
//          return linkStatus;
//        }
//        else if(res['statusMessage'] == 'MobileNo is not available.'){
//          isPressed1.value = false;
//          toastMessage(context, 'Please enter registered mobile no!',color: Colors.red);
//        }
//        else if(res['statusMessage'] == 'Conversion failed when converting date and/or time from character string.'){
//          isPressed1.value = false;
//          toastMessage(context, 'Conversion failed when converting date and/or time from character string.',color: Colors.red);
//        }
//
//      }
//
//
//    }catch(e){
//      if(kDebugMode){
//        print(e);
//      }
//      debugPrintStack();
//    }
//  }
//
// }