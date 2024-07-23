import 'package:countdown_widget/countdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import '../../../internet_service/CheckInternetCon.dart';
import '../../../view_modal/devotee_vm/login_passinfo_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/check_devotee_registration_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/devotee_profile_details_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/spl_epass_otp_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/spl_epass_verifyotp_vm.dart';
import '../../common_widget/common_appBar.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/progress_indicator.dart';
import '../../forgot_password/otp_design_widget.dart';







var isShowResendBtn1 = true.obs;
var resendOtpbtn1 = false;
bool isGetOtp = false;

final TextEditingController one = TextEditingController();
final TextEditingController two = TextEditingController();
final TextEditingController three = TextEditingController();
final TextEditingController four = TextEditingController();
final TextEditingController five = TextEditingController();
TextEditingController splMobileNoController =TextEditingController();
class DarshanPassLogin extends StatefulWidget {
  const DarshanPassLogin({Key? key}) : super(key: key);
  @override
  State<DarshanPassLogin> createState() => _DarshanPassLoginState();
}

class _DarshanPassLoginState extends State<DarshanPassLogin> {
  final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
  late CountDownController splCountDownController;
  ///Dependency injection
  final DevoteeProfileDetailsVM profileDetailsVM =Get.put(DevoteeProfileDetailsVM());
  final DevoteeLoginInstruction devoteeLoginInfoVM = Get.put(DevoteeLoginInstruction());
  final SplDonationPassOTPVM splDonationPassOTPVM = Get.put(SplDonationPassOTPVM());
  final SplePassVerifyOTPVM splePassVerifyOTPVM = Get.put(SplePassVerifyOTPVM());
  final CheckDevoteeRegistrationVM checkDevoteeRegistrationVM = Get.put(CheckDevoteeRegistrationVM());
  Duration dur = const Duration(seconds:60);

  splDonationPassOtpVerification() async {
    print(splMobileNoController.text);
    String otp = one.text+two.text+three.text+four.text+five.text;
    splePassVerifyOTPVM.isLoading.value = true;
     await splePassVerifyOTPVM.postVerifyOtpVm(splMobileNoController.text,otp, context);
    if(splePassVerifyOTPVM.statusCode == "200"){
      toastMessage(context, 'otpVerification'.tr);
      checkDevoteeRegistrationVM.isLoading.value = true;
      await checkDevoteeRegistrationVM.checkDevoteeRegistration(splMobileNoController.text, context);
    if(checkDevoteeRegistrationVM.isRegister == 0){
      SharedPreferences preference = await SharedPreferences.getInstance();
      preference.setString("mob",splMobileNoController.text);
      Get.offAllNamed("/devoteeRegistration",arguments:splMobileNoController.text);
    }
    else if(checkDevoteeRegistrationVM.isRegister == 1){
      SharedPreferences preference = await SharedPreferences.getInstance();
      preference.setBool("isRegister",true);
      preference.setString("mob",splMobileNoController.text);
      profileDetailsVM.devoteeProfileDetailsList.clear();
      profileDetailsVM.isLoading.value = true;
      await profileDetailsVM.getDevoteeProfileDetails(splMobileNoController.text, context);
      preference.setString("registrationId",profileDetailsVM.id.toString());
      Get.offAllNamed("/nonReferralPassBooking");
    }
    }
    else if(splePassVerifyOTPVM.statusCode =='409'){
      print(splePassVerifyOTPVM.statusCode);
      toastMessage(context, "fInvalidOtpSnackBar".tr);
    }
    else{
      toastMessage(context, 'wentWrong'.tr);
    }
  }

  ///Getting otp
  splDonationPassOtp() async {
    splDonationPassOTPVM.isLoading.value = true;
    await splDonationPassOTPVM.postOTPInfo(splMobileNoController.text, context);
    if(splDonationPassOTPVM.statusCode == "200"){
      toastMessage(context, 'otpSentSuccess'.tr);
      isShowResendBtn1.value = false;
      resendOtpbtn1 = true;
      isGetOtp = true;

    }
    else if (splDonationPassOTPVM.statusMessage == "OTP sending limit is exceeded for a minute, please try again later"){
      toastMessage(context, 'dOtpLimitExceedSnackBar'.tr);
    }
    else if (splDonationPassOTPVM.statusMessage == "Mobile number is registered with trustee/validator."){
      toastMessage(context, 'anotherUserNo'.tr);
    }
    else{
      toastMessage(context, 'wentWrong'.tr);
    }
  }
String? selectedLanguage;
getLanguage()async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  selectedLanguage = pref.getString('language') ?? 'English';
  print("selectedLanguage$selectedLanguage");
}
ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getLanguage();
      devoteeLoginInfoVM.devoteeInstructionList.clear();
      isShowResendBtn1.value = true;
      resendOtpbtn1 = false;
      isGetOtp = false;
      splDonationPassOTPVM.statusCode = "";
      splMobileNoController.text = "";
      one.clear();
      two.clear();
      three.clear();
      four.clear();
      five.clear();
      devoteeLoginInfoVM.isLoading.value = true;
      splDonationPassOTPVM.isLoading.value = false;
      splePassVerifyOTPVM.isLoading.value = false;
      await devoteeLoginInfoVM.getInstruction();
    });
  }
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        Get.offAllNamed('/dashBoard');
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6F9),
        appBar: commonDevoteePassAppBar("devoteeLogin".tr),
        body: Obx(() =>
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll){
                overScroll.disallowIndicator();
                return true;
              },
              child: ModalProgressHUD(
                  inAsyncCall:
                  devoteeLoginInfoVM.isLoading.value == true||
                  splDonationPassOTPVM.isLoading.value == true ||
                      splePassVerifyOTPVM.isLoading.value == true  ,
                  progressIndicator: progressIndicator(),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height/1.13,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/35),
                            child: CircleAvatar(radius: MediaQuery.of(context).size.width/6.5,
                                backgroundImage: const AssetImage("assets/images/loginDevi.JPEG")
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/42),
                            child: Center(child:Text(
                            "welcomeTo".tr,style:  TextStyle(
                                fontSize: MediaQuery.of(context).size.height/35,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              color:Colors.black
                            )))),
                          Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/100),
                            child: Center(child:Text("templeName".tr,style:  TextStyle(
                                fontSize: MediaQuery.of(context).size.height/45,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              color:Colors.orange
                            ))),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(top: MediaQuery.of(context).size.height/30,
                              left: MediaQuery.of(context).size.width/15,
                              right: MediaQuery.of(context).size.width/15,
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height/18,
                              width: MediaQuery.of(context).size.width/1.1,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    // Adjust the blur radius
                                    offset: const Offset(1, 1), // Adjust the offset
                                  ),
                                ],
                              ),
                              child:TextFormField(
                                readOnly:splDonationPassOTPVM.statusCode == "200",
                                controller: splMobileNoController,
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
                                    contentPadding:EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
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
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height/80,),
                          Visibility(
                              visible: splDonationPassOTPVM.statusCode == "200",
                              child: Padding(
                                padding:EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width/15,
                                    right: MediaQuery.of(context).size.width/15,
                                    top: MediaQuery.of(context).size.height/45
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    OtpInput(one, true),
                                    OtpInput(two, true),
                                    OtpInput(three, true),
                                    OtpInput(four, true),
                                    OtpInput(five, true),
                                  ],
                                ),
                              )),
                          SizedBox(height: MediaQuery.of(context).size.height /30),
                          Visibility(
                            visible: splDonationPassOTPVM.statusCode == "200",
                            child:  Row(
                              children: [
                                const Spacer(),
                                Obx(()=> (isShowResendBtn1.value == true)?
                                GestureDetector(
                                  onTap: () async {
                                    if(resendOtpbtn1 == false){

                                    }
                                    else{
                                    dur  = const Duration(seconds: 60);
                                    one.clear();
                                    two.clear();
                                    three.clear();
                                    four.clear();
                                    five.clear();
                                    splDonationPassOTPVM.isLoading.value = true;
                                    await splDonationPassOTPVM.postOTPInfo(splMobileNoController.text, context);
                                    if(splDonationPassOTPVM.statusCode == "200"){
                                      toastMessage(context, splDonationPassOTPVM.statusMessage!);
                                      isShowResendBtn1.value = false;
                                      resendOtpbtn1 = true;
                                    }
                                    else{
                                      toastMessage(context, splDonationPassOTPVM.statusMessage!);
                                    }
                                    }
                                    },
                                  child: Padding(
                                    padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/15),
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
                                  ),
                                ):
                                CountDownWidget(
                                  duration: dur,
                                  builder: (context, duration) {
                                    return Padding(
                                      padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/19),
                                      child: Text("${'dResendOtpIn'.tr}${duration.inSeconds} ${'dInSec'.tr}",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height/56,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontStyle: FontStyle.normal),
                                      ),
                                    );
                                  },
                                  autoStart: true,

                                  onFinish: () async {
                                    setState(() {
                                    isShowResendBtn1.value = true;
                                     });
                                    splCountDownController.restart();

                                  },
                                  onControllerReady: (controller) {
                                    splCountDownController = controller;
                                  },
                                  onDurationRemainChanged: (duration) {
                                    dur = duration;
                                  },
                                )
                                  ,
                                ),
                              ],
                            ),),
                          SizedBox(
                              height:(splDonationPassOTPVM.statusCode == "200")? MediaQuery.of(context).size.height /60: 0),
                          GestureDetector(
                              onTap: () async {
                              if (isGetOtp == false) {
                                if (splMobileNoController.text.isEmpty) {
                                  toastMessage(
                                      context, "dEmptyMobileSnackBar".tr,
                                      color: Colors.redAccent);
                                }
                                else if (splMobileNoController.text.startsWith(
                                    "0") ||
                                    splMobileNoController.text.startsWith(
                                        "1") ||
                                    splMobileNoController.text.startsWith(
                                        "2") ||
                                    splMobileNoController.text.startsWith(
                                        "3") ||
                                    splMobileNoController.text.startsWith(
                                        "4") ||
                                    splMobileNoController.text.startsWith(
                                        "5")) {
                                  toastMessage(
                                      context, 'dInvalidMobileSnackBar'.tr);
                                } else
                                if (splMobileNoController.text.length < 10) {
                                  toastMessage(
                                      context, 'dInvalidationLengthMobile'.tr);
                                }
                                else {
                                  splDonationPassOtp();
                                }
                              }
                              else if(isGetOtp == true){
                                splDonationPassOtpVerification();
                              }
                              },
                              child: commonButton(context, (splDonationPassOTPVM.statusCode == "200")?"fVerify".tr:"dSendOtpBtnText".tr)),
                          SizedBox(height:MediaQuery.of(context).size.height/30),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:EdgeInsets.only(left: MediaQuery.of(context).size.width/20),
                              child: Text("dInstruction".tr,
                                  style:TextStyle(
                                      fontSize: MediaQuery.of(context).size.width/30,
                                      color: const Color(0xFF303030),
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold
                                  )),
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding:  EdgeInsets.only(
                                top: MediaQuery.of(context).size.height/70,
                                left: MediaQuery.of(context).size.width/20,
                                right: MediaQuery.of(context).size.width/20,
                              ),
                              child: Scrollbar(
                                thumbVisibility: true,
                                thickness: 2,
                                controller: _scrollController,
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  child: Padding(
                                    padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width/90),
                                    child: Text(selectedLanguage== "English"? instructionss ?? ""
                                        : marathiInstructions ?? "",
                                        textAlign: TextAlign.justify,
                                        style:TextStyle(
                                            fontSize: MediaQuery.of(context).size.width/30,
                                            fontFamily: 'OpenSans',
                                            color:  Colors.black)),
                                  ),

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ),
        ),
      ),
    );
  }
}
