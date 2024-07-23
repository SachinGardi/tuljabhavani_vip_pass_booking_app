import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tulajapur/view_modal/spl_donation_epass_vm/generate_EPass_vm.dart';
import '../../../modal/spl_donation_epass_modal/spl_epass_booking/generate_ePass_modal.dart';
import '../../../view_modal/devotee_vm/login_passinfo_vm.dart';
import '../../../view_modal/logout_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/get_AmountByPassVm.dart';
import '../../../view_modal/spl_donation_epass_vm/get_EPass_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/get_capacity_vm.dart';
import '../../../view_modal/trustee_vm/get_time_slot_vm.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/progress_indicator.dart';
import '../../common_widget/snack_bar.dart';
import '../../../view_modal/trustee_vm/get_calendar_statusVM.dart';
import '../devotee_profile/common_name.dart';
import 'epass_booking_common_widget.dart';


Color textFieldFilledColor = const Color(0xffF2F2F2);
Color hintTextColor = const Color(0xff868686);
int? timeSlotId;
int? ePassId;
int? passBookingType = 2;
TextEditingController selectedVisitDate = TextEditingController();
class NonReferralPassBooking extends StatefulWidget {
  const NonReferralPassBooking({Key? key}) : super(key: key);

  @override
  State<NonReferralPassBooking> createState() => _NonReferralPassBookingState();
}

int quantity = 0;
int totalPayableAmount = 0;
List<GenerateBookingDetail> bookingSpecialPass = [];
String? selectedTimeValue;
final GetCapacityVm getCapacityVm= Get.put(GetCapacityVm());
final GetEPassVm getEPassVm= Get.put(GetEPassVm());
final GetAmountByPassVm getAmountByPassVm= Get.put(GetAmountByPassVm());
final GenerateSpecialPassVM generateSpecialPassVM= Get.put(GenerateSpecialPassVM());
LogoutViewModal logoutViewModal = Get.put(LogoutViewModal());
final DevoteeLoginInstruction passBookingInstructions = Get.put(DevoteeLoginInstruction());
final GetCalendarStatusVM getCalendarStatusVM = Get.put(GetCalendarStatusVM());
final GetTimeSlotVM getTimeSlotVM = Get.put(GetTimeSlotVM());
class _NonReferralPassBookingState extends State<NonReferralPassBooking> {

String? selectedEPassValue;
TextEditingController quantityController = TextEditingController();
apiCalling () async {
  getCalendarStatusVM.isLoading.value = false;
  availableCapacity = null;
  getAmountByPassVm.getAmountByPassList.clear();
  passBookingInstructions.devoteeInstructionList.clear();
  passBookingInstructions.isLoading.value = true;
  passBookingInstructions.getInstruction();
  passAmount = null;
  selectedEPassValue = null;
  calendarDate!.clear();
  calendarDates!.clear();
  selectedVisitDate.clear();
  getTimeSlotVM.timeslotLists.clear();
  getCapacityVm.getCapacityList.clear();
  availableCapacity = null;
  selectedTimeValue = null;
  quantityController.clear();
  quantity = 0;
  totalPayableAmount = 0;
  getEPassVm.getEPassList.clear();
  getEPassVm.isLoading.value = true;
  await getEPassVm.getEPassName(2);
  // getCalendarStatusVM.getCalendarvmList.clear();
  // getCalendarStatusVM.isLoading.value = true;
  // await getCalendarStatusVM.getCalendar();
}
String? devoteeMobileNo;
getDevoteeNumber()async{
  SharedPreferences preference = await SharedPreferences.getInstance();
   devoteeMobileNo = preference.getString("mob")!;
  print(devoteeMobileNo);
}


String? passBookingLanguage;
getLanguage()async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  passBookingLanguage = pref.getString('language') ?? 'English';
  print("selectedLanguage$passBookingLanguage");
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCalling ();
    getDevoteeNumber();
    quantity = 1;
    getLanguage();
  }



String? selectedCalenderDate;
String? selectedCalenderDatePost;
String _dateCount = '';
String _rangeCount = '';
void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  setState(() {
    if (args.value is DateTime) {
      // selectedDate.text = args.value.toString();
      // selectedCalenderDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(args.value.toString()));
      selectedCalenderDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(args.value.toString()));

      print(selectedVisitDate.text);
    } else if (args.value is List<DateTime>) {
      _dateCount = args.value.length.toString();
    } else {
      _rangeCount = args.value.length.toString();
    }
  });
}


showConfirmPassDialog() {
  showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent.withOpacity(0.5),
      context: context,
      builder: (_) =>
          AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding:  EdgeInsets.zero,
            content: SizedBox(
              height: MediaQuery.of(context).size.height/4,
              width: MediaQuery.of(context).size.width/1.15,
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width/20,
                            vertical: MediaQuery.of(context).size.height /80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('confirmation'.tr,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height /45,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "OpenSans",
                                  color: Colors.black)),
                            const Spacer(),
                            GestureDetector(
                                onTap: (){
                                  Get.back();
                                },
                                child: const Icon(Icons.cancel_outlined,color: Colors.redAccent))
                          ],
                        ),
                      ),

                      const Divider(
                        height: 2,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width/20,
                        vertical: MediaQuery.of(context).size.height /50
                    ),
                    child: Text('confirmationMessage'.tr),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height /73),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20),
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height /28,
                                  width: MediaQuery.of(context).size.width /5.5,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3), // Adjust the offset
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Center(
                                      child: Text(
                                        "No".tr,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height /65,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            color: Colors.black)))))),
                        SizedBox(width: MediaQuery.of(context).size.width /30,),
                        GestureDetector(
                            onTap: () async {
                              selectedVisitDate.text = selectedCalenderDate!;
                              DateTime date = DateFormat('dd-MM-yyyy').parseStrict(selectedVisitDate!.text);
                              String devoteeDOB = DateFormat('yyyy-MM-dd').format(date);
                              await generateSpecialPassVM.specialPassGenerateLink(
                                0,
                                0,
                                DateTime.now(),
                                DateTime.now(),
                                false,
                                0,
                                0,
                                devoteeMobileNo!,
                                quantity,
                                DateTime.parse(devoteeDOB),
                                timeSlotId!,
                                totalPayableAmount,
                                true,
                                ePassId!,
                                bookingSpecialPass,
                                context,
                              );
                              if(generateSpecialPassVM.statusCode == "200") {
                                // toastMessage(context, generateSpecialPassVM.statusMessage!);
                                SharedPreferences preference = await SharedPreferences.getInstance();
                                preference.setString("ePassId", ePassId!.toString());
                                preference.setString("visitDate", devoteeDOB);
                                preference.setString("timeSlotId", timeSlotId!.toString());
                                preference.setString("passAmount", passAmount.toString());
                                preference.setInt("devoteeId",generateSpecialPassVM.devoteeId!);
                                preference.setBool("isPassGenerated",true);
                                Get.offAllNamed("/splePassDetailsView");
                              } else if(generateSpecialPassVM.statusCode! == "404"){
                                toastMessage(context,"noTimeSlotAvailable".tr);
                              }
                              else{
                                if(generateSpecialPassVM.statusCode! == "400") {
                                    toastMessage(context,"toastPassBooked".tr);
                                  }
                                }
                              Get.back();
                            },
                            child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height /28,
                                  width: MediaQuery.of(context).size.width /5.5,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          // Adjust shadow color and opacity
                                          spreadRadius: 2,
                                          // Adjust the spread radius
                                          blurRadius: 5,
                                          // Adjust the blur radius
                                          offset: const Offset(0, 3), // Adjust the offset
                                        ),
                                      ],
                                      gradient: const LinearGradient(
                                          colors: [Color(0xFFFEB349),Color(0xFFFEB349), Color(0xFFE74E0E)],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight),
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Center(
                                      child: Text(
                                        "Yes".tr,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height /65,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            color: Colors.white)))))),
                      ],
                    ))
                ],
              ))));
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: commonAppBarePassBooking("passBooking".tr),
        body: Obx(() =>
           ModalProgressHUD(
             inAsyncCall: getEPassVm.isLoading.value == true || getCalendarStatusVM.isLoading.value == true,
               progressIndicator: progressIndicator(),
             child: NotificationListener<OverscrollIndicatorNotification>(
                         onNotification: (overScroll) {
                           overScroll.disallowIndicator();
                           return true;
                         },
                         child: WillPopScope(
                           onWillPop: ()async{
                             Get.offAllNamed("/dashBoard");
                             return false;
                           },
                           child: SizedBox(
                             height: MediaQuery.of(context).size.height/1.14,
                             width: MediaQuery.of(context).size.width,
                             child: Padding(
                               padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width /20),
                               child: RefreshIndicator(
                                 color: Colors.deepOrange.shade600,
                                 onRefresh: () {
                                   return Future.delayed(const Duration(seconds: 1),() async {
                                     getAmountByPassVm.getAmountByPassList.clear();
                                     passAmount = null;
                                     selectedEPassValue = null;
                                     getEPassVm.getEPassList.clear();
                                     getEPassVm.isLoading.value = true;
                                     await getEPassVm.getEPassName(2);
                                     calendarDate!.clear();
                                     calendarDates!.clear();
                                     selectedVisitDate.clear();
                                     getCalendarStatusVM.getCalendarvmList.clear();
                                     getCalendarStatusVM.isLoading.value = true;
                                     await getCalendarStatusVM.getCalendar(ePassId!);
                                     getTimeSlotVM.timeslotLists.clear();
                                     getCapacityVm.getCapacityList.clear();
                                     availableCapacity = null;
                                     quantity = 0;
                                     quantityController.clear();
                                     totalPayableAmount = 0;
                                   });
                                 },
                                 child: ListView(
                                   children: [
                                     SizedBox(height: MediaQuery.of(context).size.height/60),
                                     ///Select e-Pass
                                      commonRichText("selectPass".tr,"",context),
                                      SizedBox(height: MediaQuery.of(context).size.height/150),
                                      
                                      SizedBox(
                                      height: MediaQuery.of(context).size.height/19,
                                       child: DropdownButtonFormField<String>(
                                         isExpanded: true,
                                         icon: Icon(
                                           Icons.keyboard_arrow_down_outlined,
                                           size: MediaQuery.of(context).size.width/20,
                                         ),
                                         decoration: InputDecoration(
                                             contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height/70),
                                             hintText: "selectPass".tr,
                                             hintStyle: TextStyle(
                                                 fontSize: MediaQuery.of(context).size.height /62,
                                                 fontWeight: FontWeight.w600,
                                                 fontFamily: "OpenSans",
                                                 color: Colors.black54),
                                             fillColor: textFieldFilledColor,
                                             filled: true,
                                             isDense: true,
                                             border: OutlineInputBorder(
                                                 borderSide: BorderSide.none,
                                                 borderRadius: BorderRadius.circular(8)),
                                             focusedBorder: const OutlineInputBorder(
                                                 borderSide: BorderSide.none)),
                                         value: selectedEPassValue,
                                         items: getEPassVm.getEPassList
                                             .map((items) => DropdownMenuItem<String>(
                                           onTap: () async {
                                             ePassId = items.id;
                                             print(ePassId);
                                           },
                                           value: items.ePassName.toString(),
                                           child: Text(items.ePassName.toString(),
                                               style: TextStyle(
                                                   color: Colors.black,
                                                   fontSize: MediaQuery.of(context).size.width/31.5,
                                                   fontFamily: 'OpenSans'
                                               )))).toList(),
                                         onChanged: (value) async {
                                           setState(() {
                                             getAmountByPassVm.getAmountByPassList.clear();
                                             getAmountByPassVm.isLoading.value = true;
                                             selectedEPassValue = value;
                                             print(ePassId);
                                             print(selectedEPassValue);
                                             totalPayableAmount = 0;
                                             quantity = 0;
                                             quantityController.clear();
                                             calendarDate!.clear();
                                             calendarDates!.clear();
                                             selectedVisitDate.clear();
                                             selectedTimeValue = null;
                                             getTimeSlotVM.timeslotLists.clear();
                                             availableCapacity = null;
                                             quantityController.clear();
                                             getCapacityVm.getCapacityList.clear();
                                             getCalendarStatusVM.getCalendarvmList.clear();
                                             getCalendarStatusVM.isLoading.value = true;
                                           });
                                           await getAmountByPassVm.getAmountByPassDetails(ePassId!);
                                           print(ePassId!);
                                           print(value);
                                           await getCalendarStatusVM.getCalendar(ePassId!);
                                           print(passAmount);
                                           if (kDebugMode) {
                                             print(selectedTimeValue);
                                           }
                                         },
                                         menuMaxHeight: 300,
                                       ),
                                     ),
                                     SizedBox(height: MediaQuery.of(context).size.height/150),

                                     getAmountByPassVm.isLoading.value == true?const SizedBox.shrink():SizedBox(height: MediaQuery.of(context).size.height/200),
                                     Obx(()=>
                                     getAmountByPassVm.isLoading.value == true?const SizedBox.shrink():
                                     passAmount == null?const SizedBox.shrink():commonLogoText("passAmount".tr,"₹ ",passAmount!.toInt(),Colors.black,context)),
                                     passAmount == null?SizedBox(height: MediaQuery.of(context).size.height/100):SizedBox(height: MediaQuery.of(context).size.height/60),
                                     /// Visit Date
                                     commonRichText('selectDate'.tr,"",context),
                                     SizedBox(height: MediaQuery.of(context).size.height/150),
                                        SizedBox(
                                           height: MediaQuery.of(context).size.height/ 19,
                                           child: InkWell(
                                               onTap: (){
                                               selectedEPassValue != null?showDialog<String>(
                                                 barrierDismissible: false,
                                                 context: context,
                                                 builder: (BuildContext context) => AlertDialog(
                                                   contentPadding: EdgeInsets.zero,
                                                   buttonPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/60),
                                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height/50)),
                                                   title: SizedBox(
                                                     height: MediaQuery.of(context).size.height/ 2.62,
                                                     width: MediaQuery.of(context).size.width/0.5,
                                                     child: Column(
                                                       mainAxisAlignment: MainAxisAlignment.start,
                                                       children: [
                                                         SizedBox(
                                                           height: MediaQuery.of(context).size.height / 3,
                                                           child: SfDateRangePicker(
                                                             initialSelectedDate: selectedVisitDate.text != ""?DateFormat('dd-MM-yyyy').parseStrict(selectedVisitDate.text):null,
                                                             headerStyle: const DateRangePickerHeaderStyle(
                                                                 textAlign: TextAlign.center,
                                                                 backgroundColor: Color(0xFFF68E34)),
                                                             allowViewNavigation: true,
                                                             onSelectionChanged:
                                                             onSelectionChanged,
                                                             selectionMode:
                                                             DateRangePickerSelectionMode.single,
                                                             showNavigationArrow: true,
                                                             selectionColor: const Color(0xFFF68E34),
                                                             selectableDayPredicate: (DateTime date) {
                                                               if (date.day.isEqual(DateTime.now().day) && calendarDate!.isEmpty) {
                                                                 return false;
                                                               }
                                                               return true;
                                                             },
                                                             enablePastDates: false,
                                                             minDate:calendarDate!.isNotEmpty? DateTime.now().add(const Duration(days: 1)):null,
                                                             maxDate:calendarDate!.isEmpty? DateTime.now()
                                                                 :DateTime.now().add(
                                                                 Duration(days:(calendarDate!.length + calendarDates!.length))),

                                                             /*  maxDate: DateTime.now()
                                                                    .add(const Duration(days: 7)),*/
                                                             view: DateRangePickerView.month,
                                                             monthViewSettings: DateRangePickerMonthViewSettings(
                                                                 blackoutDates:calendarDates!,
                                                                 // weekendDays: [7, 6],
                                                                 specialDates: calendarDate,
                                                                 showTrailingAndLeadingDates:
                                                                 false),
                                                             monthCellStyle:
                                                             DateRangePickerMonthCellStyle(
                                                               disabledDatesDecoration: BoxDecoration(
                                                                   color:Colors.grey[200],
                                                                   border: Border.all(color: Colors.black38, width: 1),
                                                                   shape: BoxShape.circle),
                                                               blackoutDatesDecoration:
                                                               BoxDecoration(color:Colors.black38,
                                                                   border: Border.all(color: Colors.black38, width: 1),
                                                                   shape: BoxShape.circle),
                                                               weekendDatesDecoration:
                                                               const BoxDecoration(
                                                                 // color: const Color(0xFFDFDFDF),
                                                                 // border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
                                                                 // shape: BoxShape.circle
                                                               ),
                                                               specialDatesDecoration:
                                                               BoxDecoration(
                                                                   color: Colors.green,
                                                                   border: Border.all(
                                                                       color: const Color(
                                                                           0xFF2B732F),
                                                                       width: 1),
                                                                   shape: BoxShape
                                                                       .circle),
                                                               blackoutDateTextStyle:
                                                               const TextStyle(
                                                                   decorationStyle:
                                                                   TextDecorationStyle.double,
                                                                   color: Colors.white70,
                                                                   fontFamily: 'OpenSans'
                                                               ),
                                                               specialDatesTextStyle:
                                                               const TextStyle(
                                                                   color: Colors.white,
                                                                   fontFamily: 'OpenSans'
                                                               ),
                                                             ),
                                                           ),
                                                         ),
                                                         Padding(
                                                           padding: const EdgeInsets.only(left: 10,right: 10),
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                             children: [
                                                               Column(
                                                                 children: [
                                                                   Row(
                                                                     children: [
                                                                       Icon(Icons.circle,
                                                                           color: Colors.green,
                                                                           size: MediaQuery.of(context).size.height/70),
                                                                       const SizedBox(width: 5),
                                                                       Text("Available",
                                                                           style: TextStyle(
                                                                               fontFamily: "OpenSans",
                                                                               fontWeight: FontWeight.bold,
                                                                               fontSize: MediaQuery.of(context).size.height/65)
                                                                       ),
                                                                     ],
                                                                   ),

                                                                   Row(
                                                                     children: [
                                                                       Icon(Icons.circle,
                                                                           color: const Color(
                                                                               0xFFF68E34),
                                                                           size: MediaQuery.of(context).size.height/70),
                                                                       const SizedBox(width: 5),
                                                                       Text("Selected",
                                                                           style: TextStyle(
                                                                               fontWeight: FontWeight.bold,
                                                                               fontFamily: "OpenSans",
                                                                               fontSize: MediaQuery.of(context).size.height/65)),
                                                                       const SizedBox(width: 2)
                                                                     ],
                                                                   ),
                                                                 ],
                                                               ),
                                                               Column(
                                                                 children: [
                                                                   Row(
                                                                     children: [
                                                                       Icon(Icons.circle,
                                                                           color: Colors.grey,
                                                                           size: MediaQuery.of(context).size.height/70),
                                                                       const SizedBox(width: 5),
                                                                       Text("Reserved/Full",
                                                                           style: TextStyle(
                                                                               fontWeight: FontWeight.bold,
                                                                               fontFamily: "OpenSans",
                                                                               fontSize: MediaQuery.of(context).size.height/65)),
                                                                     ],
                                                                   ),
                                                                   Row(
                                                                     children: [
                                                                       const SizedBox(width: 5),
                                                                       Icon(Icons.circle,
                                                                           color: Colors.grey[200],
                                                                           size: MediaQuery.of(context).size.height/70),
                                                                       const SizedBox(width: 5),
                                                                       Text(
                                                                           "Not Applicable",
                                                                           style: TextStyle(
                                                                               fontWeight: FontWeight.bold,
                                                                               fontFamily: "OpenSans",
                                                                               fontSize: MediaQuery.of(context).size.height/65)),
                                                                     ],
                                                                   ),
                                                                 ],
                                                               ),
                                                             ],
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                   ),
                                                   actions: <Widget>[
                                                     TextButton(
                                                       onPressed: () => Get.back(),
                                                       child:  Text('cancel'.tr,
                                                         style: const TextStyle(
                                                             fontWeight: FontWeight.bold,
                                                             fontFamily: "OpenSans"),
                                                       ),
                                                     ),
                                                     TextButton(
                                                         onPressed: () async {

                                                             availableCapacity = null;
                                                             selectedVisitDate.text = selectedCalenderDate!;
                                                             DateTime date = DateFormat('dd-MM-yyyy').parseStrict(selectedVisitDate!.text);
                                                             String devoteeDOB = DateFormat('yyyy-MM-dd').format(date);

                                                             print("Date: ${selectedVisitDate.text}");
                                                             Get.back();
                                                             print(selectedVisitDate.text);
                                                             print(selectedVisitDate.text);
                                                             print(selectedVisitDate.text);
                                                             print(selectedVisitDate.text);

                                                           selectedTimeValue = null;
                                                           getTimeSlotVM.timeslotLists.clear();
                                                           getTimeSlotVM.isLoading.value = true;
                                                           await getTimeSlotVM.getallTime(context,devoteeDOB);
                                                         },
                                                         child:  Text("OK".tr,style: const TextStyle(
                                                             fontWeight: FontWeight.bold,
                                                             fontFamily: "OpenSans"))),
                                                   ],
                                                 ),
                                               ):toastMessage(context, "selectPass".tr);
                                               },
                                               child: IgnorePointer(
                                                   child: SizedBox(
                                                       height: MediaQuery.of(context).size.height / 15,
                                                       child: TextFormField(
                                                           readOnly: true,
                                                           keyboardType: TextInputType.none,
                                                           showCursor: false,
                                                           controller: selectedVisitDate,
                                                           onChanged: (value) {
                                                             selectedVisitDate.text = value;
                                                           },
                                                           cursorColor: hintTextColor,
                                                           decoration: InputDecoration(
                                                               contentPadding: const EdgeInsets.all(10),
                                                               hintText: "selectDate".tr,
                                                               hintStyle: TextStyle(
                                                                   fontSize: MediaQuery.of(context).size.height /64,
                                                                   fontWeight: FontWeight.w600,
                                                                   fontFamily: "OpenSans",
                                                                   color: Colors.black54),
                                                               fillColor: textFieldFilledColor,
                                                               filled: true,
                                                               isDense: true,
                                                               suffixIcon: IconButton(
                                                                   icon: Icon(Icons.calendar_month,
                                                                       color: hintTextColor),
                                                                   onPressed: () {}),
                                                               border: OutlineInputBorder(
                                                                   borderSide: BorderSide.none,
                                                                   borderRadius: BorderRadius.circular(5)),
                                                               focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none))))))),



                                     SizedBox(height: MediaQuery.of(context).size.height/80),
                                     /// Visit Time
                                     commonRichText('selectTime'.tr,"",context),
                                     SizedBox(height: MediaQuery.of(context).size.height/150),
                                      Obx(()=>
                                        getTimeSlotVM.isLoading.value == true?
                                            ///Dummy Dropdown
                                        InkWell(
                                          onTap: (){
                                            selectedVisitDate.text == "" && selectedTimeValue == null?toastMessage(context, "toastDate".tr):getTimeSlotVM.timeslotLists.isEmpty?toastMessage(context, "noTimeSlotAvailable".tr):"";
                                          },
                                          child: SizedBox(
                                            height: MediaQuery.of(context).size.height/19,
                                            child: DropdownButtonFormField<String>(
                                              icon:  Icon(
                                                Icons.keyboard_arrow_down_outlined,
                                                size: MediaQuery.of(context).size.width/20),
                                              hint: Text("selectTime".tr,style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.height /62,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "OpenSans",
                                                color: Colors.black54)),
                                              decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height/80),
                                                  fillColor: textFieldFilledColor,
                                                  filled: true,
                                                  isDense: true,
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide.none,
                                                      borderRadius: BorderRadius.circular(8)),
                                                  focusedBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide.none)),
                                              value: selectedTimeValue,
                                              items: getTimeSlotVM.timeslotLists
                                                  .map((items) => DropdownMenuItem<String>(
                                                onTap: () async {
                                                  timeSlotId = items.id;
                                                  selectedVisitDate.text == "" && selectedTimeValue == null?toastMessage(context, "toastDate".tr):getTimeSlotVM.timeslotLists.isEmpty?toastMessage(context, "noTimeSlotAvailable".tr):"";
                                                },
                                                value: items.timeSlot.toString(),
                                                child: Text(items.timeSlot.toString(),
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: MediaQuery.of(context).size.height/100,
                                                        fontFamily: 'OpenSans'
                                                    ))))
                                                  .toList(),
                                              onChanged: (time) async {

                                                  selectedTimeValue = time;
                                                  print("===$selectedTimeValue===");
                                                  print("Time Slot Id: $timeSlotId");
                                                  print("selectedDate: ${selectedVisitDate.text}");
                                                  getCapacityVm.getCapacityList.clear();
                                                  getCapacityVm.isLoading.value = true;
                                                  DateTime date = DateFormat('dd-MM-yyyy').parseStrict(selectedVisitDate!.text);
                                                  String devoteeDOB = DateFormat('yyyy-MM-dd').format(date);
                                                await getCapacityVm.getCapacity(devoteeDOB, timeSlotId!, ePassId!, passAmount!);

                                                if (kDebugMode) {
                                                  print(selectedTimeValue);
                                                }
                                              },
                                              menuMaxHeight: 300,
                                            ),
                                          ),
                                        ):
                                        ///Actual DropDown
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height/19,
                                          child: DropdownButtonFormField<String>(
                                            isExpanded: true,
                                               icon:  Icon(
                                                 Icons.keyboard_arrow_down_outlined,
                                                 size: MediaQuery.of(context).size.width/20,
                                               ),
                                               decoration: InputDecoration(
                                                   contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height/70),
                                                   hintText: "selectTime".tr,
                                                   hintStyle: TextStyle(
                                                       fontSize: MediaQuery.of(context).size.height /62,
                                                       fontWeight: FontWeight.w600,
                                                       fontFamily: "OpenSans",
                                                       color: Colors.black54),
                                                   fillColor: textFieldFilledColor,
                                                   filled: true,
                                                   isDense: true,
                                                   border: OutlineInputBorder(
                                                       borderSide: BorderSide.none,
                                                       borderRadius: BorderRadius.circular(8)),
                                                   focusedBorder: const OutlineInputBorder(
                                                       borderSide: BorderSide.none)),
                                               value: selectedTimeValue,
                                               items: getTimeSlotVM.timeslotLists
                                                   .map((items) => DropdownMenuItem<String>(
                                                 onTap: () async {
                                                   timeSlotId = items.id;
                                                   // getCapacityVm.isLoading.value = true;
                                                   // await getCapacityVm.getCapacity(selectedDate.text, timeSlotId!, 17, passAmount!);
                                                   print("availableCapacity: $availableCapacity");

                                                 },
                                                 value: items.timeSlot.toString(),
                                                 child: Text(items.timeSlot.toString(),
                                                     style: TextStyle(
                                                         color: Colors.black,
                                                         fontSize: MediaQuery.of(context).size.width/31.5,
                                                         fontFamily: 'OpenSans'
                                                     )),
                                               ))
                                                   .toList(),
                                               onChanged: (time) async {

                                                   selectedTimeValue = time;
                                                   print("===$selectedTimeValue===");
                                                   print("Time Slot Id: $timeSlotId");
                                                   print("selectedDate: ${selectedVisitDate.text}");
                                                   getCapacityVm.getCapacityList.clear();
                                                   getCapacityVm.isLoading.value = true;
                                                   DateTime date = DateFormat('dd-MM-yyyy').parseStrict(selectedVisitDate!.text);
                                                   String devoteeDOB = DateFormat('yyyy-MM-dd').format(date);
                                                   await getCapacityVm.getCapacity(devoteeDOB, timeSlotId!, ePassId!, passAmount!);

                                                 await getCapacityVm.getCapacity(devoteeDOB, timeSlotId!, ePassId!, passAmount!);

                                                 if (kDebugMode) {
                                                   print(selectedTimeValue);
                                                 }},
                                               menuMaxHeight: 300,
                                             ))),
                                     getCapacityVm.isLoading.value == true?const SizedBox.shrink():SizedBox(height: MediaQuery.of(context).size.height / 200),

                                     Obx(()=>
                                     getCapacityVm.isLoading.value == true?const SizedBox.shrink():
                                     selectedTimeValue == null? const SizedBox.shrink(): availableCapacity == 0 || availableCapacity == null? commonGreenText("totalAvailable".tr,0,Colors.red,context):
                                     commonGreenText("totalAvailable".tr,availableCapacity!,Colors.green,context)),
                                     availableCapacity == null?SizedBox(height: MediaQuery.of(context).size.height/150):SizedBox(height: MediaQuery.of(context).size.height/60),

                                     SizedBox(height: MediaQuery.of(context).size.height/150),
                                     ///No. of devotees
                                     commonRichText('rNoOfDevotee'.tr,"includingPrimary".tr,context),
                                     SizedBox(height: MediaQuery.of(context).size.height/150),

                                     TextFormField(
                                       controller: quantityController,
                                       keyboardType: TextInputType.number,
                                       inputFormatters: <TextInputFormatter>[
                                         FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                                       ],
                                       onChanged: (value) {
                                         setState(() {
                                           quantity = int.tryParse(value) ?? 0;
                                           updateTotalAmount();
                                         });
                                       },
                                       autovalidateMode: AutovalidateMode.always,
                                       validator: (value) {
                                         var text = quantityController.text;

                                         if (text != null && text.isNotEmpty) {
                                           var intValue = int.tryParse(text);

                                           if (intValue != null && intValue > 6) {
                                             return 'maxDevotee'.tr;
                                           }
                                         }
                                       },
                                       cursorColor: Colors.grey,
                                       style: TextStyle(
                                         fontSize: MediaQuery.of(context).size.height/50,
                                         fontFamily: "OpenSans",
                                         color: Colors.black,
                                       ),
                                        maxLength: 2,
                                       decoration: InputDecoration(
                                         counterText: "",
                                         errorMaxLines: 2,
                                         errorBorder: const OutlineInputBorder(
                                             borderRadius: BorderRadius.all(Radius.circular(10)),
                                             borderSide: BorderSide(
                                               width: 1,
                                               color:Colors.redAccent,
                                             )),
                                         focusedErrorBorder: const OutlineInputBorder(
                                           borderRadius: BorderRadius.all(Radius.circular(10)),
                                           borderSide: BorderSide(
                                             width: 1,
                                             color: Colors.black12,
                                           ),
                                         ),
                                         isDense: true,



                                         contentPadding:
                                         EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/70, horizontal: 10),
                                         isCollapsed: true,
                                         hintText: "enterQuantity".tr,
                                           hintStyle: TextStyle(
                                           fontSize: MediaQuery.of(context).size.height /62,
                                         fontWeight: FontWeight.w600,
                                         fontFamily: "OpenSans",
                                         color: Colors.black54),
                                         filled: true,
                                         errorStyle:  TextStyle(
                                           fontSize: MediaQuery.of(context).size.height/80,
                                           fontFamily: "OpenSans",
                                           fontWeight: FontWeight.bold,
                                           color:Colors.red,
                                         ),
                                         fillColor: const Color(0xFFF2F2F2),
                                         enabledBorder: OutlineInputBorder(
                                           borderSide: BorderSide.none,
                                           borderRadius: BorderRadius.circular(7),
                                         ),
                                         focusedBorder: OutlineInputBorder(
                                           borderSide: BorderSide.none,
                                           borderRadius: BorderRadius.circular(7),
                                         ))),
                                     quantity>6?const Text(""):Text("maxDevotee".tr,style: TextStyle(fontFamily: "OpenSans",fontSize: MediaQuery.of(context).size.width/40)),
                                     SizedBox(height: MediaQuery.of(context).size.height / 40),

                                     ///Total Amount

                                     selectedEPassValue != null && passAmount == 0?const SizedBox.shrink():Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("totalBookingAmount".tr,style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black, fontSize: MediaQuery.of(context).size.width/24)),
                                          Container(
                                            width: MediaQuery.of(context).size.width/2.5,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),
                                              color: Colors.grey.shade200),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/70,horizontal: MediaQuery.of(context).size.width/70),
                                              child: Text(" ₹ $totalPayableAmount",style: TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width/24)),
                                            ),
                                          ),
                                        ],
                                      ),


                                     SizedBox(height: MediaQuery.of(context).size.height /60),
                                     RichText(
                                       text: TextSpan(
                                           text: "note".tr,
                                           style:TextStyle(
                                               color: const Color(0xFF3B3B3B),
                                               fontFamily: "NotoSans",
                                               fontSize: MediaQuery.of(context).size.height/65,
                                               fontWeight: FontWeight.bold),
                                           children: <TextSpan>[
                                             TextSpan(text: "passBookingNote".tr,
                                               style: TextStyle(
                                                   fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.height/70),
                                             )
                                           ]
                                       ),
                                     ),
                                     SizedBox(height: MediaQuery.of(context).size.height/50),
                                      GestureDetector(
                                         onTap: () async {

                                            if (selectedEPassValue == null) {
                                              toastMessage(
                                                  context, "selectEPass".tr,
                                                  color: Colors.white);
                                              return;
                                            }
                                                 else if (selectedVisitDate.text == "") {
                                              toastMessage(
                                                  context, "toastDate".tr,
                                                  color: Colors.white);
                                            return;
                                           } else if(selectedTimeValue == null){
                                              toastMessage(
                                                  context, "toastTime".tr,
                                                  color: Colors.white);
                                              return;
                                            } else if(quantityController.text == "" || quantityController.text == "0"){
                                              toastMessage(
                                                  context, "enterVisitingError".tr,
                                                  color: Colors.white);
                                              return;
                                            }
                                            else if(availableCapacity == null){
                                              toastMessage(
                                                  context, "timeSlotError".tr,
                                                  color: Colors.white);
                                              return;
                                            }

                                              else if(int.tryParse(quantityController.text)! > 6){
                                                toastMessage(context, 'maxDevotee'.tr, color: Colors.white);
                                                return;
                                              }

                                            if(quantity > availableCapacity!){
                                              toastMessage(context, "lessCapacityMsg".tr, color: Colors.white);
                                                return;
                                            }

                                           else{
                                              bookingSpecialPass.clear();
                                              bookingSpecialPass.add(
                                                  GenerateBookingDetail(
                                                      id: 0,
                                                      bookingId: 0,
                                                      amount: passAmount,
                                                      createdBy: 0,
                                                      noOfdevotee: quantity,
                                                      ePassName: selectedEPassValue
                                                  ));
                                              showConfirmPassDialog();
                                            }
                                         },
                                         child: commonButton(context, "submit".tr)),
                                     SizedBox(height: MediaQuery.of(context).size.height/60),
                                     Text("dInstruction".tr,
                                         style:TextStyle(
                                             fontSize: MediaQuery.of(context).size.height/55,
                                             color: const Color(0xFF303030),
                                             fontFamily: 'OpenSans',
                                             fontWeight: FontWeight.bold
                                         )),
                                     Padding(
                                       padding: EdgeInsets.only(
                                         top: MediaQuery.of(context).size.height/120,
                                         left: MediaQuery.of(context).size.width/70,
                                         right: MediaQuery.of(context).size.width/70,
                                       ),
                                       child: SizedBox(
                                         height: MediaQuery.of(context).size.height/6.3,
                                         child: Scrollbar(
                                           thickness: 2.5,
                                           thumbVisibility: true,
                                           child: SingleChildScrollView(
                                             scrollDirection: Axis.vertical,
                                             child: Padding(
                                               padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/50),
                                               child: Text(passBookingLanguage== "English"? instructionss ?? ""
                                                   : marathiInstructions ?? "",
                                                   textAlign: TextAlign.justify,
                                                   style:TextStyle(
                                                   fontSize: MediaQuery.of(context).size.width/30,
                                                   fontFamily: 'OpenSans',
                                                   color: Colors.black))))))),
                                       ],
                                     ))))))))));
  }
void updateTotalAmount() {
  setState(() {
    totalPayableAmount = (passAmount! * quantity).toInt();
  });
}
}