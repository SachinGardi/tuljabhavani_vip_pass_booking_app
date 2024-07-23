import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tulajapur/baseUrl/base_url.dart';

import '../../common_widget/progress_indicator.dart';


class SplDarshanPassView extends StatefulWidget {
  const SplDarshanPassView({Key? key}) : super(key: key);

  @override
  State<SplDarshanPassView> createState() => _SplDarshanPassViewState();
}
class _SplDarshanPassViewState extends State<SplDarshanPassView> {

  bool passLoader = true;
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
      return SafeArea(
      child: Scaffold(
          appBar:AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
                systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2),
              ),
              elevation: 0,
              leading:IconButton(
                onPressed: (){
                  Get.offAllNamed("/transactionHistory");
                },
                icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 35),
              ),
              title: Text("transactionEPassView".tr,style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "OpenSans",
                  color: Color(0xFFFFFFFF))),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Color(0xFFEC6019), Color(0xFFFEB148),Color(0xFFFEB148)])))),
          body: WillPopScope(
              onWillPop: ()async{
                Get.offAllNamed("/transactionHistory");
                return false;
              },
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse("$passGeneratedLink${Get.arguments}")),
                    onWebViewCreated: (InAppWebViewController controller){
                      webViewController = controller;
                    },
                    onLoadStart: (InAppWebViewController controller, url) {
                      print("onLoadStart URL : $url");
                      setState(() {
                        passLoader = true;
                      });
                    },
                    onLoadStop: (InAppWebViewController controller,  url) async {
                      print("onLoadStop URL : $url");
                      setState(() {
                        passLoader = false;
                      });


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
                        ))),
                  if (passLoader == true)
                    Center(
                      child: progressIndicator(),
                    ),
                ],
              ))),
    );}
}


