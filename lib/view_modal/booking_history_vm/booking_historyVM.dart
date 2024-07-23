import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../modal/booking_history_modal/booking_history_modal.dart';
import '../../repository/booking_history_repo/booking_history_repo.dart';


String? devoteeNameHistory;
String? devoteeVisitDate;
int? devoteebook;
int? totalPageSize;
int? ePassID;
int? ePassIDLoop;
int? histCount;
class BookingHistoryVM extends GetxController {
List<BookingHistoryModal> bookingListvm = [];


var isLoading = true.obs;

getBookingDetails(String pageno,String pagesize,String textsearch,int trustee,String visitDate,int timeslot,int status,int userTypeId,String mobileNo,BuildContext context) async {
  var bookingDetail = await BookingHistoryRepo.getBookingDetail(pageno,pagesize,textsearch,trustee,visitDate,timeslot,status,userTypeId,mobileNo,context);
  print(bookingDetail);
  if(bookingDetail != null){
    bookingListvm = bookingDetail;
    isLoading.value = false;
  }
  else if(bookingDetail == null){
    Timer(const Duration(seconds:1),(){
      isLoading.value=false;
    });
  }
  BookingHistoryRepo.bookingPageData.forEach((element) {
    totalPageSize = element.totalPages;
    print("totalPageSize");
    print(totalPageSize);
  });


}
}