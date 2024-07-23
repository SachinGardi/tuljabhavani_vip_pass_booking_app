import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import 'package:tulajapur/view/non_referral_pass/spl_donation_epass_paymentdetail/payment_deatil_common_widget.dart';

import '../../../view_modal/payment_preview_vm/payment_devotee_info_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/spl_donation_payable_details_vm/spl_ePass_payable_details.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/progress_indicator.dart';
final devoteePaymentInfoVM = Get.put(DevoteePaymentInfoVM());
class SplDonationEPassPaymentDetails extends StatefulWidget {
  const SplDonationEPassPaymentDetails({Key? key}) : super(key: key);

  @override
  State<SplDonationEPassPaymentDetails> createState() =>
      _SplDonationEPassPaymentDetailsState();
}

class _SplDonationEPassPaymentDetailsState
    extends State<SplDonationEPassPaymentDetails> {
  SplePassPayableDetailsVM splePassPayableDetailsVM =
      Get.put(SplePassPayableDetailsVM());

  bool isChecked = true;

   paymentBottomSheet(BuildContext context) => showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (context) {
          return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 50,
                    horizontal: MediaQuery.of(context).size.width / 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "selectPayment".tr,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 50,
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              color: Colors.black),
                        ),
                        GestureDetector(
                            onTap: () {
                              isChecked = true;
                              Get.back();
                            },
                            child:
                            const Icon(Icons.cancel_outlined, color: Colors.red)),
                      ],
                    ),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height / 50),
                    Text("selectPaymentNote".tr,
                      maxLines: 3,
                      style: TextStyle(
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height / 55,
                          color: Colors.black),
                      // maxLines: 2,
                      softWrap: true,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/80),
                    const Divider(color: Colors.black,height: 2),
                    SizedBox(height: MediaQuery.of(context).size.height/80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          shape:const CircleBorder(side:BorderSide(color: Colors.black)),
                          activeColor: Colors.white,
                          checkColor: Colors.orange,
                          side: const BorderSide(color: Colors.black),
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Text(
                          "paymentGateway".tr,
                          maxLines: 1,
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 55,
                              color: Colors.black),
                          softWrap: true,
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height / 20),
                    GestureDetector(
                        onTap: () async {
                          if (isChecked == false) {
                            paymentSnackBar(
                                context, "toastSelectPayment".tr);
                          }
                          else {
                            SharedPreferences preference = await SharedPreferences.getInstance();
                            int devoteeId = preference.getInt("devoteeId")!;
                            String? ePassId = preference.getString("ePassId");
                            String? dateString = preference.getString("visitDate")!;
                            DateTime? visitDate =  DateFormat('yyyy-MM-dd').parse(dateString);
                            print(visitDate);
                            String? timeSlotId = preference.getString("timeSlotId");
                            String? passAmount = preference.getString("passAmount");
                            await devoteePaymentInfoVM.paymentInfoVM(
                                context, devoteeId.toString(),
                                splePassPayableDetailsVM.totalAmount!,visitDate,timeSlotId,ePassId,passAmount);

                            if(devoteePaymentInfoVM.statusCode == "200"){
                              Get.offAllNamed("/splePassPaymentGatewayView",
                                  arguments: devoteeId.toString());
                            }
                            else if(devoteePaymentInfoVM.statusCode == "404"){
                              Get.back();
                              capacityFullDialogue(context);

                            }
                            else if(devoteePaymentInfoVM.statusCode == "409"){
                              Get.back();
                              blockDayDialogue(context);

                            }
                            else if(devoteePaymentInfoVM.statusCode == '500'){
                              Get.back();
                              toastMessage(context, "serverError".tr);
                            }



                          }

                        },
                        child: commonButton(context, "makePayment".tr)),
                  ],
                ),
              ),
            );
          }
          );
        },
      );

  paymentDetails() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
   int devoteeId = preference.getInt("devoteeId")!;
    splePassPayableDetailsVM.devoteePaymentDetailsList.clear();
    splePassPayableDetailsVM.isLoading.value = true;
    await splePassPayableDetailsVM.getDevoteePaymentDetailVm(devoteeId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: paymentDetailAppBar("paymentPreview".tr),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: splePassPayableDetailsVM.isLoading.value == true,
          progressIndicator: progressIndicator(),
          child: WillPopScope(
            onWillPop:()async{
              Get.offAllNamed("/splePassDetailsView");
              return false;
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 70,
                    horizontal: MediaQuery.of(context).size.width / 25),
                child: Column(
                  children: [
                    devoteePaymentDetail(context, "primaryDevotee".tr,
                        splePassPayableDetailsVM.devoteeName ?? ""),
                    devoteePaymentDetail(context, "mobileNo".tr,
                        splePassPayableDetailsVM.mobileNo ?? ""),
                    devoteePaymentDetail(context, "paymentVisitDate".tr,
                        splePassPayableDetailsVM.visitDate ?? ""),
                    devoteePaymentDetail(context, "paymentVisitTime".tr,
                        splePassPayableDetailsVM.visitTime ?? ""),
                    devoteePaymentDetail(context, "paymentDevotees".tr,
                        splePassPayableDetailsVM.noOfDevotees ?? ""),
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    Divider(
                      thickness: 1,
                      color: Colors.deepOrangeAccent.shade100,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height /3.7,
                      width: MediaQuery.of(context).size.width,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.deepOrangeAccent)),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height /15,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.orangeAccent.withOpacity(0.5),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2, child: tableLabel(context, "paymentSrNo".tr)),
                                Expanded(
                                    flex: 4,
                                    child: tableLabel(context, "paymentEPass".tr)),
                                Expanded(
                                    flex: 2, child: tableLabel(context, "paymentQty".tr)),
                                Expanded(
                                    flex: 2,
                                    child: tableLabel(context, "paymentAmount".tr)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2, child: tableLabel2(context, "1")),
                                Expanded(
                                    flex: 4,
                                    child: tableLabel2(
                                        context,
                                        splePassPayableDetailsVM.ePassName ??
                                            "")),
                                Expanded(
                                    flex: 2,
                                    child: tableLabel2(
                                        context,
                                        splePassPayableDetailsVM.noOfDevotees ??
                                            "")),
                                Expanded(
                                    flex: 2,
                                    child: tableLabel2(
                                        context,
                                       "₹ ${splePassPayableDetailsVM.passAmount}" ??
                                            "")),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.deepOrangeAccent.shade100,
                            thickness: 1,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height /90),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "paymentTotalAmount".tr,
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height /45,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "OpenSans",
                                    color: Colors.black),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width /10),
                              Text(
                               "₹ ${splePassPayableDetailsVM.totalAmount}" ?? "",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height /45,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "OpenSans",
                                    color: Colors.deepOrangeAccent),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width /25),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height /50),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height /15,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            paymentBottomSheet(context);
                          });
                        },
                        child: commonButton(context, "paymentProceed".tr))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
