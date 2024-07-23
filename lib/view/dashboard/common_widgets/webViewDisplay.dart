import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../common_widget/common_appBar.dart';

class WebViewDisplay extends StatefulWidget {
  const WebViewDisplay({Key? key}) : super(key: key);

  @override
  State<WebViewDisplay> createState() => _WebViewDisplayState();
}

class _WebViewDisplayState extends State<WebViewDisplay> {
  dynamic argumentData = Get.arguments;
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: webviewAppBar(Get.arguments[0]),
          body: WillPopScope(
              onWillPop: () async {
                Get.offAllNamed("/dashBoard");
                return false;
              },
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(Get.arguments[1])),
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                },
                onLoadStart: (InAppWebViewController controller, url) {},
                onLoadStop: (InAppWebViewController controller, url) async {},
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
              ))),
    );
  }
}
