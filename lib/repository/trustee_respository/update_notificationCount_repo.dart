import 'dart:io';

import 'package:http/http.dart' as http;

import 'dart:convert';
import '../../baseUrl/base_url.dart';
import '../../modal/trustee_modal/update_notificationCount_modal.dart';

class UpdateNotificationCountRepo {
  static List<UpdateNotificationCountModal> getNotiFlagList =[];

static putNotiFlag(int recordId,int userId) async {
  var data = jsonEncode(
[
  {
  "id": recordId,
  "userId": userId
  }
]
  );
  Uri uri = Uri.http(uatBaseUrl,
  "/api/Notification/UpdateIsReadFlag");

   try {
     http.Response response = await http.put(uri,body: data,headers: {
       HttpHeaders.contentTypeHeader: 'application/json',
     });

    List temp = jsonDecode(response.body);
    print(temp);
    print(response.statusCode);
    if(response.statusCode == 200){
      print(response.body);
    }

  } catch (e){
    print(e);
  }
}
}