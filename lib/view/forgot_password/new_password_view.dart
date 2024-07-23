import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulajapur/view/common_widget/progress_indicator.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import 'package:tulajapur/view/forgot_password/forgot_password_widget.dart';
import '../../modal/forgot_password_modal.dart';
import '../../view_modal/forgot_pass_vm.dart';
import '../common_widget/common_button.dart';
import 'forgot_password_string.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

UpdatePassVM updatePassVM = Get.put(UpdatePassVM());
bool passwordUpdated = false;

class _NewPasswordState extends State<NewPassword> {
  @override
  void initState() {
    super.initState();
    passwordUpdated = false;
    forgotNewPass.text = "";
    forgotReEnterPass.text = "";
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: ModalProgressHUD(
          inAsyncCall: passwordUpdated == true,
          progressIndicator: progressIndicator(),
          child: WillPopScope(
            onWillPop: () async {
              setState(() {});
              Get.offAllNamed("/loginView");
              return false;
            },
            child: Stack(
              children: [
                Material(
                  clipBehavior: Clip.antiAlias,
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35.0),
                          bottomRight: Radius.circular(35.0))),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEC6019).withOpacity(0.8),
                    ),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          const Color(0xFFE23500).withOpacity(0.4),
                          BlendMode.dstATop),
                      child: const Image(
                        image: AssetImage("assets/images/loginImage.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 8),
                  child: Center(
                    child: Container(
                        height: MediaQuery.of(context).size.height / 2.1,

                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFFFFFFF),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 3),
                                  blurRadius: 6)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 80,
                            left: MediaQuery.of(context).size.width / 25,
                            right: MediaQuery.of(context).size.width / 25,
                            bottom: MediaQuery.of(context).size.height / 120,
                          ),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          3.2),
                                  Center(
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height /
                                              36,
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.white,
                                      child: const Image(
                                        image: AssetImage(
                                          "assets/images/dashboard/Tuljapurlogo_new1.png",
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Get.offAllNamed("/loginView");
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              230,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_back_ios,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                60,
                                          ),
                                          Text(
                                            "back".tr,
                                            style: TextStyle(
                                                fontFamily: "OpenSans",
                                                fontWeight: FontWeight.w400,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    60,
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 80,
                              ),

                              Center(
                                child: Text(
                                  "nPasswordTitle".tr,
                                  style: TextStyle(
                                      fontFamily: "OpenSans",
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              38,
                                      color: Colors.black),
                                ),
                              ),

                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 25),

                              ///New Password
                              newPassword(context),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /90,
                              ),
                              confirmPassword(context),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 50,
                              ),

                              GestureDetector(
                                  onTap: () async {
                                    if (forgotNewPass.text.isEmpty) {
                                      toastMessage(
                                          context, "emptyNewPassword".tr,
                                          color: Colors.redAccent);
                                    } else if (forgotReEnterPass.text.isEmpty) {
                                      toastMessage(
                                          context, "emptyConfirmPassword".tr,
                                          color: Colors.redAccent);
                                    } else if (forgotNewPass.text ==
                                        forgotReEnterPass.text) {
                                      await updatePassVM.updatePassword(
                                          ForgotPasswordModal(), context);
                                    } else if (forgotNewPass.text !=
                                        forgotReEnterPass.text) {
                                      toastMessage(context, "notMatching".tr,
                                          color: Colors.redAccent);
                                    }
                                  },
                                  child: commonButton(context, "nSubmitBtn".tr))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
