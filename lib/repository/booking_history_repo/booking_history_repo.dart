import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../baseUrl/base_url.dart';
import '../../modal/booking_history_modal/booking_history_modal.dart';


int? totalCountdata;
class BookingHistoryRepo {

  static List<BookingHistoryModal> bookingList = [];
  static List<TrusteeBookingPageModal> bookingPageData = [];
  static var queryParameters;
  static getBookingDetail(String pageno,String pagesize,String textsearch,int trustee,String visitDate,int timeslot,int status,int userTypeId,String mobileNo,BuildContext context) async {
    queryParameters = {
      "pageno" : pageno,
      "pagesize" : pagesize,
      "Textsearch" : textsearch,
      "Trustee" : "$trustee",
      "VisitDate" : visitDate,
      "TimeSlot" : "$timeslot",
      "Status" : "$status",
      "UserTypeId" : "$userTypeId",
      "mobileNo" : mobileNo,
    };
    Uri uri = Uri.http(uatBaseUrl,
        "/api/TuljapurEpassWebApi/ePassBooking/GetBookingHistoryForApp",
    BookingHistoryRepo.queryParameters);


      try {
        print(uri);
        bookingPageData.clear();
        http.Response response = (await http.get(uri));
        print(response.statusCode);
        if (response.statusCode == 200) {
          Map temp = json.decode(response.body);
          print(temp);

          temp['responseData1'].forEach((v){
            bookingPageData.add(TrusteeBookingPageModal(
              pageNo: v["pageNo"],
              totalPages: v["totalPages"],
              pageCount: v["pageCount"],
            ));totalCountdata = v["totalPages"];
          });

          temp['responseData'].forEach((v) {
            print(v['srNo']);
            bookingList.add(BookingHistoryModal(
              srNo: v["srNo"],
              ePassId: v["ePassId"],
              userTypeId: v["userTypeId"],
              devoteeName: v["devoteeName"],
              mobileNo: v["mobileNo"],
              emailId: v["emailId"],
              noOfVisitors: v["noOfVisitors"],
              referById: v["referById"],
              referredBy: v["referredBy"],
              totalAmount: v["totalAmount"],
              visitDate: v["visitDate"] == null ? null : DateTime.parse(v["visitDate"]),
              transactionDate: v["transactionDate"] == null ? null : DateTime.parse(v["transactionDate"]),
              timeSlot: v["timeSlot"],
              statusId: v["statusId"],
              status: v["status"],
              protocol: v["protocol"],
              acceptRemark: v["acceptRemark"],
              rejectedRemark: v["rejectedRemark"],
              referanceName: v["referanceName"],
              ePassName: v["ePassName"],
              transactionId: v["transactionId"],
              bookingId: v["bookingId"],
              bookingPassDetails: v["bookingPassDetails"] == null ? [] : List<
                  BookingPassDetail>.from(v["bookingPassDetails"]!.map((x) =>
                  BookingPassDetail.fromJson(x))),
              // bookingPageDetails: bookingPageData
            ));
          });
          return bookingList;
        }
      }
      catch (e) {
        print('Exception in Data $e');
      }
  }
}

