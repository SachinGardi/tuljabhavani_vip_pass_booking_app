import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mlkit_scanner/widgets/barcode_scanner.dart';
import 'package:tulajapur/view/common_widget/common_appBar.dart';
import 'package:tulajapur/view/common_widget/common_button.dart';
import 'package:tulajapur/view/validator_module/scan_pass/scan_pass_string.dart';
import '../../../view_modal/validator/get_scanner_validator_vm.dart';
import '../../common_widget/snack_bar.dart';



class ScannerView extends StatefulWidget {
  const ScannerView({Key? key}) : super(key: key);

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

var isScanned = false.obs;


class _ScannerViewState extends State<ScannerView> {
  ValidatorScannerDetailsVM validatorScannerDetailsVM = Get.put(ValidatorScannerDetailsVM());

  @override
  void initState() {

    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white30,
        appBar: commonAppBar('scanAppBar'.tr),
        body: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              reverse: true,
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height/8,),
                        Container(
                          height: MediaQuery.of(context).size.height/3,
                          width: MediaQuery.of(context).size.width/1.42,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child:BarcodeScanner(
                            onScannerInitialized: (controller)async{
                              controller.startScan(0);
                              controller.setDelay(4000);
                              controller.pauseCamera();
                              controller.resumeCamera();
                            },
                            onCameraInitializeError: (error) {
                              },
                            onScan: (barcode) {
                              setState(() {
                                String barcodeText = barcode.rawValue;
                                WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                                  validatorScannerDetailsVM.isLoading.value = true;
                                  validatorScannerDetailsVM.scannerDetails.clear();
                                  await validatorScannerDetailsVM.getValidatingDetails(barcodeText, context);
                                  barcodeText = "";
                                });
                              });

                            },
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/60),
                        Text(
                          'or'.tr,
                          style: TextStyle(color: const Color(0xffFFFFFF),
                              fontWeight: FontWeight.w600,
                              fontSize: MediaQuery.of(context).size.height/50,
                              fontFamily: "OpenSans"),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/60),
                        SizedBox(
                            width: MediaQuery.of(context).size.width/1.4,
                            child: TextFormField(
                                controller: barcodeController,
                                cursorColor: Colors.black,
                                cursorWidth: 1,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    hintText: 'codeNo'.tr,
                                    hintStyle:   TextStyle(
                                        fontSize: MediaQuery.of(context).size.height/60,
                                        fontFamily: "OpenSans",
                                        color: const Color(0xff494949)
                                    ),
                                    fillColor: const Color(0xffFFFFFF),
                                    filled: true,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none)))),
                        SizedBox(height: MediaQuery.of(context).size.height/30),
                        GestureDetector(
                            onTap: () {
                              if(barcodeController.text == ""){
                                toastMessage(context, "emptyBarcodeText".tr,);
                              }
                              else{
                                setState(() {
                                  FocusScope.of(context).unfocus();
                                  isScanned.value = true;
                                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                                    validatorScannerDetailsVM.isLoading.value =true;
                                    validatorScannerDetailsVM.scannerDetails.clear();
                                    await validatorScannerDetailsVM.getValidatingDetails(barcodeController.text, context);
                                    barcodeController.text = "";
                                  });

                                });
                              }


                            },
                            child: commonButton(context, 'scanBtn'.tr)
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/20),
                      ],
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
    );
  }
}
