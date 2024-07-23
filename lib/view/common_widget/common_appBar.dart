import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import '../../modal/trustee_modal/delete_notification_modal.dart';
import '../../view_modal/trustee_vm/notification_vm.dart';
import '../dashboard/dashboard_view.dart';
import '../non_referral_pass/notification/notification_view.dart';

///To use common appBar everywhere in app
PreferredSizeWidget commonAppBar(String title)=>
    AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
          systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2),
        ),
        elevation: 0,
        leading:IconButton(
          onPressed: (){
            Get.back();
            Get.back();
          },
          icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 35,),
        ),
        title: Text(title,style: const TextStyle(
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
        ));

PreferredSizeWidget allNotification(String title)=>
    AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
          systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2),
        ),
        elevation: 0,
        leading:IconButton(
          onPressed: (){
            Get.offAllNamed("/dashBoard");
          },
          icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 35,),
        ),
        title: Text(title,style: const TextStyle(
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
        ));

///pass booking page appBar
PreferredSizeWidget commonDevoteePassAppBar(String title)=>
    AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
          systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2)),
        elevation: 0,
        leading:IconButton(
          onPressed: (){
           Get.offAllNamed('/dashBoard');
          },
          icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 35)),
        title: Text(title,style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: "OpenSans",
            color: Color(0xFFFFFFFF))),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFEC6019),Color(0xFFFEB148),Color(0xFFFEB148)]))));

///devotee Notification appBar
deleteNotification(BuildContext context) async {
  SharedPreferences preference =  await SharedPreferences.getInstance();
  String devoteeId = preference.getString("registrationId") ?? "";
  notificationVM.notificationDetails.clear();
  notificationVM.isLoading.value = true;
  for(int i=1;i<=notificationTotalPages!;i++) {
    await notificationVM.getnotificationData(i.toString(), "10", "",devoteeId, "4", context);
  }
  for(int i = 0; i<notificationVM.notificationDetails.length;i++){
    deleteAllList.add(DeleteNotificationModal(
        id: notificationVM.notificationDetails[i].id!,
        deletedBy: notificationVM.notificationDetails[i].userId!
    ));
    deleteNotificationVm.isLoading.value = true;
    await deleteNotificationVm.deleteNotification(DeleteNotificationModal(),notificationVM.notificationDetails[i].id!,notificationVM.notificationDetails[i].userId!,context);
  if(notificationVM.notificationDetails.isEmpty){
    deleteLoading = false;
  }
  }
}
bool deleteLoading = false;
PreferredSizeWidget notificationAppBar(String title,BuildContext context) =>
    AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
          systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2)),
        elevation: 0,
        leading:IconButton(
          onPressed: () async {
            SharedPreferences preference =  await SharedPreferences.getInstance();
            String devoteeId = preference.getString("registrationId") ?? "";
            notificationVM.notificationDetails.clear();
            notificationVM.isLoading.value = true;
            getNotificationCountVM.notificationCountList.clear();
            getNotificationCountVM.isLoading.value = true;
            await getNotificationCountVM.getNotificationCount(devoteeId);
            notificationVM.notificationDetails.clear();
            Get.offAllNamed('/dashBoard');
          },
          icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 35),
        ),
        actions: <Widget>[
          MaterialButton(
            textColor: Colors.white,
            onPressed: () async {
              SharedPreferences preference =  await SharedPreferences.getInstance();
              String devoteeId = preference.getString("registrationId") ?? "";
               deleteLoading = true;
              await deleteNotification(context);
              toastMessage(context, "notificationClear".tr);
              deleteLoading = false;
              notificationVM.notificationDetails.clear();
              notificationVM.isLoading.value = true;
              await notificationVM.getnotificationData("1", "10", "",devoteeId,"4",context);
            },
            shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
            child: Text("clear".tr)),
        ],
        title: Text(title,style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: "OpenSans",
            color: Color(0xFFFFFFFF))),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFEC6019),Color(0xFFFEB148),Color(0xFFFEB148)]))));

PreferredSizeWidget webviewAppBar(String title)=>
    AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
          systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2),
        ),
        elevation: 0,
        leading:IconButton(
          onPressed: (){
            Get.offAllNamed("/dashBoard");
            },
          icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 35),
        ),
        title: Text(title,style: const TextStyle(
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
        ));



