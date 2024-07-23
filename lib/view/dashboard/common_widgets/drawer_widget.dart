import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import '../../../view_modal/logout_vm.dart';
import '../../non_referral_pass/transaction_history/transaction_history.dart';
import '../dashboard_view.dart';

///Dashboard Drawer Design and Functionality

LogoutViewModal logoutViewModal = Get.put(LogoutViewModal());

Widget mainDashboardDrawer(BuildContext context) => Container(
    color: Colors.white,
    width: MediaQuery.of(context).size.width / 1.45,
    height: MediaQuery.of(context).size.height,
    child: Drawer(
        child: Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 20,
        top: MediaQuery.of(context).size.height / 40,
        right: MediaQuery.of(context).size.width / 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 35,
                right: MediaQuery.of(context).size.width / 60),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.cancel,
                color: Colors.orange,
                size: MediaQuery.of(context).size.height / 30,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 40,
          ),
          Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 100,
              ),
              child: Center(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    child: const Image(
                      image: AssetImage(
                          "assets/images/dashboard/Tuljapurlogo_new1.png"),
                      fit: BoxFit.cover,
                    )),
              )),
          SizedBox(height: MediaQuery.of(context).size.height / 60),
          Center(
            child: Text(
              'templeTitlenew'.tr,
              style: TextStyle(
                  fontFamily: "OpenSans",
                  wordSpacing: 2,
                  fontSize: MediaQuery.of(context).size.height / 50,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF444444)),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 90),
          const Divider(
            thickness: 2,
            color: Colors.orange,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),

          ///About Temple
          drawerLogin == false
              ? GestureDetector(
                  onTap: () async {
                    Get.offAllNamed("/aboutTemple");
                  },
                  child: drawerTextWidget(context,
                      imgPath: "assets/images/dashboard/About temple.svg",
                      color: Colors.orange,
                      name: 'aboutTemple'.tr))
              : const SizedBox.shrink(),
          drawerLogin == false
              ? SizedBox(height: MediaQuery.of(context).size.height / 60)
              : const SizedBox.shrink(),

          ///Devotee Login
          drawerLogin == false
              ? GestureDetector(
                  onTap: () {
                    Get.offAllNamed("/darshanPassLogin");
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 20,
                    color: const Color(0xFFF5EBEA),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 36,
                            width: MediaQuery.of(context).size.width / 18,
                            child: SvgPicture.asset(
                                "assets/images/dashboard/Namaste.svg")),
                        const SizedBox(width: 15),
                        Text(
                          'devoteeLogin'.tr,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 50,
                              fontFamily: "OpenSans",
                              color: const Color(0xFF444444)),
                        )
                      ],
                    ),
                  ))
              : const SizedBox.shrink(),
          drawerLogin == false
              ? SizedBox(height: MediaQuery.of(context).size.height / 60)
              : const SizedBox.shrink(),

          ///Validator Login
          drawerLogin == false
              ? GestureDetector(
                  onTap: () {
                    Get.offAllNamed("/loginView");
                  },
                  child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      color: const Color(0xFFF5EBEA),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 36,
                              width: MediaQuery.of(context).size.width / 18,
                              child: SvgPicture.asset(
                                  "assets/images/dashboard/NewLogin icon.svg")),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'validatorLogin'.tr,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 50,
                                fontFamily: "OpenSans",
                                color: const Color(0xFF444444)),
                          )
                        ],
                      )))
              : const SizedBox.shrink(),
          drawerLogin == false
              ? SizedBox(height: MediaQuery.of(context).size.height / 60)
              : const SizedBox.shrink(),

          ///Contact Temple
          drawerLogin == false
              ? GestureDetector(
                  onTap: () async {
                    Get.offAllNamed("/contactUs");
                  },
                  child: drawerTextWidget(context,
                      imgPath: "assets/images/dashboard/NewContact.svg",
                      color: Colors.orange,
                      name: 'contact'.tr))
              : const SizedBox.shrink(),
          drawerLogin == false
              ? SizedBox(height: MediaQuery.of(context).size.height / 60)
              : const SizedBox.shrink(),

          ///setting
          drawerLogin == false
              ? GestureDetector(
                  onTap: () {
                    Get.offAllNamed("/chooseLanguage");
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 20,
                    color: const Color(0xFFF5EBEA),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 36,
                            width: MediaQuery.of(context).size.width / 18,
                            child: SvgPicture.asset(
                                "assets/images/dashboard/language.svg")),
                        const SizedBox(width: 15),
                        Text(
                          'languageSetting'.tr,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 50,
                              fontFamily: "OpenSans",
                              color: const Color(0xFF444444)),
                        )
                      ],
                    ),
                  ))
              : const SizedBox.shrink(),
          drawerLogin == true
              ? SizedBox(height: MediaQuery.of(context).size.height / 60)
              : const SizedBox.shrink(),

          ///Devotee Profile
          drawerLogin == true
              ? GestureDetector(
                  onTap: () {
                    Get.offAllNamed("/devoteeProfile");
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 20,
                    color: const Color(0xFFF5EBEA),
                    child: Row(
                      children: [
                        const SizedBox(width: 5),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 36,
                            width: MediaQuery.of(context).size.width / 18,
                            child: SvgPicture.asset(
                                "assets/images/dashboard/NewLogin icon.svg")),
                        const SizedBox(width: 15),
                        Text(
                          'myProfile'.tr,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 50,
                              fontFamily: "OpenSans",
                              color: const Color(0xFF444444)),
                        )
                      ],
                    ),
                  ))
              : const SizedBox.shrink(),
          drawerLogin == true
              ? SizedBox(height: MediaQuery.of(context).size.height / 60)
              : const SizedBox.shrink(),

          ///Devotee history
          drawerLogin == true
              ? GestureDetector(
                  onTap: () {
                    bookingHistoryVM.bookingListvm.clear();
                    Get.offAllNamed("/transactionHistory");
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 20,
                    color: const Color(0xFFF5EBEA),
                    child: Row(
                      children: [
                        const SizedBox(width: 5),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 36,
                            width: MediaQuery.of(context).size.width / 18,
                            child: SvgPicture.asset(
                              "assets/images/dashboard/Reports.svg",
                            )),
                        const SizedBox(width: 15),
                        Text(
                          'transactionHistory'.tr,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 50,
                              fontFamily: "OpenSans",
                              color: const Color(0xFF444444)),
                        )
                      ],
                    ),
                  ))
              : const SizedBox.shrink(),



          SizedBox(height: MediaQuery.of(context).size.height / 60),
          ///Help
          GestureDetector(
              onTap: () {
                Get.offAllNamed("/pdfViewer");
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                color: const Color(0xFFF5EBEA),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 36,
                        width: MediaQuery.of(context).size.width / 18,
                        child: SvgPicture.asset(
                          "assets/images/dashboard/Reports.svg",
                        )),
                    const SizedBox(width: 15),
                    Text(
                      'help'.tr,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 50,
                          fontFamily: "OpenSans",
                          color: const Color(0xFF444444)),
                    )
                  ],
                ),
              )),


          drawerLogin == true
              ? SizedBox(height: MediaQuery.of(context).size.height / 60)
              : const SizedBox.shrink(),
          ///Devotee Logout
          drawerLogin == true
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        barrierColor: Colors.transparent.withOpacity(0.5),
                        context: context,
                        builder: (_) => AlertDialog(
                            titlePadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.zero,
                            content: SizedBox(
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 1.15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              vertical: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  80),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "logOutBtnText".tr,
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            45,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "OpenSans",
                                                    color: Colors.black),
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: const Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.redAccent,
                                                  ))
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
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              50),
                                      child: Text("logoutAlert".tr),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              40,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                        ),
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Center(
                                                    child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      28,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5.5,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          // Adjust shadow color and opacity
                                                          spreadRadius: 2,
                                                          // Adjust the spread radius
                                                          blurRadius: 5,
                                                          // Adjust the blur radius
                                                          offset: const Offset(
                                                              0,
                                                              3), // Adjust the offset
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24)),
                                                  child: Center(
                                                      child: Text(
                                                    "No".tr,
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            65,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: "OpenSans",
                                                        color: Colors.black),
                                                  )),
                                                ))),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                            ),
                                            GestureDetector(
                                                onTap: () async {
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? logoutId =
                                                      preferences.getString(
                                                              "registrationId") ??
                                                          "0";
                                                  await logoutViewModal
                                                      .logoutCurrentUser(
                                                          logoutId,
                                                          "4",
                                                          context);
                                                  if (logoutViewModal
                                                          .statusCode ==
                                                      "200") {
                                                    toastMessage(context,
                                                        "LogoutToast".tr);
                                                    Get.back();
                                                    Get.back();
                                                    drawerLogin = false;
                                                    await preferences.setBool('hasShownPopUp', false);
                                                    preferences.remove('mob');
                                                    preferences
                                                        .remove('devoteeId');
                                                    preferences.remove(
                                                        'isPassGenerated');
                                                    preferences
                                                        .remove('isRegister');
                                                    preferences.remove(
                                                        'registrationId');
                                                  } else {
                                                    toastMessage(context,
                                                        "Please try again");
                                                  }
                                                },
                                                child: Center(
                                                    child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            28,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            5.5,
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.3),
                                                                // Adjust shadow color and opacity
                                                                spreadRadius: 2,
                                                                // Adjust the spread radius
                                                                blurRadius: 5,
                                                                // Adjust the blur radius
                                                                offset: const Offset(
                                                                    0,
                                                                    3), // Adjust the offset
                                                              ),
                                                            ],
                                                            gradient: const LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                      0xFFFEB349),
                                                                  Color(
                                                                      0xFFFEB349),
                                                                  Color(
                                                                      0xFFE74E0E)
                                                                ],
                                                                begin: Alignment
                                                                    .centerLeft,
                                                                end: Alignment
                                                                    .centerRight),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24)),
                                                        child: Center(
                                                            child: Text(
                                                          "Yes".tr,
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  65,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "OpenSans",
                                                              color:
                                                                  Colors.white),
                                                        ))))),
                                          ],
                                        ))
                                  ],
                                ))));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 20,
                    color: const Color(0xFFF5EBEA),
                    child: Row(
                      children: [
                        const SizedBox(width: 5),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 36,
                            width: MediaQuery.of(context).size.width / 18,
                            child: SvgPicture.asset(
                                "assets/images/MapDesign/Logout.svg")),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'logOutBtnText'.tr,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 50,
                              fontFamily: "OpenSans",
                              color: const Color(0xFF444444)),
                        )
                      ],
                    ),
                  ))
              : const SizedBox.shrink(),



          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Powered By : ",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 80,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              Image(
                  image: const AssetImage("assets/images/STPL_Logo.png"),
                  height: MediaQuery.of(context).size.height / 40)
            ],
          ),
          Center(
              child: Text("Version : 1.0.3",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 80,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ))),

          SizedBox(height: MediaQuery.of(context).size.height / 40),
        ],
      ),
    )));

Widget drawerTextWidget(BuildContext context,
        {String imgPath = "assets/images/dashboard/language setting.svg",
        Color color = Colors.white,
        String name = "profile"}) =>
    Container(
      height: MediaQuery.of(context).size.height / 20,
      color: const Color(0xFFF5EBEA),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height / 36,
              width: MediaQuery.of(context).size.width / 18,
              child: SvgPicture.asset(imgPath,
                  color: color,
                  height: MediaQuery.of(context).size.height / 40)),
          const SizedBox(
            width: 15,
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 50,
                fontFamily: "OpenSans",
                color: const Color(0xFF444444)),
          )
        ],
      ),
    );
