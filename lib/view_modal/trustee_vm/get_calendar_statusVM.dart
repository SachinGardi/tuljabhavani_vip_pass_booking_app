import 'dart:async';
import 'package:get/get.dart';
import '../../modal/trustee_modal/calendar_modal.dart';
import '../../repository/trustee_respository/calendar_repo.dart';


int? dateLimit;
List<DateTime>? calendarDate = [];
List<DateTime>? calendarDates = [];
List<DateTime>? selectedDate = [];
class GetCalendarStatusVM extends GetxController {
  List<Calendarmodal> getCalendarvmList=[];
  var isLoading = true.obs;

    getCalendar(int ePassID) async {
  var getCalendar = await CalendarRepo.getCalendarStatus(ePassID);
  getCalendarvmList = getCalendar;
  isLoading.value = false;
  print("000${getCalendarvmList.length}");
  
  for (var element in getCalendarvmList) {
    if(element.status == "Reserved/Full"){
      calendarDates!.add(element.date!);
      print(calendarDates);
      print("///////${calendarDates!.length}");
    } else if(element.status == "Available"){

      calendarDate!.add(element.date!);

      print(calendarDate);
      print("-----${calendarDate!.length}----");
      dateLimit = calendarDate?.length;
      print('#####$dateLimit*******');
    }

  }
  if(getCalendarvmList.isEmpty){
    Timer(const Duration(seconds: 1),(){
      isLoading.value = false;
    });
  }
  }
}