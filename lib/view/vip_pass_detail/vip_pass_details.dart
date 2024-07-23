import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:tulajapur/view/common_widget/profileDetails.dart';
import '../../modal/validator/visitconfirmbyvalidator.dart';
import '../../view_modal/validator/visit_confirmby_validator_vm.dart';
import '../common_widget/common_appBar.dart';
import '../common_widget/progress_indicator.dart';
import '../common_widget/snack_bar.dart';
import '../validator_module/scan_pass/scan_pass_string.dart';

class VipPassDetail extends StatefulWidget {
  const VipPassDetail({Key? key}) : super(key: key);
  @override
  State<VipPassDetail> createState() => _VipPassDetailState();
}
String? passStatus;
VisitConfirmByValidatorVM visitConfirmByValidatorVM =Get.put(VisitConfirmByValidatorVM());
class _VipPassDetailState extends State<VipPassDetail> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passStatus = Get.arguments;
    visitConfirmByValidatorVM.isLoading.value = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar('vipAppBarTitle'.tr),
      body: WillPopScope(
        onWillPop: ()async{
          Get.back();
          return false;
        },
        child: Obx(()=>
          ModalProgressHUD(
            inAsyncCall: visitConfirmByValidatorVM.isLoading.value == true,
            progressIndicator: progressIndicator(),
            child:  Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/50,),
                Center(
                  child: Container(
                    height:  (passStatus == "Visited")?MediaQuery.of(context).size.height/1.25:MediaQuery.of(context).size.height/1.30,
                    width: MediaQuery.of(context).size.width / 1.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.09),
                              offset: Offset(0.0, 3.0),
                              blurRadius: 6.0)
                        ]),
                    child:  NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll){
                        overScroll.disallowIndicator();
                        return true;
                      },
                      child: Stack(
                        children: [
                          (passStatus == "Visited")?
                          Center(
                              child: Padding(
                                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/18),
                                child: Image.asset("assets/images/validator/Visited Stamp.png",fit: BoxFit.fill,
                                  height: MediaQuery.of(context).size.height/5,
                                  opacity:const AlwaysStoppedAnimation(.7),),
                              ))
                              :const SizedBox.shrink(),
                          (passStatus == "Expired")?
                          Center(
                              child: Padding(
                                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/18),
                                child: Image.asset("assets/images/validator/Expired Stamp copy.png",fit: BoxFit.fill,
                                  height: MediaQuery.of(context).size.height/5,
                                  opacity:const AlwaysStoppedAnimation(.7),),
                              ))
                              :const SizedBox.shrink(),
                          ListView(
                            children: [

                              Container(
                                height: MediaQuery.of(context).size.height / 10,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    color: Color.fromRGBO(247, 146, 54, 1)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height /17,
                                      width: MediaQuery.of(context).size.width /9,
                                      child: Image.asset("assets/images/logo.png"),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width:MediaQuery.of(context).size.width/1.8,
                                          height: MediaQuery.of(context).size.height/20,
                                          child: Text("templeName".tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "OpenSans",
                                              color:Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize:  MediaQuery.of(context).size.height/53,
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: MediaQuery.of(context).size.height /100,
                                        ),
                                        Text('passName1'.tr,
                                          style: TextStyle(
                                            color: const Color.fromRGBO(21, 21, 21, 1),
                                            fontSize:  MediaQuery.of(context).size.height/55,
                                          ),
                                        )
                                      ],
                                    ),

                                    Container(
                                      height: MediaQuery.of(context).size.height /17,
                                      width: MediaQuery.of(context).size.width /9,
                                        decoration: BoxDecoration(
                                          color: Colors.orange.shade100,
                                        borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: Image.asset("assets/images/dashboard/Osmanabad District icon.png",)
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height/70),
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/15,
                                    right: MediaQuery.of(context).size.width/25),
                                child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          radius: MediaQuery.of(context).size.height /18,
                                          backgroundColor: Colors.grey.withOpacity(0.3),


                                          child:  Center(
                                            child: CircleAvatar(
                                              radius: MediaQuery.of(context).size.height /20,
                                              backgroundColor: Colors.teal,
                                              backgroundImage: NetworkImage(imagePath ??""),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context).size.height/16,
                                            width: MediaQuery.of(context).size.width/3,

                                            child: SfBarcodeGenerator(
                                              value: barcodeText ?? "",
                                              showValue: true,
                                              textStyle: TextStyle(
                                                fontSize:  MediaQuery.of(context).size.height /60,
                                                fontFamily: "OpenSans",),
                                            ))
                                      ],
                                    ),
                              ),
                                  SizedBox(
                                    height:MediaQuery.of(context).size.height /70,
                                  ),
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/15 ,
                                right: MediaQuery.of(context).size.width/20),
                                    child: Text(
                                      (devoteeName == null)? "" : devoteeName!,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.w600,
                                          fontSize: MediaQuery.of(context).size.height /52,
                                          color: const Color.fromRGBO(68, 68, 68, 1)),
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height /50),
                                  profileDetail(context, 'vipPassMobileChange'.tr, (mobileNo == null)? "" : mobileNo!,
                                      const Color.fromRGBO(68, 68, 68, 1)),
                                  profileDetail(context, 'vipPassGender'.tr, (gender == null)? "" :gender! ,
                                      const Color.fromRGBO(68, 68, 68, 1)),
                                  profileDetail(context, 'vipPassDob'.tr,(dateOfBirth == null)? "" :  dateOfBirth!,
                                      const Color.fromRGBO(68, 68, 68, 1)),
                                  profileDetail(context, 'vipPassAge'.tr,(age.toString() == "")? "" : " ${age.toString()} years",
                                      const Color.fromRGBO(68, 68, 68, 1)),
                                  profileDetail(context, 'vipPassAdharChange'.tr, (adharNo == null)? "" : adharNo!,
                                      const Color.fromRGBO(68, 68, 68, 1)),
                                  profileDetail(context, 'vipPassVisitDate'.tr,(visitDate == null)? "" : visitDate!,
                                      const Color.fromRGBO(68, 68, 68, 1)),
                                  profileDetail(
                                      context,
                                      'vipPassVisitTime'.tr, (visitTime == null)?"":visitTime!,
                                      const Color.fromRGBO(68, 68, 68, 1)),

                                  profileDetail(
                                      context,
                                      'e-PassName'.tr, (passName == null)?"":passName!,
                                      const Color.fromRGBO(68, 68, 68, 1)),
                              profileDetail(
                                  context,
                                  'vipPassDonation'.tr, (donation == null|| donation.toString() == '' )?"-":"₹ $donation",
                                  const Color.fromRGBO(68, 68, 68, 1)),
                              (donation == "0.0" || donation == "0")?
                              profileDetail(
                                  context,
                                  'bookingId'.tr, (passBookingId == null)?"-":passBookingId!,
                                  const Color.fromRGBO(68, 68, 68, 1)): (passStatus == "Expired" && donation == "0.0" || donation == "0")?
                              profileDetail(
                                  context,
                                  'bookingId'.tr, (passTransactionId == null)?"-":passTransactionId!,
                                  const Color.fromRGBO(68, 68, 68, 1)):
                              profileDetail(
                                      context,
                                      'transactionID'.tr, (passTransactionId == null)?"-":passTransactionId!,
                                      const Color.fromRGBO(68, 68, 68, 1)),

                             (donation == "0.0" || donation == "0")?
                              profileDetail(
                                  context,
                                  'bookingDate'.tr, (passBookingDate == null)?"-":passBookingDate!,
                                  const Color.fromRGBO(68, 68, 68, 1)): (donation == "0.0" || donation == "0" && passStatus =="Expired")?
                             profileDetail(
                                 context,
                                 'bookingDate'.tr, (passTransactionDate == null)?"-":passTransactionDate!,
                                 const Color.fromRGBO(68, 68, 68, 1)):
                                  profileDetail(
                                      context,
                                      'transactionDate'.tr, (passTransactionDate == null)?"-":passTransactionDate!,
                                      const Color.fromRGBO(68, 68, 68, 1)),
                                  (passStatus == "Visited")?profileDetail(
                                      context,
                                      'validatorName'.tr, (passValidatorName == null)?"-":passValidatorName!,
                                      const Color.fromRGBO(68, 68, 68, 1)):const SizedBox.shrink(),
                                  (passStatus == "Visited")?profileDetail(
                                      context,
                                      'passScanDate'.tr, (passScanDate == null)?"-":passScanDate!,
                                      const Color.fromRGBO(68, 68, 68, 1)):const SizedBox.shrink(),





                              // SizedBox(height:  MediaQuery.of(context).size.height /20,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              const Spacer(),
                Visibility(
                  visible: (passStatus == "Visited" || passStatus ==  "Expired" ),
                  replacement:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Center(
                              child: Container(
                                height: MediaQuery.of(context).size.height /22,
                                width: MediaQuery.of(context).size.width /3,
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
                                      "deny".tr,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height /65,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "OpenSans",
                                          color: Colors.black),
                                    )),
                              ))
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width /10),
                      GestureDetector(
                          onTap: () async {
                            await visitConfirmByValidatorVM.visitData(ConfirmVisitByValidatorModal(), context);
                            if(visitConfirmByValidatorVM.statusCode == "200"){
                              toastMessage(context, "toastPassConfirm".tr,color: Colors.greenAccent);
                              Get.offAllNamed("/scanPass");
                            }
                            else{
                              toastMessage(context, visitConfirmByValidatorVM.statusMessage!,color: Colors.greenAccent);
                            }

                          },
                          child: Center(
                              child: Container(
                                height: MediaQuery.of(context).size.height /22,
                                width: MediaQuery.of(context).size.width /3,
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
                                      "allow".tr,
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
                  child: const Text(""),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/40,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
