import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../view_modal/trustee_vm/get_notificationCountVm.dart';
import '../../non_referral_pass/notification/notification_view.dart';
import '../dashboard_view.dart';



///Mute unMute functionality
class MuteFuction extends StatefulWidget {
  const MuteFuction({Key? key}) : super(key: key);

  @override
  State<MuteFuction> createState() => _MuteFuctionState();
}
class _MuteFuctionState extends State<MuteFuction> {
  audioMuteUnmute() async {
    if (isMute == true) {
      setState(() {
        assetsAudioPlayer.stop();
      });
    } else if (isMute == false) {
      setState(() {
        assetsAudioPlayer.stop();
        assetsAudioPlayer.open(
          Audio("assets/Sarva Mangala Mangalye.mp3"),
          loopMode: LoopMode.playlist,
          volume: 100,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        setState(() {
          isMute = !isMute;
          preferences.setBool('isMute', isMute);
          audioMuteUnmute();
        });
      },
      child: CircleAvatar(
          radius: MediaQuery.of(context).size.height / 50,
          backgroundColor: const Color(0xFFE23500).withOpacity(0.3),
          child: isMute
              ? Icon(
                  Icons.volume_off,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height / 36,
                )
              : Icon(
                  Icons.volume_up,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height / 36,
                )),
    );
  }
}

/// Dashboard AppBar
PreferredSizeWidget dashboardAppBar(BuildContext context) => AppBar(
      titleSpacing: MediaQuery.of(context).size.width / 30,
      leadingWidth: MediaQuery.of(context).size.width / 11,
      leading: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 70),
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.0),
          child: const Image(
              image: AssetImage(
                  'assets/images/dashboard/tuljabhavaniwhitelogo.png')),
        ),
      ),
      toolbarHeight: MediaQuery.of(context).size.height / 14,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Color(0xFFEC6019),
              Color(0xFFFEB148),
              Color(0xFFFEB148)
            ])),
      ),
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          // statusBarColor: Color(0xFFF5F6F9),
          statusBarColor: const Color(0xFFFEB148).withOpacity(0.1),
          systemNavigationBarColor: Colors.transparent),
      backgroundColor: const Color(0xFFF5F6F9),
      elevation: 0,
      title: dashTitleWidget(context),
      actions: [
        const MuteFuction(),
        SizedBox(width: MediaQuery.of(context).size.width / 40),
        drawerLogin == true
            ? GestureDetector(
                onTap: () {
                  notificationVM.notificationDetails.clear();
                  Get.offAllNamed("/devoteeNotificationScreen");
                },
                child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height / 50,
                    backgroundColor: const Color(0xFFE23500).withOpacity(0.3),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(Icons.notifications,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.height / 40),
                        ),
                        notificationCount == 0
                            ? const Text("")
                            : Container(
                                width: MediaQuery.of(context).size.width / 12,
                                height: MediaQuery.of(context).size.height / 12,
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height /
                                        65),
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 26,
                                    height:
                                        MediaQuery.of(context).size.height / 35,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xffc32c37),
                                        border: Border.all(
                                            color: Colors.white, width: 1)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(0.1),
                                        child: Center(
                                            child: Center(
                                                child: Obx(
                                          () => getNotificationCountVM
                                                      .isLoading.value ==
                                                  true
                                              ? const Text("")
                                              : Text("$notificationCount",
                                                  style: const TextStyle(
                                                      fontSize: 6,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                        )))))),
                      ],
                    )),
              )
            : const SizedBox.shrink(),
        drawerLogin == true
            ? SizedBox(width: MediaQuery.of(context).size.width / 40)
            : const SizedBox.shrink(),
        GestureDetector(
          onTap: () {
            key.currentState!.openEndDrawer();
          },
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.height / 45,
            backgroundColor: const Color(0xFFE23500).withOpacity(0.3),
            child: const Icon(
              Icons.menu,
              size: 19,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 40),
      ],
    );

/// Dashboard AppBar Title
Widget dashTitleWidget(BuildContext context) => Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 100),
      child: Text(
        'deviName'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height / 50,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold),
      ),
    );

/// Dashboard Devi image slider
Widget imageWidget(BuildContext context) => Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 38,
        right: MediaQuery.of(context).size.width / 38,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: CarouselSlider(
            items: appSliderVM.imageDetails
                .map((item) => Container(
                    height: MediaQuery.of(context).size.height / 4.7,
                    width: MediaQuery.of(context).size.width,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(
                      item.imagePath!,
                      fit: BoxFit.fill,
                      scale: 1,
                      colorBlendMode: BlendMode.darken,
                      filterQuality: FilterQuality.high,
                      alignment: Alignment.center,
                    )))
                .toList(),
            options: CarouselOptions(
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1.3,
              initialPage: 0,
              enableInfiniteScroll:
                  appSliderVM.imageDetails.length == 1 ? false : true,
              reverse: false,
              autoPlay: appSliderVM.imageDetails.length == 1 ? false : true,
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: false,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              scrollDirection: Axis.horizontal,
            )),
      ),
    );

///Online darshan,online donation,abhishek pooja, sinhasan pooja webview
Widget dashboardNavigationContainer(BuildContext context,
        {String imageIconPath = '',
        String imageIconText = 'Post Grievance',
        Color color = Colors.red}) =>
    Container(
      height: MediaQuery.of(context).size.height / 17,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color(0xFFFC7F72).withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              offset: const Offset(0, 0),
              blurRadius: 3,
              blurStyle: BlurStyle.outer,
            )
          ]),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 17,
          ),
          Center(
              child: SvgPicture.asset(imageIconPath,
                  height: MediaQuery.of(context).size.height / 23)),
          SizedBox(
            width: MediaQuery.of(context).size.width / 20,
          ),
          Center(
            child: Text(
              imageIconText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color(0xFF494949),
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.height / 62),
            ),
          )
        ],
      ),
    );



