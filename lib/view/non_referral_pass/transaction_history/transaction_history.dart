import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../view_modal/booking_history_vm/booking_historyVM.dart';
import '../../../view_modal/booking_history_vm/get_timeSlotFilterVM.dart';
import '../../../view_modal/trustee_vm/get_status_vm.dart';
import '../../common_widget/common_button.dart';
import '../devotee_profile/common_name.dart';
import 'common_widgets.dart';
import 'package:encrypt/encrypt.dart' as encrypt;





final bookingHistoryVM = Get.put(BookingHistoryVM());
class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  TextEditingController transactionSearchController = TextEditingController();

  final getTimeSlotFilterVM = Get.put(GetTimeSlotFilterVM());
  final getStatusVM = Get.put(GetStatusVM());

  String? selectedTimeValueFilter;
  String? selectedStatusFilter;
  _searchAPI() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String devoteeMobileNo = preference.getString("mob")!;
    bookingHistoryVM.bookingListvm.clear();
    bookingHistoryVM.isLoading.value = true;
    await bookingHistoryVM.getBookingDetails(_page.toString(),"10",transactionSearchController.text,0,"",0,0,0,devoteeMobileNo,context);
  }
  _searchAPI2() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String devoteeMobileNo = preference.getString("mob")!;
    bookingHistoryVM.bookingListvm.clear();
    bookingHistoryVM.isLoading.value = true;
    await bookingHistoryVM.getBookingDetails(_page.toString(),"10","",0,"",0,0,0,devoteeMobileNo,context);
  }

  TextEditingController visitDateController = TextEditingController();
  DateTime? pickedDate;
  void openCalender2() async {
    pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now().add(const Duration(days: 6)),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFFE95915),
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ))),
            child: child!);
      },
    );
    if (pickedDate != null) {
      setState(() {
        visitDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate!);
        getTimeSlotFilterVM.timeslotLists.clear();
        getTimeSlotFilterVM.isLoading.value = true;
        getTimeSlotFilterVM.getallTime();
        // Get.back();
      });
    }
  }


  ///Pagination
  int _page = 1;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  void _firstLoad() async {

    print("First Load");
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      {
        Timer(const Duration(milliseconds: 800), () async {
          SharedPreferences preference = await SharedPreferences.getInstance();
          String devoteeMobileNo = preference.getString("mob")!;
          transactionSearchController.clear();
          bookingHistoryVM.bookingListvm.clear();
          bookingHistoryVM.isLoading.value = true;
          await bookingHistoryVM.getBookingDetails(_page.toString(),"10",transactionSearchController.text,0,"",0,0,0,devoteeMobileNo,context);

          if (_page == totalPageSize!) {
            setState(() {
              _hasNextPage = false;
            });
          }

        });
      }
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }
  void _loadMore() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String devoteeMobileNo = preference.getString("mob")!;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;
      try {

        transactionSearchController.clear();
        await bookingHistoryVM.getBookingDetails(_page.toString(),"10",transactionSearchController.text,0,"",0,0,0,devoteeMobileNo,context);
        if (_page == totalPageSize) {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  late Timer _debounce;

  late ScrollController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatusVM.getallStatus(2);
    getTimeSlotFilterVM.getallTime();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
    _debounce = Timer(const Duration(milliseconds: 500), () {});

  }
  @override
  void dispose() {
    _debounce.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async {
        Get.offAllNamed("/dashBoard");
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
                systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2)),
              elevation: 0,
              leading:IconButton(
                onPressed: (){
                  Get.offAllNamed("/dashBoard");
                },
                icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 35),
              ),
              title: Text("transactionHistory".tr,style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "OpenSans",
                  color: Color(0xFFFFFFFF))),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Color(0xFFEC6019), Color(0xFFFEB148),Color(0xFFFEB148)])),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              getTimeSlotFilterVM.timeslotLists.clear();
                              getStatusVM.filterStatusList.clear();
                              getStatusVM.isLoading.value = true;
                              getStatusVM.getallStatus(2);
                              getTimeSlotFilterVM.isLoading.value = true;
                              getTimeSlotFilterVM.getallTime();
                            });
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
                              builder: (context) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height / 3.65,
                                  child: Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20, left: 14, right: 14),
                                        child: TextFormField(
                                          readOnly: true,
                                          cursorColor: const Color(0xFFF3822C),
                                          style: const TextStyle(fontSize: 13),
                                          keyboardType: TextInputType.none,
                                          onTap: openCalender2,
                                          controller: visitDateController,
                                          textAlignVertical: TextAlignVertical.center,
                                          decoration: InputDecoration(
                                              hintText: 'selectDatee'.tr,
                                              hintStyle: const TextStyle(fontSize: 15),
                                              contentPadding: const EdgeInsets.symmetric(
                                                  vertical: 14, horizontal: 10),
                                              filled: true,
                                              fillColor: const Color(0xFFF2F2F2),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              isDense: true,
                                              border: InputBorder.none,
                                              suffixIcon: const Icon(
                                                Icons.calendar_month,
                                                size: 20,
                                                color: Colors.black,
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height / 60),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                              flex:2,
                                              child:
                                              Padding(
                                                  padding: const EdgeInsets.only(top: 15, left: 14, right: 14),
                                                  child:
                                                  Obx(()=> getTimeSlotFilterVM.isLoading.value == true?const Text("")
                                                      : DropdownButtonFormField<String>(
                                                    icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 20),
                                                    decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                                        hintText: "selectTimee".tr,
                                                        hintStyle: const TextStyle(color: Color(0xff868686),fontFamily: "OpenSans",fontSize: 15),
                                                        fillColor: const Color(0xffF2F2F2),
                                                        filled: true,
                                                        isDense: true,
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                            borderRadius: BorderRadius.circular(8)),
                                                        focusedBorder: const OutlineInputBorder(
                                                            borderSide: BorderSide.none)),
                                                    value: selectedTimeValueFilter,
                                                    items: getTimeSlotFilterVM.timeslotLists
                                                        .map((items) => DropdownMenuItem<String>(
                                                      onTap: (){

                                                      },
                                                      value: items.id.toString(),
                                                      child: Text(items.timeSlot.toString(),
                                                          style: const TextStyle(
                                                              color: Colors.black54,
                                                              fontSize: 12)),
                                                    )).toList(),

                                                    onChanged: (time) {
                                                      setState(() {
                                                        selectedTimeValueFilter = time;
                                                        if (kDebugMode) {
                                                          print("===$selectedTimeValueFilter===");
                                                        }
                                                      });
                                                      if (kDebugMode) {
                                                        print(selectedTimeValueFilter);
                                                      }
                                                    },
                                                    menuMaxHeight: 300,
                                                  )))),
                                          Expanded(
                                              flex:2,
                                              child: Obx(
                                                      () => (getStatusVM.isLoading.value == true)
                                                      ? const Text("")
                                                      : Padding(
                                                      padding: const EdgeInsets.only(top: 15, left: 14, right: 14),
                                                      child: DropdownButtonFormField<String>(
                                                        icon: const Icon(
                                                            Icons.keyboard_arrow_down_outlined,
                                                            size: 20),
                                                        decoration: InputDecoration(
                                                            contentPadding: const EdgeInsets.symmetric(
                                                                vertical: 14, horizontal: 10),
                                                            hintText: "selectStatus".tr,
                                                            hintStyle: TextStyle(color: const Color(0xff868686),fontFamily: "OpenSans",fontSize: 15),
                                                            fillColor: const Color(0xffF2F2F2),
                                                            filled: true,
                                                            isDense: true,
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide.none,
                                                                borderRadius: BorderRadius.circular(8)),
                                                            focusedBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide.none)),
                                                        value: selectedStatusFilter,
                                                        items: getStatusVM.filterStatusList.map((items) => DropdownMenuItem<String>(
                                                          onTap: (){

                                                          },
                                                          value: items.id.toString(),
                                                          child: Text(items.status.toString(),
                                                              style: const TextStyle(
                                                                  color: Colors.black54,
                                                                  fontSize: 12)),
                                                        )).toList(),

                                                        menuMaxHeight: 300,
                                                        onChanged: (st) {
                                                          setState(() {
                                                            selectedStatusFilter = st;
                                                            if (kDebugMode) {
                                                              print("===$selectedStatusFilter===");
                                                            }
                                                          });
                                                          if (kDebugMode) {
                                                            print(selectedStatusFilter);
                                                          }
                                                        },
                                                      )))),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              flex:2,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    visitDateController.clear();
                                                    selectedTimeValueFilter = null;
                                                    selectedStatusFilter = null;
                                                    Get.back();
                                                  },
                                                  child: commonButton(context, "cancel".tr)),
                                            ),
                                            SizedBox(width: MediaQuery.of(context).size.width/100),
                                            Expanded(
                                              flex:2,
                                              child: GestureDetector(
                                                  onTap: () async {
                                                    SharedPreferences preference = await SharedPreferences.getInstance();
                                                    String devoteeMobileNo = preference.getString("mob")!;
                                                    setState(() {
                                                      Get.back();
                                                      bookingHistoryVM.bookingListvm.clear();
                                                      getTimeSlotFilterVM.timeslotLists.clear();
                                                      getStatusVM.filterStatusList.clear();
                                                      bookingHistoryVM.bookingListvm.clear();
                                                      bookingHistoryVM.isLoading.value = true;
                                                    });
                                                    await bookingHistoryVM.getBookingDetails("1","10","",0,visitDateController.text == ""?"":visitDateController.text,int.parse(selectedTimeValueFilter != null?selectedTimeValueFilter!:"0"),int.parse(selectedStatusFilter !=null?selectedStatusFilter!:"0"),0,devoteeMobileNo,context);
                                                  },
                                                  child: commonButton(context, "filter".tr)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xffFFFFFF).withOpacity(0.29),
                              child: const Icon(
                                Icons.filter_alt_outlined,
                                size: 22,
                                color: Colors.white,
                              ))),
                    ],
                  ),
                )
              ]
          ),
        body: Obx(()=>bookingHistoryVM.isLoading.value == true?const Text(""):
           NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return true;
                },
                child: RefreshIndicator(
                  color: Colors.grey,
                  displacement: 6,
                  onRefresh: () {
                    return Future.delayed(
                        const Duration(seconds: 1),
                            () async {
                              SharedPreferences preference = await SharedPreferences.getInstance();
                              String devoteeMobileNo = preference.getString("mob")!;
                          setState(() {
                            _page = 1;
                            _hasNextPage = true;
                            visitDateController.clear();
                            transactionSearchController.clear();
                            bookingHistoryVM.bookingListvm.clear();
                            bookingHistoryVM.isLoading.value = true;
                          });
                              await bookingHistoryVM.getBookingDetails(_page.toString(),"10","",0,"",0,0,0,devoteeMobileNo,context);
                              if (_page == totalPageSize!) {
                                setState(() {
                                  _hasNextPage = false;
                                });
                              }
                        });},
                  child: ListView(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left:10,right:10,top: 10),
                              child: SizedBox(
                                  height: MediaQuery.of(context).size.height/20,
                                  child: TextField(
                                      controller: transactionSearchController,
                                      onChanged: (value) async {
                                        SharedPreferences preference = await SharedPreferences.getInstance();
                                        String devoteeMobileNo = preference.getString("mob")!;
                                        _debounce.cancel();
                                        _debounce = Timer(const Duration(milliseconds: 550), () async {
                                          setState(() {
                                            bookingHistoryVM.bookingListvm.clear();
                                            bookingHistoryVM.isLoading.value = true;
                                          });
                                           await bookingHistoryVM.getBookingDetails(_page.toString(), "10", transactionSearchController.text, 0, "", 0, 0, 0, devoteeMobileNo,context);
                                          _hasNextPage = true;
                                        });
                                      },
                                      onSubmitted: (val) {
                                        transactionSearchController.text != ""? _searchAPI():_searchAPI2();
                                      },
                                      textInputAction: TextInputAction.search,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.all(10),
                                          hintText: 'searchText'.tr,
                                          hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width/31.5, color: const Color(0xff868686),fontFamily: "OpenSans"),
                                          fillColor: Colors.white,
                                          filled: true,
                                          isDense: true,
                                          border: const OutlineInputBorder(borderSide: BorderSide.none),
                                          prefixIcon: const Icon(Icons.search,size: 25,color: Colors.grey))))),
                          SizedBox(height: MediaQuery.of(context).size.height/150),
                          bookingHistoryVM.bookingListvm.isEmpty?Center(child: Text("noDataFound".tr,style: TextStyle(fontFamily: "OpenSans",fontSize: MediaQuery.of(context).size.height/50))):
                          SizedBox(
                            height: MediaQuery.of(context).size.height/1.22,
                            child: ListView.builder(
                                controller: _controller,
                                padding: const EdgeInsets.only(bottom: 20),
                                shrinkWrap: true,
                                itemCount: bookingHistoryVM.bookingListvm.length,
                                itemBuilder: (context, index)
                                => Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xffFFFFFF),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xff000017).withOpacity(0.1),
                                                offset: const Offset(0,3),
                                                blurRadius: 6,
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(10)),

                                        child: Card(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            color: const Color(0xffFFFFFF),
                                            shadowColor: Colors.grey,
                                            elevation: 0,
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/80),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        commonTransactionText("Transaction ID: ",bookingHistoryVM.bookingListvm[index].transactionId ?? "-",context),

                                                        Container(
                                                            height: MediaQuery.of(context).size.height / 23,
                                                            width: MediaQuery.of(context).size.width / 4.5,
                                                            decoration: BoxDecoration(
                                                                color: (bookingHistoryVM.bookingListvm[index].status == null)
                                                                    ? const Color(0xff22AD00).withOpacity(0.1) : (bookingHistoryVM.bookingListvm[index].status! == "Visited")
                                                                    ? const Color(0xff22AD00).withOpacity(0.1) : (bookingHistoryVM.bookingListvm[index].status! == "Expired")
                                                                    ? const Color(0xFFFF3D00).withOpacity(0.1) : (bookingHistoryVM.bookingListvm[index].status! == "Valid")
                                                                    ? const Color(0xff416EF5).withOpacity(0.1) : (bookingHistoryVM.bookingListvm[index].status! == "Rejected")
                                                                    ? const Color(0xFFD50000).withOpacity(0.1) : const Color(0xff22AD00).withOpacity(0.1),
                                                                borderRadius: BorderRadius.circular(5)),
                                                            child: Center(
                                                                child: Text(
                                                                    "   ${bookingHistoryVM.bookingListvm[index].status}   ",
                                                                    style: TextStyle(
                                                                      fontFamily: "OpenSans",
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: MediaQuery.of(context).size.height/67,
                                                                      color: (bookingHistoryVM.bookingListvm[index].status == null) ? const Color(0xff22AD00)
                                                                          : (bookingHistoryVM.bookingListvm[index].status! == "Visited") ? const Color(0xFF24B500)
                                                                          : (bookingHistoryVM.bookingListvm[index].status! == "Expired") ? const Color(0xFFFF3D00)
                                                                          : (bookingHistoryVM.bookingListvm[index].status! == "Valid") ? const Color(0xff416EF5)
                                                                          : (bookingHistoryVM.bookingListvm[index].status! == "Rejected") ? const Color(0xFFD50000)
                                                                          : const Color(0xff22AD00).withOpacity(0.1),
                                                                    )))),
                                                      ],
                                                    ),
                                                    Text(bookingHistoryVM.bookingListvm[index].ePassName == null?"Special e-Pass":bookingHistoryVM.bookingListvm[index].ePassName.toString(),
                                                        style: TextStyle(
                                                            fontFamily: "OpenSans",
                                                            fontSize: MediaQuery.of(context).size.height/60,
                                                            fontWeight: FontWeight.w700)),

                                                    Divider(thickness: 3, color: Colors.grey.withOpacity(0.2)),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        wordDifference("Booking ID: ",bookingHistoryVM.bookingListvm[index].bookingId ?? "-",context),
                                                        Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(bookingHistoryVM.bookingListvm[index].transactionDate.toString())),
                                                            style: TextStyle(
                                                                fontFamily: "OpenSans",
                                                                fontSize: MediaQuery.of(context).size.height/62,
                                                                fontWeight: FontWeight.w600))
                                                      ],
                                                    ),
                                                    wordDifference("Visit Date: ",DateFormat('dd-MM-yyyy').format(DateTime.parse(bookingHistoryVM.bookingListvm[index].visitDate!.toString())),context),
                                                    wordDifference("Time Slot: ",bookingHistoryVM.bookingListvm[index].timeSlot.toString(),context),
                                                    Divider(thickness: 3, color: Colors.grey.withOpacity(0.2)),
                                                    Row(
                                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        wordVerticalDifference("No. of Devotees","${bookingHistoryVM.bookingListvm[index].noOfVisitors}",context),
                                                        wordVerticalDifference("Total Amount","₹ ${bookingHistoryVM.bookingListvm[index].totalAmount!.toStringAsFixed(0)}/-",context),
                                                        MaterialButton(
                                                          color: Colors.orange.shade200,
                                                          onPressed: () async {
                                                            var selectedLang = ''.obs;
                                                            SharedPreferences pref = await SharedPreferences.getInstance();
                                                              String language =  pref.getString('language') ?? 'English';
                                                              if(language == "Marathi"){
                                                                selectedLang.value = "mr";
                                                                print(selectedLang);
                                                              }
                                                              else if(language == "English"){
                                                                selectedLang.value = "en";
                                                                print(selectedLang);
                                                              }


                                                            String ePassID = bookingHistoryVM.bookingListvm[index].ePassId.toString();
                                                            print(ePassID);
                                                            String encryptionKey = '8080808080808080';
                                                            final key = encrypt.Key.fromUtf8(encryptionKey);
                                                            final iv = encrypt.IV.fromUtf8(encryptionKey);
                                                            final encrypter =
                                                            encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
                                                            var encryptedInvoiceId = encrypter.encrypt(ePassID, iv: iv);
                                                            //var encryptedInvoiceId = encrypter.encrypt("46", iv: iv);
                                                            var encodedDecryptedUrl = Uri.encodeComponent(encryptedInvoiceId.base64).replaceAll('%20', '+');
                                                            print(encodedDecryptedUrl);
                                                            print("$encodedDecryptedUrl&lan=${selectedLang.value}");
                                                            Get.offAllNamed("/splDarshanPassView",arguments:"$encodedDecryptedUrl&lan=${selectedLang.value}");
                                                          },
                                                          child: const Text("Download e-Pass",style: TextStyle(fontFamily: "OpenSans",fontWeight: FontWeight.bold)))
                                                      ],
                                                    )
                                                  ],
                                                )))))),
                          ),
                        ],
                      ))))
      )
    );
  }
}