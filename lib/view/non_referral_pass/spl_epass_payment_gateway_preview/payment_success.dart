
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/view/common_widget/common_button.dart';
import 'package:tulajapur/view/non_referral_pass/spl_epass_payment_gateway_preview/payment_gateway_common_widgets.dart';
import '../../../view_modal/payment_preview_vm/payment_response_vm.dart';
import '../../common_widget/progress_indicator.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SplePassPaymentSuccessView extends StatefulWidget {
  const SplePassPaymentSuccessView({Key? key}) : super(key: key);

  @override
  State<SplePassPaymentSuccessView> createState() => _SplePassPaymentSuccessViewState();
}

class _SplePassPaymentSuccessViewState extends State<SplePassPaymentSuccessView>  {

  PaymentResponseVM  paymentResponseVM = Get.put(PaymentResponseVM());
  String? devoteeId;

  clearSharedPreference()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("isPassGenerated");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clearSharedPreference();
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
        Get.offAllNamed("/dashBoard");
        return false;
      },
      child:Obx(()=> ModalProgressHUD(
        inAsyncCall: paymentResponseVM.isLoading.value == true,
        progressIndicator: progressIndicator(),
        child:
        Scaffold(
          backgroundColor: const Color(0xFFF5F6F9),
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
              systemNavigationBarDividerColor:
              const Color(0xFFEC6019).withOpacity(0.2),
            ),
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                Get.offAllNamed("/dashBoard");
              },
              icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 35,),
            ),

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
          body:   Center(
            child: Padding(
              padding:  EdgeInsets.only(bottom:MediaQuery.of(context).size.height /10),
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
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: MediaQuery.of(context).size.height/12,
                        )
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/60),
                    Text('paymentSuccessful'.tr, style:    TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height/45,
                        color: Colors.black),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/45),
                    const Divider(
                      color: Colors.black54,
                      thickness: 2,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/100),
                    Column(
                      children: [
                        devoteeInformation(context,"bookingId".tr,paymentResponseVM.bookingId == null? "-":paymentResponseVM.bookingId.toString()),
                        devoteeInformation(context,"bankRefNo".tr,paymentResponseVM.transactionStatus == null? "-":paymentResponseVM.transactionStatus.toString()),
                        devoteeInformation(context,"amountInRupee".tr,paymentResponseVM.amount == null? "-":"₹ ${paymentResponseVM.amount!.toStringAsFixed(0)}"),
                        devoteeInformation(context,"transactionDate".tr,paymentResponseVM.transactionDate == null? "-":paymentResponseVM.transactionDate!),

                      ],                      ),
                    const Divider(
                      color: Colors.black54,
                      thickness: 2,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/50),
                    Text("paymentSuccess".tr,

                      style:TextStyle(
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold,
                          wordSpacing: 4,
                          fontSize: MediaQuery.of(context).size.height/60,
                          color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/20),
                    GestureDetector(
                        onTap: () async {
                          var selectedLang = ''.obs;
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          String language =  pref.getString('language') ?? 'English';
                          if(language == "Marathi"){
                            selectedLang.value = "mr";
                            print(selectedLang);
                          }
                          else if(language == "English"){
                            selectedLang.value = "en";
                            print(selectedLang);
                          }

                          String encryptionKey = '8080808080808080';
                          final key = encrypt.Key.fromUtf8(encryptionKey);
                          final iv = encrypt.IV.fromUtf8(encryptionKey);
                          final encrypter =
                          encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
                          var encryptedInvoiceId = encrypter.encrypt(devoteeId!, iv: iv);
                          var encodedDecryptedUrl = Uri.encodeComponent(encryptedInvoiceId.base64).replaceAll('%20', '+');
                           print(encodedDecryptedUrl);
                          // Get.offAllNamed("/paymentGatewayPassView",arguments:devoteeId);
                          Get.offAllNamed("/paymentGatewayPassView",arguments:"$encodedDecryptedUrl&lan=${selectedLang.value}");
                        },
                        child: commonButton(context, 'downloadPass'.tr))
                  ],
                ))))))));
  }
}
