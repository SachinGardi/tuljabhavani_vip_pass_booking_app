import 'dart:convert';
import '../../baseUrl/base_url.dart';
import '../../modal/trustee_modal/notification_forAll_modal.dart';
import 'package:http/http.dart' as http;


int? totalPages;

class NotificationForAllRepo {
  List<NotificationForAllModal> notificationAllList = [];
   List<NotificationForAllPageModal> notiAllDetails = [];
  static var queryParameters;

   allNotificationInfo(String pageNo,String pageSize) async {
     queryParameters = {
       "pageno": pageNo,
       "pagesize": pageSize,
     };

     Uri uri = Uri.http(uatBaseUrl,
    "/api/Notification/GetNotificationForAll",NotificationForAllRepo.queryParameters
    );

    try {
      http.Response response = (await http.get(uri));
      print(response.statusCode);
      if(response.statusCode == 200){
        print(uri);
        Map temp = json.decode(response.body);
        print(temp);
        final value = NotificationForAllPageModal.fromJson(temp['responseData']['responseData2']);
        notiAllDetails.add(value);
        temp['responseData']['responseData1'].forEach((v){
         notificationAllList.add(NotificationForAllModal(
           id: v["id"],
           srNo: v["srNo"],
           title: v["title"],
           description: v["description"],
           addedDate: v["addedDate"] == null ? null : DateTime.parse(v["addedDate"]),
           createdBy: v["createdBy"],
           pageList: notiAllDetails
         ));
         notiAllDetails.forEach((element) {
           totalPages = element.totalPages;
         });
         print("__________$totalPages");
        }); return notificationAllList;
      }
    }catch(e){
      print("Exception in Data $e");
    }
  }
}