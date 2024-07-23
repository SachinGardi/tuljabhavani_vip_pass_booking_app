import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view_modal/app_slider_vm.dart';
import '../../view_modal/spl_donation_epass_vm/spl_epass_add_details_vm/visitdate_time_deatils_vm.dart';
import '../../view_modal/trustee_vm/get_notificationCountVm.dart';
import '../../view_modal/trustee_vm/get_notificationVm_forall.dart';
import '../../view_modal/trustee_vm/notificationFlag_vm.dart';
import '../../view_modal/trustee_vm/notification_vm.dart';
import '../common_widget/common_button.dart';
import '../common_widget/progress_indicator.dart';
import '../common_widget/snack_bar.dart';
import 'common_widgets/animated_bottom_bar.dart';
import 'common_widgets/dashboard_widgets.dart';
import 'common_widgets/drawer_widget.dart';

bool? isVisiblee = true;
double? buttonWidth;
double? buttonHeight;
bool isMute = false;
bool? drawerLogin;

final GlobalKey<ScaffoldState> key = GlobalKey();
final assetsAudioPlayer = AssetsAudioPlayer();
AppSliderVM appSliderVM = Get.put(AppSliderVM());
GetNotificationCountVM getNotificationCountVM =
    Get.put(GetNotificationCountVM());

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => DashBoardState();
}

class DashBoardState extends State<DashBoard> with WidgetsBindingObserver {
  late Timer _timer;
  double _scrollPosition = 0.0;
  int currentIndex = 0;
  VisitDateAndTimeDetailsVM visitDateAndTimeDetailsVM =
      Get.put(VisitDateAndTimeDetailsVM());
  NotificationFlagCountVm notificationFlagCountVm =
      Get.put(NotificationFlagCountVm());
  NotificationForAllVm notificationForAllVm = Get.put(NotificationForAllVm());
  final ScrollController _controller = ScrollController();
  NotificationVM notificationVM = Get.put(NotificationVM());

  ///To showing latest notification on dashboard
  getNotificationCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasShownPopUp = prefs.getBool('hasShownPopUp') ?? false;
    SharedPreferences preference = await SharedPreferences.getInstance();
    String devoteeId = preference.getString("registrationId") ?? "";
    getNotificationCountVM.notificationCountList.clear();
    getNotificationCountVM.isLoading.value = true;
    await getNotificationCountVM.getNotificationCount(devoteeId);
    int count = preference.getInt('count') ?? 0;
    await preference.setInt('count', notificationCount);
    if (count != preference.getInt('count')) {
      await prefs.setBool('hasShownPopUp', false);
      hasShownPopUp = prefs.getBool('hasShownPopUp') ?? false;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (notificationCount != 0 &&
          hasShownPopUp == false &&
          notificationVM.notificationDetails.isNotEmpty) {
        if (devoteeId != "") {
          notificationVM.notificationDetails.clear();
          notificationVM.isLoading.value = true;
          await notificationVM.getnotificationData(
              "1", "10", "", devoteeId, "4", context);

          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "notificationAppBarTitle".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 45,
                        fontFamily: "OpenSans",
                        color: Colors.black),
                  ),
                  titlePadding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 30,
                      right: MediaQuery.of(context).size.width / 30,
                      top: MediaQuery.of(context).size.height / 70),
                  contentPadding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 30,
                    right: MediaQuery.of(context).size.width / 30,
                  ),
                  actionsPadding: EdgeInsets.zero,
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const Divider(
                          color: Colors.grey,
                        ),
                        Text(notificationVM.notificationDetails.first.reason
                            .toString()),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        notificationVM.notificationDetails.clear();
                        Get.back();
                      },
                      child: Text(
                        'close'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height / 60,
                            fontFamily: "OpenSans",
                            color: Colors.orange),
                      ),
                    ),
                  ],
                );
              },
            );
            await prefs.setBool('hasShownPopUp', true);
          }
        }
      }
    });
  }

  ///Song
  getAudioUpdate1() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('isMute') == null) {
      isMute = false;
      assetsAudioPlayer.open(
        Audio("assets/Sarva Mangala Mangalye.mp3"),
        loopMode: LoopMode.playlist,
        respectSilentMode: isMute,
      );
    } else {
      isMute = preferences.getBool('isMute')!;

      if (isMute == false) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          assetsAudioPlayer.open(
            Audio("assets/Sarva Mangala Mangalye.mp3"),
            loopMode: LoopMode.playlist,
            respectSilentMode: isMute,
          );
        });
      } else {
        assetsAudioPlayer.stop();
      }
    }
  }

  ///Book Pass blink Button
  void _startAnimating() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          isVisiblee = !isVisiblee!;
          if (isVisiblee!) {
            buttonWidth = MediaQuery.of(context).size.width / 2.1;
            buttonHeight = MediaQuery.of(context).size.height / 17;
          } else {
            buttonWidth = MediaQuery.of(context).size.width / 3.5;
            buttonHeight = MediaQuery.of(context).size.height / 17;
          }
        });
      } else {
        _timer.cancel();
      }
    });
  }

  ///to check devotee is registered or not

  checkUserDetails() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    drawerLogin = preference.getBool('isRegister') ?? false;
  }

  ///Scrollable notification
  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        _scrollPosition += 1.5;
        if (_scrollPosition >= _controller.position.maxScrollExtent) {
          _scrollPosition = 0.0;
          currentIndex = 0;
        }
        _controller.jumpTo(_scrollPosition);
      });
    });
  }

  /// For terminating Application
  DateTime preBackpress = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      checkAppUpdate();
      checkUserDetails();
      currentIndex = 2;
      bottomIndex = 2;
      getAudioUpdate1();
      isVisiblee = true;
      _startAnimating();
      appSliderVM.imageDetails.clear();
      appSliderVM.isLoading.value = true;
      await appSliderVM.appSliderData("1", "10", "", context);
      notificationForAllVm.notiAllList.clear();
      notificationForAllVm.isLoading.value = true;
      await notificationForAllVm.getAllNotification("1", "1");
      Future.delayed(const Duration(seconds: 1), () async {
        _startAutoScroll();
      });

      getNotificationCount();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      assetsAudioPlayer.stop();
    } else if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        getAudioUpdate1();
      });
    }
  }

  @override
  void dispose() {
    assetsAudioPlayer.stop();
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// for the app auto update
  checkAppUpdate() async {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
            }
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          // Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              InAppUpdate.completeFlexibleUpdate();
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      key: key,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: dashboardAppBar(context),
      bottomNavigationBar: const BottomNavigationBarClass(),
      endDrawer: mainDashboardDrawer(context),
      body: Obx(
        () => WillPopScope(
          onWillPop: () async {
            final timegap = DateTime.now().difference(preBackpress);
            final cantExit = timegap >= const Duration(seconds: 2);
            preBackpress = DateTime.now();
            if (cantExit) {
              toastMessage(context, "doubleBack".tr);
              return false;
            } else {
              return true;
            }
          },
          child: ModalProgressHUD(
            inAsyncCall: appSliderVM.isLoading.value == true &&
                notificationForAllVm.isLoading.value == true,
            progressIndicator: progressIndicator(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return true;
                },
                child: RefreshIndicator(
                  color: Colors.deepOrange.shade600,
                  onRefresh: () {
                    return Future.delayed(const Duration(seconds: 1), () async {
                      appSliderVM.imageDetails.clear();
                      appSliderVM.isLoading.value = true;
                      await appSliderVM.appSliderData("1", "10", "", context);
                      notificationForAllVm.notiAllList.clear();
                      notificationForAllVm.isLoading.value = true;
                      await notificationForAllVm
                          .getAllNotification("1", "1")
                          .then((_) {
                        _startAutoScroll();
                      });
                      getNotificationCount();
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 60),
                    child: ListView(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 38,
                              right: MediaQuery.of(context).size.width / 38,
                            ),
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height / 20,
                                child: notificationForAllVm.notiAllList.isEmpty
                                    ? Center(
                                        child: Text(
                                            "|| श्री तुळजाभवानी प्रसन्न ||",
                                            style: TextStyle(
                                                color:
                                                    Colors.deepOrange.shade600,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "OpenSans",
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25)),
                                      )
                                    : ListView.builder(
                                        controller: _controller,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: notificationForAllVm
                                                .notiAllList.length *
                                            100,
                                        // Repeating items to ensure continuous scrolling
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final itemIndex = (index %
                                              notificationForAllVm
                                                  .notiAllList.length);

                                          if (itemIndex == 0) {
                                            currentIndex++; // Increment the index for API items
                                          }

                                          return SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                25,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                0.5,
                                            // Adjust the item width as needed
                                            child: Row(
                                              children: [
                                                Icon(Icons.circle,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        60,
                                                    color: Colors
                                                        .deepOrange.shade600),
                                                Text(
                                                    " ${notificationForAllVm.notiAllList[itemIndex].description!} ",
                                                    style: TextStyle(
                                                        color: Colors.deepOrange
                                                            .shade600,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "OpenSans")),
                                                Icon(Icons.circle,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        60,
                                                    color: Colors
                                                        .deepOrange.shade600),
                                              ],
                                            ),
                                          );
                                        }))),
                        (appSliderVM.isLoading.value == true ||
                                appSliderVM.imageDetails.isEmpty)
                            ? Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 38,
                                  right: MediaQuery.of(context).size.width / 38,
                                ),
                                child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width: MediaQuery.of(context).size.width,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Image.asset(
                                      "assets/images/dashboard/DeviImage.png",
                                      fit: BoxFit.fill,
                                    )))
                            : imageWidget(context),
                        SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 38),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        70),
                                Center(
                                    child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                26,
                                        child: SvgPicture.asset(
                                            "assets/images/dashboard/Sarv Mangal Text.svg"))),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        70),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFFFFFF),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.17),
                                          offset: const Offset(0, 0),
                                          blurRadius: 3,
                                          blurStyle: BlurStyle.outer,
                                        )
                                      ]),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: SvgPicture.asset(
                                            'assets/images/dashboard/Card 1.svg',
                                            fit: BoxFit.contain,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6.7,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                60,
                                        left:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        child: Text('passName'.tr,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    41)),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  10,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  90),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        5),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    SharedPreferences
                                                        preference =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    bool isLogin =
                                                        preference.getBool(
                                                                "isRegister") ??
                                                            false;
                                                    String? mobileNo =
                                                        preference
                                                            .getString("mob");
                                                    if (isLogin == true) {
                                                      bool isPassGenerated =
                                                          preference.getBool(
                                                                  "isPassGenerated") ??
                                                              false;
                                                      if (isPassGenerated ==
                                                          true) {
                                                        visitDateAndTimeDetailsVM
                                                            .visitDateAndTimeDetailsList
                                                            .clear();
                                                        visitDateAndTimeDetailsVM
                                                            .isLoading
                                                            .value = true;
                                                        await visitDateAndTimeDetailsVM
                                                            .getVisitDateTimeDetails(
                                                                mobileNo!);
                                                        if (visitDateAndTimeDetailsVM
                                                                .isExpired ==
                                                            8) {
                                                          preference.remove(
                                                              "isPassGenerated");
                                                          Get.offAllNamed(
                                                              "/nonReferralPassBooking");
                                                        } else {
                                                          Get.offAllNamed(
                                                              "/splePassDetailsView");
                                                        }
                                                      } else {
                                                        Get.offAllNamed(
                                                            "/nonReferralPassBooking");
                                                      }
                                                    } else {
                                                      Get.offAllNamed(
                                                          "/darshanPassLogin");
                                                    }
                                                  },
                                                  child: AnimatedOpacity(
                                                    opacity:
                                                        isVisiblee! ? 1.0 : 0.5,
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    child: Center(
                                                      child: AnimatedContainer(
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          width: buttonWidth,
                                                          height: buttonHeight,
                                                          child:
                                                              dashBlinkButton(
                                                                  context,
                                                                  "bookPass"
                                                                      .tr)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        50),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed("/webViewDisplay",
                                        arguments: [
                                          'darshanText'.tr,
                                          "https://shrituljabhavani.org/LiveShriTuljabhavani.html"
                                        ]);
                                  },
                                  child: dashboardNavigationContainer(context,
                                      imageIconText: 'darshanText'.tr,
                                      color: const Color(0xFFFC7F72)
                                          .withOpacity(0.05),
                                      imageIconPath:
                                          "assets/images/dashboard/Online Darshan white.svg"),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed("/webViewDisplay",
                                        arguments: [
                                          'donationText'.tr,
                                          "https://shrituljabhavani.org/TuljapurOd.aspx"
                                        ]);
                                  },
                                  child: dashboardNavigationContainer(context,
                                      imageIconText: 'donationText'.tr,
                                      color: const Color(0xFFFC7F72)
                                          .withOpacity(0.05),
                                      imageIconPath:
                                          "assets/images/dashboard/Online Donation white.svg"),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed("/webViewDisplay",
                                        arguments: [
                                          'Abhishek'.tr,
                                          "https://shrituljabhavani.org/frmAbhisheckPooja.aspx"
                                        ]);
                                  },
                                  child: dashboardNavigationContainer(context,
                                      imageIconText: 'Abhishek'.tr,
                                      color: const Color(0xFFFC7F72)
                                          .withOpacity(0.05),
                                      imageIconPath:
                                          "assets/images/dashboard/Abhishek Pooja white.svg"),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed("/webViewDisplay",
                                        arguments: [
                                          'srikhand'.tr,
                                          "https://shrituljabhavanimataseva.org/Login.php"
                                        ]);
                                  },
                                  child: dashboardNavigationContainer(context,
                                      imageIconText: 'srikhand'.tr,
                                      color: Colors.deepOrangeAccent,
                                      imageIconPath:
                                          "assets/images/dashboard/Sinhasan Pooja white.svg"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
