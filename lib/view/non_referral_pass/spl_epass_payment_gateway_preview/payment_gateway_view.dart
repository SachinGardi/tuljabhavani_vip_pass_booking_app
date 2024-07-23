import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tulajapur/view/non_referral_pass/spl_epass_payment_gateway_preview/payment_gateway_common_widgets.dart';
import 'package:tulajapur/view_modal/payment_preview_vm/payment_devotee_info_vm.dart';
import '../../../baseUrl/base_url.dart';
import '../../../view_modal/payment_preview_vm/payment_response_vm.dart';
import '../../common_widget/progress_indicator.dart';

class SplePassPaymentGatewayView extends StatefulWidget {
  const SplePassPaymentGatewayView({Key? key}) : super(key: key);

  @override
  State<SplePassPaymentGatewayView> createState() => _SplePassPaymentGatewayViewState();
}

class _SplePassPaymentGatewayViewState extends State<SplePassPaymentGatewayView> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  PaymentResponseVM paymentResponseVM = Get.put(PaymentResponseVM());

  InAppWebViewController? webViewController;
  var isLoading = true.obs;
  String? devoteeId;
  bool paymentLoader = true;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    devoteeId = Get.arguments;
  }

  String? innerHtmlData;
  InAppWebViewController? _webViewController;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          showPaymenytDialog(context);
          return false;
        },
        child: Scaffold(
          appBar: paymentGatewayAppBar("paymentAppBar".tr, context),
          body:Stack(
            children: [
              InAppWebView(
                initialData: InAppWebViewInitialData(
                    data: paymentResponse!,
                    mimeType: 'text/html',
                    encoding: Encoding.getByName('utf-8').toString(),
                    baseUrl: Uri.parse(paymentOrigin)),
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                },
                onLoadStart: (InAppWebViewController controller, url) {
                  print("OnLoad start");
                  print(url);
                  setState(() {
                    paymentLoader = true; // Show the loader when a new page starts loading
                  });
                },
                onLoadStop: (InAppWebViewController controller, url) async {
                  print("OnLoad start");
                  print(url);
                  setState(() {
                    paymentLoader = false; // Show the loader when a new page starts loading
                  });

                  if (url.toString().startsWith(
                      'https://www.sbiepay.sbi/secure/failure.jsp') ==
                      true) {
                    showTimeOutDialog(context);
                  }
                  else if(url.toString().startsWith(
                      '$paymentOrigin/payment-response?id=$devoteeId') ==
                      true){
                   await paymentResponseVM.getPaymentDetails(devoteeId!);
                   if(paymentResponseVM.paymentStatus == "SUCCESS"){
                     Get.offAllNamed("/splePassPaymentSuccessView", arguments: devoteeId);
                   }
                   else if(paymentResponseVM.paymentStatus == "FAIL"){
                     Get.offAllNamed("/splePassPaymentFail", arguments: devoteeId);
                   }
                  }


                },
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      useShouldOverrideUrlLoading: true,
                      mediaPlaybackRequiresUserGesture: false,
                      javaScriptCanOpenWindowsAutomatically: true,
                      useShouldInterceptFetchRequest: true,
                    ),
                    android: AndroidInAppWebViewOptions(
                      useShouldInterceptRequest: true,
                      useHybridComposition: true,
                    ),
                    ios: IOSInAppWebViewOptions(
                      allowsInlineMediaPlayback: true,
                    )),
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  final uri = navigationAction.request.url.toString();
                  if (uri.startsWith("http") || uri.startsWith("https")) {
                    return NavigationActionPolicy.ALLOW; // Allow the navigation
                  }
                  if (uri.startsWith("upi://pay?")) {
                    try {
                      final intentUri = Uri.parse(uri);
                      final fallbackUrl = intentUri.queryParameters["pa"];
                      if (fallbackUrl != null) {
                        _webViewController?.loadUrl(
                            urlRequest:
                            URLRequest(url: Uri.parse(fallbackUrl)));
                        return NavigationActionPolicy.CANCEL;
                      }
                    } catch (e) {
                      // Not an intent URI
                    }
                  }
                  return NavigationActionPolicy.ALLOW; // Allow the navigation
                },
              ),
              if (paymentLoader)
                Center(
                  child: progressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
