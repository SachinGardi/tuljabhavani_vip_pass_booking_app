import 'package:countdown_widget/countdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import 'package:tulajapur/view/forgot_password/forgot_password_widget.dart';
import '../../internet_service/CheckInternetCon.dart';
import '../../modal/devotee/post_otp_modal.dart';
import '../../modal/devotee/verify_post_otp.dart';
import '../../view_modal/devotee_vm/verify_otpVm.dart';
import '../common_widget/common_button.dart';
import '../common_widget/progress_indicator.dart';
import '../login_page/login_string.dart';
import 'forgot_password_string.dart';
import 'otp_design_widget.dart';



var isShowResendBtn = true.obs;
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  VerifyOTPVM verifyOTPVM = Get.put(VerifyOTPVM());
  final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
  Duration dur =const Duration(seconds:60);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otpNumber.clear();
    verifyOTP.clear();
    fieldOne.clear();
    fieldTwo.clear();
    fieldThree.clear();
    fieldFour.clear();
    fieldFive.clear();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    return WillPopScope(
      onWillPop: ()async{
        Get.offAllNamed("/loginView");
        return false;
      },
      child: Scaffold(

        backgroundColor: const Color(0xFFF5F6F9),
        body:Obx(()=>
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: ModalProgressHUD(
                inAsyncCall:isPressed.value == true || otpVarifiedSuccessfully.value == true  ,
                progressIndicator: progressIndicator(),
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

                        decoration:  BoxDecoration(
                          color:  const Color(0xFFEC6019).withOpacity(0.9),
                        ),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              const Color(0xFFE23500).withOpacity(0.4), BlendMode.dstATop),
                          child: const Image(
                            image: AssetImage("assets/images/loginImage.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height /7.5),
                      child: Center(
                        child: Container(
                          height:(getotp.value == true)?MediaQuery.of(context).size.height /2.4: MediaQuery.of(context).size.height /3.1,
                          width: MediaQuery.of(context).size.width / 1.22,
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
                                top:MediaQuery.of(context).size.height/100 ,
                                left:MediaQuery.of(context).size.width/20,
                                right:MediaQuery.of(context).size.width/20,
                                bottom:MediaQuery.of(context).size.height/120
                            ),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(width: MediaQuery.of(context).size.width/3.3,),

                                    Center(
                                      child: CircleAvatar(
                                        radius: MediaQuery.of(context).size.height/34,
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.white,
                                        child: const Image(image: AssetImage("assets/images/dashboard/Tuljapurlogo_new1.png",),fit: BoxFit.fill,),
                                      ),

                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: (){
                                        Get.offAllNamed("/loginView");
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context).size.height/230,
                                            bottom: MediaQuery.of(context).size.height/20
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_ios,size: MediaQuery.of(context).size.height/60,),
                                            Text("back".tr,style:
                                            TextStyle(
                                                fontFamily: "OpenSans",
                                                fontWeight: FontWeight.w400,
                                                fontSize: MediaQuery.of(context).size.height/60,
                                                color: Colors.black),)
                                          ],
                                        ),
                                      ),
                                    )


                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height/170,
                                ),
                                Center(
                                  child: Text(
                                    "fFormTitle".tr,
                                    style:
                                    TextStyle(
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.w400,
                                        fontSize: MediaQuery.of(context).size.height/40, color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /40),
                                SizedBox(
                                  height:  MediaQuery.of(context).size.height/18,
                                  child: TextFormField(
                                    readOnly:getotp.value == true,
                                    controller: otpNumber,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value){

                                    },
                                    keyboardType: TextInputType.phone,


                                    cursorColor: Colors.black26,
                                    cursorWidth: 1,
                                    expands: false,
                                    style:  TextStyle(
                                      fontSize: MediaQuery.of(context).size.height/50,
                                      fontFamily: "OpenSans",
                                      color: const Color(0xFF868686),
                                    ),
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.phone,color: Colors.black38,),
                                        filled: true,
                                        contentPadding: const EdgeInsets.only(top: 1),
                                        fillColor: const Color(0xFFF2F2F2),
                                        hintText: "fMobileNOHint".tr,
                                        hintStyle:  TextStyle(
                                          fontSize: MediaQuery.of(context).size.height/60,
                                          fontFamily: "OpenSans",
                                          color:const Color(0xFF868686),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7),
                                          borderSide: BorderSide.none,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /50,
                                ),
                                Visibility(
                                  visible: getotp.value == true,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 2.0,right: 2),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          OtpInput(fieldOne, true),
                                          OtpInput(fieldTwo, true),
                                          OtpInput(fieldThree, true),
                                          OtpInput(fieldFour, true),
                                          OtpInput(fieldFive, true),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                    height:(getotp.value == true)? MediaQuery.of(context).size.height /50:MediaQuery.of(context).size.height /100),
                                Visibility(
                                  visible: getotp.value == true,
                                  child:  Padding(
                                    padding: const EdgeInsets.only(right: 2.0),
                                    child: Row(
                                    children: [
                                      const Spacer(),
                                      Obx(()=> (isShowResendBtn.value == true)?
                                      GestureDetector(
                                        onTap: () async {
                                          if(resendOtpbtn == false){
                                            // toastMessage(context, "Click on Send OTP Button");
                                          }
                                          else{
                                            dur = const Duration(seconds: 60);
                                            await addOTPVM.forgotPassOTP(DevoteePostOTPModal(), context);
                                            fieldOne.clear();
                                            fieldTwo.clear();
                                            fieldThree.clear();
                                            fieldFour.clear();
                                            fieldFive.clear();
                                          }

                                        },
                                        child: Text(
                                          "fResendOtpBtnText".tr,
                                          style:  TextStyle(
                                              decorationColor: const Color(0xFF505EBC),
                                              decorationThickness: 1,
                                              shadows: const [Shadow(color: Color(0xFF505EBC), offset: Offset(0, -4))],
                                              decoration: TextDecoration.underline,
                                              fontSize: MediaQuery.of(context).size.height/55,
                                              fontFamily: "OpenSans",
                                              color: Colors.transparent),
                                        ),
                                      ):
                                      CountDownWidget(
                                        duration:  dur,
                                        builder: (context, duration) {
                                          return Text("${"dResendOtpIn".tr}${duration.inSeconds} ${"dInSec".tr}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.height/56,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                                fontFamily: 'Montserrat Regular',
                                                fontStyle: FontStyle.normal),
                                          );
                                        },
                                        autoStart: true,
                                        onFinish: () async {
                                          setState(() {
                                            isShowResendBtn.value = true;
                                            countDownController.restart();
                                          });
                                        },
                                        onControllerReady: (controller) {
                                          countDownController = controller;
                                        },
                                        onDurationRemainChanged: (duration) {
                                          dur = duration;
                                          },
                                      )
                                        ,
                                      ),
                                    ],
                                ),
                                  ),),
                                SizedBox(
                                    height:(getotp.value == true)? MediaQuery.of(context).size.height /60: 0),

                                GestureDetector(
                                    onTap: () async {
                                      if(otpNumber.text.isEmpty ){
                                        toastMessage(context, "dEmptyMobileSnackBar".tr,color: Colors.redAccent);
                                      }
                                      else if(
                                      otpNumber.text.startsWith("0") ||
                                          otpNumber.text.startsWith("1") ||
                                          otpNumber.text.startsWith("2") ||
                                          otpNumber.text.startsWith("3") ||
                                          otpNumber.text.startsWith("4") ||
                                          otpNumber.text.startsWith("5") ||
                                          otpNumber.text.length<10){
                                        toastMessage(context, "invalidMobileNumberfp".tr,color:Colors.red);
                                      }
                                      else{
                                        if(getotp.value == false){
                                          isPressed.value = true;
                                          await addOTPVM.forgotPassOTP(DevoteePostOTPModal(), context);
                                        }
                                        else if(fieldOne.text == "" || fieldTwo.text == "" ||fieldThree.text == "" ||fieldFour.text == "" ||fieldFive.text == "" ){
                                          toastMessage(context, "otpFieldEmpty".tr,color: Colors.redAccent);
                                        }
                                        else{
                                          forgotPageVisited = true;
                                          await verifyOTPVM.verifyForgotPassword(
                                              DevoteeVerifyModal(), context);
                                        }
                                      }
                                      },

                                    child: commonButton(context, (getotp.value == true)?"fVerify".tr:"dSendOtpBtnText".tr))

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

      ),
    );
  }
}


