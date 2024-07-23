import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/view/non_referral_pass/spl_donation_epass_details/devotee_details_design.dart';

///Dashboard Bottom Navigation Bar Design and Functionality

int? bottomIndex;

class BottomNavigationBarClass extends StatefulWidget {
  const BottomNavigationBarClass({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarClass> createState() =>
      _BottomNavigationBarClassState();
}

class _BottomNavigationBarClassState extends State<BottomNavigationBarClass> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bottomIndex = 2;
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      animationCurve: Curves.linear,
      index: bottomIndex!,
      height: MediaQuery.of(context).size.height / 14.5,
      items: <Widget>[
        bottomNavigationItem(context,
            imgPath: "assets/images/dashboard/NewAbout.svg",
            height: MediaQuery.of(context).size.height / 40,
            name: "aboutUs".tr,
            color: Colors.deepOrange.shade600.withOpacity(0.7)),
        bottomNavigationItem(context,
            imgPath: "assets/images/dashboard/NewContact.svg",
            height: MediaQuery.of(context).size.height / 45,
            name: "contact".tr,
            color: Colors.deepOrange.shade600.withOpacity(0.7)),
        bottomIndex == 4
            ? bottomNavigationItem(context,
                imgPath: "assets/images/dashboard/Namaste.svg",
                height: MediaQuery.of(context).size.height / 45,
                name: "login".tr,
                color: Colors.deepOrange.shade600.withOpacity(0.7))
            : bottomNavigationItemLogin(context,
                imgPath: "assets/images/dashboard/Namaste.svg",
                height: MediaQuery.of(context).size.height / 30,
                name: "login".tr,
                color: Colors.white),
        bottomNavigationItem(context,
            imgPath: "assets/images/dashboard/NewLanguage.svg",
            height: MediaQuery.of(context).size.height / 45,
            name: "languageSetting".tr,
            color: Colors.deepOrange.shade600.withOpacity(0.7)),
        bottomIndex == 4
            ? bottomNavigationItemLogin(context,
                imgPath: "assets/images/dashboard/NewShare.svg",
                height: MediaQuery.of(context).size.height / 30,
                name: "shareBtn".tr,
                color: Colors.white)
            : bottomNavigationItem(context,
                imgPath: "assets/images/dashboard/NewShare.svg",
                height: MediaQuery.of(context).size.height / 45,
                name: 'shareBtn'.tr,
                color: Colors.deepOrange.shade600.withOpacity(0.7)),
      ],
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Colors.orange,
      onTap: (int index) async {
        setState(() {
          bottomIndex = index;
        });
        switch (index) {
          case 0:
            Get.offAllNamed("/aboutTemple");
            break;
          case 1:
            Get.offAllNamed("/contactUs");
            break;
          case 2:
            {
              SharedPreferences preference =
                  await SharedPreferences.getInstance();
              bool isLogin = preference.getBool("isRegister") ?? false;
              String? mobileNo = preference.getString("mob");
              if (isLogin == true) {
                bool isPassGenerated =
                    preference.getBool("isPassGenerated") ?? false;
                if (isPassGenerated == true) {
                  visitDateAndTimeDetailsVM.visitDateAndTimeDetailsList.clear();
                  visitDateAndTimeDetailsVM.isLoading.value = true;
                  await visitDateAndTimeDetailsVM
                      .getVisitDateTimeDetails(mobileNo!);
                  if (visitDateAndTimeDetailsVM.isExpired == 8) {
                    preference.remove("isPassGenerated");
                    Get.offAllNamed("/nonReferralPassBooking");
                  } else {
                    Get.offAllNamed("/splePassDetailsView");
                  }
                } else {
                  Get.offAllNamed("/nonReferralPassBooking");
                }
              } else {
                Get.offAllNamed("/darshanPassLogin");
              }
            }

            break;
          case 3:
            Get.offAllNamed("/chooseLanguage");
            break;
          case 4:
            {
              await Share.share(
                "https://play.google.com/store/apps/details?id=com.epass.tuljapur",
              );
              setState(() {
                bottomIndex = 2;
              });
            }
            break;
        }
      },
    );
  }
}

Widget bottomNavigationItem(
  BuildContext context, {
  String imgPath = "",
  String name = "home",
  double height = 35,
  Color color = Colors.orangeAccent,
}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 70,
        ),
        SvgPicture.asset(imgPath, height: height, color: color),
        SizedBox(
          height: MediaQuery.of(context).size.height / 150,
        ),
        Text(
          name,
          style: TextStyle(
              color: Colors.black,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.height / 80),
        ),
      ],
    );

Widget bottomNavigationItemLogin(
  BuildContext context, {
  String imgPath = "",
  String name = "home",
  double height = 35,
  Color color = Colors.orangeAccent,
}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(imgPath, height: height, color: color),
      ],
    );
