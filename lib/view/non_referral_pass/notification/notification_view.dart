import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../firebase_notification_service/firebase_noti_service.dart';
import '../../../modal/trustee_modal/delete_notification_modal.dart';
import '../../../modal/trustee_modal/update_notificationCount_modal.dart';
import '../../../view_modal/trustee_vm/delete_notificationVm.dart';
import '../../../view_modal/trustee_vm/get_notificationCountVm.dart';
import '../../../view_modal/trustee_vm/notificationFlag_vm.dart';
import '../../../view_modal/trustee_vm/notification_vm.dart';
import '../../common_widget/common_appBar.dart';
import '../../common_widget/progress_indicator.dart';
import '../../common_widget/snack_bar.dart';
import '../../dashboard/dashboard_view.dart';




List<DeleteNotificationModal> deleteAllList = [];
class Model {
  String id = UniqueKey().toString();
  int index = 0;

  @override
  String toString() {
    return index.toString();
  }
}
class DevoteeNotificationScreen extends StatefulWidget {
  const DevoteeNotificationScreen({Key? key}) : super(key: key);

  @override
  State<DevoteeNotificationScreen> createState() => _DevoteeNotificationScreenState();
}


NotificationVM notificationVM = Get.put(NotificationVM());
DeleteNotificationVm deleteNotificationVm = Get.put(DeleteNotificationVm());
NotificationFlagCountVm notificationFlagCountVm = Get.put(NotificationFlagCountVm());

class _DevoteeNotificationScreenState extends State<DevoteeNotificationScreen> {


  List<UpdateNotificationCountModal> updateCountData = [];
  void getAPIMethod()async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String devoteeId = preference.getString("registrationId") ?? "";
    _hasNextPage =true;
    _page = 1;
    notificationVM.notificationDetails.clear();
    notificationVM.isLoading.value = true;
    await notificationVM.getnotificationData(_page.toString(), "10", "",devoteeId,"4",context);
    for(int i = 0; i<notificationVM.notificationDetails.length;i++){
      updateCountData.add(UpdateNotificationCountModal(
          id: notificationVM.notificationDetails[i].id!,
          userId: notificationVM.notificationDetails[i].userId!
      ));
      // print(updateCountData[i].id!);
      notificationFlagCountVm.isLoading.value = true;
      await notificationFlagCountVm.putNotificationFlag(updateCountData[i].id!,int.parse(devoteeId));
      if (_page == notificationTotalPages!) {
        setState(() {
          _hasNextPage = false;
        });
      }    }
  }

  List<Model> list = List.generate(500, (index) {
    return Model()..index = index;
  });

  late SwipeActionController controller;

  ///Pagination
  int _page = 1;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;

  void _loadMore() async {
    SharedPreferences preference =  await SharedPreferences.getInstance();
    String devoteeId = preference.getString("registrationId") ?? "";
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;
      try {

        await notificationVM.getnotificationData(_page.toString(),
            "10", "",devoteeId,"4",context);
        for(int j = 0;j<notificationVM.notificationDetails.length;j++){
          updateCountData.add(UpdateNotificationCountModal(
              id: notificationVM.notificationDetails[j].id!,
              userId: notificationVM.notificationDetails[j].userId!
          ));
          //print(updateCountData[j].id!);
          notificationFlagCountVm.isLoading.value = true;
          await notificationFlagCountVm.putNotificationFlag(updateCountData[j].id!,updateCountData[j].userId!);
        }
        if (_page == notificationTotalPages!) {
          setState(() {
            _hasNextPage = false;
            deleteNotificationVm.notiDeleteLists.clear();
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

  void firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      {
        Timer(const Duration(milliseconds: 800), () async {
          SharedPreferences preference =  await SharedPreferences.getInstance();
          String devoteeId = preference.getString("registrationId") ?? "";
          notificationVM.notificationDetails.clear();
          notificationVM.isLoading.value = true;
          await notificationVM.getnotificationData(_page.toString(),
              "10", "",devoteeId,'4',context);
          for(int i = 0; i<notificationVM.notificationDetails.length;i++){
            updateCountData.add(UpdateNotificationCountModal(
                id: notificationVM.notificationDetails[i].id,
                userId: notificationVM.notificationDetails[i].userId
            ));
           // print(updateCountData[i].id!);
            notificationFlagCountVm.isLoading.value = true;
            await notificationFlagCountVm.putNotificationFlag(updateCountData[i].id!,updateCountData[i].userId!);
          }
          if (_page == notificationTotalPages!) {
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
  late ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  print("===$notificationCount");
    flutterLocalNotificationsPlugin.cancelAll();
    firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
    deleteLoading = false;

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SharedPreferences preference =  await SharedPreferences.getInstance();
        String devoteeId = preference.getString("registrationId") ?? "";
        deleteNotificationVm.notiDeleteLists.clear();
        notificationVM.notificationDetails.clear();
        notificationVM.isLoading.value = true;
        getNotificationCountVM.notificationCountList.clear();
        getNotificationCountVM.isLoading.value = true;
        await getNotificationCountVM.getNotificationCount(devoteeId);
        notificationVM.notificationDetails.clear();
        deleteNotificationVm.notiDeleteLists.clear();
        // Get.back();
        Get.offAllNamed('/dashBoard');
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          resizeToAvoidBottomInset: false,
          appBar: notificationAppBar("notificationAppBarTitle".tr,context),
          body:Obx(
              ()=> ModalProgressHUD(
              inAsyncCall:notificationVM.isLoading.value == true &&
                  notificationFlagCountVm.isLoading.value == true || deleteLoading == true,
              progressIndicator: progressIndicator(),
              child:   NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return true;
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height/80),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/80),
                      Expanded(child:
                      RefreshIndicator(
                        color: Colors.deepOrange.shade600,
                        onRefresh: (){
                          return Future.delayed(const Duration(seconds: 1),(){
                            setState(() {
                              getAPIMethod();
                            });
                          });
                        },
                        child: ListView.builder(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    controller: _controller,
                                    reverse: false,
                                    scrollDirection: Axis.vertical,
                                    clipBehavior: Clip.hardEdge,
                                    itemCount: notificationVM.notificationDetails.length,
                                    itemBuilder: (context, index) {
                                      return _item(context, index);
                                    },
                                  ),
                                ),
                              ),

                              if (_isLoadMoreRunning == true)
                              Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                        height: MediaQuery.of(context).size.height/40,
                        width:MediaQuery.of(context).size.width/20,
                        child: const CircularProgressIndicator(color: Colors.deepOrange,strokeWidth:3,
                        ),
                        ),
                        ))


                    ],
                  ),
                ),
              ),
            ),
          )



        /*Obx(()=> notificationVM.isLoading.value == true &&
              notificationFlagCountVm.isLoading.value == true || deleteLoading == true? Center(
              child: progressIndicator())
              :   NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll){
              overScroll.disallowIndicator();
              return true;
            },
                child: RefreshIndicator(
            color: Colors.deepOrange.shade600,
            onRefresh: (){
                return Future.delayed(const Duration(seconds: 1),(){
                  setState(() {
                    getAPIMethod();
                  });
                });
            },
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/1.18,
                  child: Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/100),
                    child: Stack(
                      children: [
                        SizedBox(
                          height:MediaQuery.of(context).size.height/1.1 ,
                          child: notificationVM.notificationDetails.isEmpty?Center(child: Text("noDataFound".tr)):
                          ListView.builder(
                            clipBehavior: Clip.hardEdge,
                            controller: _controller,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: notificationVM.notificationDetails.length,
                            itemBuilder: (context, index) {
                              return _item(context, index);
                            },
                          ),
                        ),
                        if (_isLoadMoreRunning == true)
                          Center(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height/40,
                              width:MediaQuery.of(context).size.width/20,
                              child: const CircularProgressIndicator(color: Colors.deepOrange,strokeWidth:3,
                              ),
                            ),
                          ))

                      ],
                    ),
                  ),
                ),
            ),
          ),
              ),
          )*/),
    );
  }
  Widget _item(BuildContext ctx, int index) {
    return SwipeActionCell(
        index: index,

        // Required!
        key: ValueKey(list[index]),
        backgroundColor: Colors.grey.shade200,
        // Animation default value below
        // deleteAnimationDuration: 400,
        selectedForegroundColor: Colors.black.withAlpha(30),
        trailingActions: [
          SwipeAction(
              color: Colors.orange.shade600,
              widthSpace: MediaQuery.of(context).size.width/3,
              icon: Center(child: Column(
                children: [
                  const Icon(Icons.delete_forever),
                  Text("delete".tr,style: const TextStyle(fontFamily: "OpenSans"))
                ],
              )),
              performsFirstActionWithFullSwipe: true,
              onTap: (handler) async {
                SharedPreferences preference =  await SharedPreferences.getInstance();
                String devoteeId = preference.getString("registrationId") ?? "";
                await handler(true);
                list.removeAt(index);
                deleteNotificationVm.notiDeleteLists.clear();
                deleteNotificationVm.isLoading.value = true;
                await deleteNotificationVm.deleteNotification(DeleteNotificationModal(),notificationVM.notificationDetails[index].id!, int.parse(devoteeId), context);
                toastMessage(context, "notificationDelete".tr);
                await notificationVM.getnotificationData(_page.toString(), "10", "",devoteeId,"4", context);
                print(notificationVM.notificationDetails.length);
              }),
          // SwipeAction(title: "action2", color: Colors.grey, onTap: (handler) {}),
        ],

        child: GestureDetector(
            onTap: (){
              print(notificationVM.notificationDetails[index].id);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/80),
              child: Column(
                children: [

                  Card(
                      margin: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Expanded(
                              flex:1,
                              child:Center(
                                  child: Opacity(
                                      opacity: 0.6,
                                      child: Container(
                                          child: SvgPicture.asset("assets/images/dashboard/mandir.svg",
                                            height: MediaQuery.of(context).size.height/30,)
                                      )))),
                          Expanded(
                            flex:7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/30,
                                        top:MediaQuery.of(context).size.height/70),
                                    child: SizedBox(
                                        width: MediaQuery.of(context).size.width/1,
                                        child: Text(notificationVM.notificationDetails[index].reason!.toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.height/55,
                                                fontFamily: "OpenSans",
                                                color: const Color(0xFF3F3F3F))))),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: MediaQuery.of(context).size.width/100),
                                        notificationVM.notificationDetails[index].title== null?const Text("-"): Text(" ${notificationVM.notificationDetails[index].title!}",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height/55,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFEC6019),
                                              fontFamily: "OpenSans"),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${DateFormat('dd/MM/yyyy').format(DateTime.parse((notificationVM.notificationDetails[index].addedDate!.toString())))} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: MediaQuery.of(context).size.height/70,
                                          fontFamily: "OpenSans",
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height/100),
                              ],
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height/100),

                ],
              ),
            )));
  }
}