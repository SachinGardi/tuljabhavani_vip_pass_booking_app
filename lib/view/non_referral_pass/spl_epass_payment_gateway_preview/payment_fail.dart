
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulajapur/view/common_widget/common_button.dart';
import 'package:tulajapur/view/non_referral_pass/spl_epass_payment_gateway_preview/payment_gateway_common_widgets.dart';
import '../../../view_modal/payment_preview_vm/payment_response_vm.dart';
import '../../common_widget/progress_indicator.dart';

class SplePassPaymentFail extends StatefulWidget {
  const SplePassPaymentFail({Key? key}) : super(key: key);

  @override
  State<SplePassPaymentFail> createState() => _SplePassPaymentFailState();
}

class _SplePassPaymentFailState extends State<SplePassPaymentFail> {
  PaymentResponseVM  paymentResponseVM = Get.put(PaymentResponseVM());
  String? devoteeId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    devoteeId = Get.arguments;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      paymentResponseVM.paymentDetails.clear();
      paymentResponseVM.isLoading.value = true;
      await paymentResponseVM.getPaymentDetails(devoteeId!);
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        paymentFailureDialog(context);
        return false;
      },
      child: Obx(()=> ModalProgressHUD(
        inAsyncCall: paymentResponseVM.isLoading.value == true,
        progressIndicator: progressIndicator(),
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F6F9),
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
              systemNavigationBarDividerColor:
              const Color(0xFFEC6019).withOpacity(0.2),
            ),
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              "paymentStatus".tr,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 23,
                  color: const Color(0xFFFFFFFF)),
            ),
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
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:  EdgeInsets.only(
                top:MediaQuery.of(context).size.height/20 ,
                left: MediaQuery.of(context).size.width/15,
                right: MediaQuery.of(context).size.width/15,

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.redAccent,
                        size: MediaQuery.of(context).size.height/15,
                      )
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/60),

                  Text('paymentFailed'.tr, style:TextStyle(
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height/45,
                      color: Colors.redAccent)),
                  SizedBox(height: MediaQuery.of(context).size.height/30),
                  const Divider(
                    color: Colors.black54,
                    thickness: 2,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/100),
                  Column(
                    children: [
                      devoteeInformation(context,"bankRefNo".tr,paymentResponseVM.transactionStatus == null? "-":paymentResponseVM.transactionStatus.toString()),
                      devoteeInformation(context,"amountInRupee".tr,paymentResponseVM.amount == null? "-":paymentResponseVM.amount!.toStringAsFixed(0)),
                      devoteeInformation(context,"transactionDate".tr,paymentResponseVM.transactionDate == null? "-":paymentResponseVM.transactionDate.toString()),
                    ],
                  ),
                  const Divider(
                    color: Colors.black54,
                    thickness: 2,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/50),

                  Text(
                    'paymentFailedNote'.tr,
                    style:TextStyle(
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height/60,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/15,),
                  GestureDetector(
                      onTap: (){
                        Get.offAllNamed("/splDonationEPassPaymentDetails");
                      },
                      child: commonButton(context, 'tryagain'.tr))
                ],
              ),
            ),
          ),
        ),
      ),),
    );
  }
}


Future<void> paymentFailureDialog(BuildContext context) async {
  await showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          title: Text('alert'.tr),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('exitApp'.tr),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No'.tr),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('Yes'.tr),
              onPressed: () {
                Get.offAllNamed("/dashBoard");
              },
            ),
          ],
        );
      });
}