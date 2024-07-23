import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';

import 'devotee_details_design.dart';

PreferredSizeWidget devoteeDetailsAppBar(String title,BuildContext context) =>
    AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
            systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2)),
        elevation: 0,
        leading:IconButton(
          onPressed: () async {
            Get.offAllNamed("/dashBoard");
          },
          icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 30),
        ),
        actions: <Widget>[
          GestureDetector(
                        onTap: () async {
                          showDialog(
                              barrierDismissible: false,
                              barrierColor: Colors.transparent.withOpacity(0.5),

                              context: context,

                              builder: (_) =>

                                  AlertDialog(
                                    titlePadding: EdgeInsets.zero,
                                    contentPadding:  EdgeInsets.zero,
                                    content: SizedBox(
                                      height: MediaQuery.of(context).size.height/4.3,
                                      width: MediaQuery.of(context).size.width/1.15 ,
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.symmetric(
                                                    horizontal: MediaQuery.of(context).size.width/20,
                                                    vertical: MediaQuery.of(context).size.height /80
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Text("cancelBooking".tr,
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
                                                        child: const Icon(Icons.cancel_outlined,color: Colors.redAccent,))
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
                                            padding:  EdgeInsets.symmetric(
                                                horizontal: MediaQuery.of(context).size.width/20,
                                                vertical: MediaQuery.of(context).size.height /50
                                            ),
                                            child: Text("cancelBookingMsg".tr),
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height /40,),
                                          Padding(
                                            padding:EdgeInsets.symmetric(
                                                horizontal: MediaQuery.of(context).size.width/20,

                                            ),
                                            child: Row(
                                              children: [
                                                Spacer(),
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
                                                                  color: Colors.grey.withOpacity(0.5), // Adjust shadow color and opacity
                                                                  spreadRadius: 2, // Adjust the spread radius
                                                                  blurRadius: 5, // Adjust the blur radius
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
                                                                    color: Colors.black),
                                                              )),
                                                        ))
                                                ),
                                                SizedBox(width: MediaQuery.of(context).size.width /30),
                                                GestureDetector(
                                                    onTap: () async {
                                                      SharedPreferences preferences = await SharedPreferences.getInstance();
                                                      await cancelSplePassBookingVM.cancelBookingRecord(visitDateAndTimeDetailsVM.devoteeID!,context);
                                                      if(cancelSplePassBookingVM.statusCode == "200"){
                                                        toastMessage(context, "toastCancelBooking".tr);
                                                        preferences.remove("isPassGenerated");
                                                        Get.offAllNamed("/nonReferralPassBooking");
                                                      }
                                                      else{
                                                        toastMessage(context, 'wentWrong'.tr);
                                                      }
                                                    },
                                                    child: Center(
                                                        child: Container(
                                                          height: MediaQuery.of(context).size.height /28,
                                                          width: MediaQuery.of(context).size.width /5.5,
                                                          decoration:  BoxDecoration(
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
                                                              gradient:  const LinearGradient(
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
                                                                    color: Colors.white),
                                                              )),
                                                        ))
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                  ));




                },
                child: Center(
                child: Container(
                height: MediaQuery.of(context).size.height /29,
                width: MediaQuery.of(context).size.width /4.1,
                decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                BoxShadow(
                color: Colors.orange, // Adjust shadow color and opacity
                spreadRadius: 1, // Adjust the spread radius
                blurRadius: 5, // Adjust the blur radius
                offset: Offset(0, 3), // Adjust the offset
                ),
                ],
                borderRadius: BorderRadius.circular(5)),
                child: Center(
                child: Text(
                "cancelBooking".tr,
                style: TextStyle(
                fontSize: MediaQuery.of(context).size.height /72,
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans",
                color: Colors.black),
                )),
                )),
                ),
          SizedBox(width: MediaQuery.of(context).size.width /50),
        ],
        title: Text(title,style:  TextStyle(
            fontSize: MediaQuery.of(context).size.height/47,
            fontWeight: FontWeight.w700,
            fontFamily: "OpenSans",
            color: Color(0xFFFFFFFF))),
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFFEC6019),Color(0xFFFEB148),Color(0xFFFEB148)]))));