import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tulajapur/baseUrl/base_url.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({Key? key}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
              systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2),
            ),
            elevation: 0,
            leading:IconButton(
                onPressed: (){
                  Get.offAllNamed("/dashBoard");
                },
                icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 35)),
            title: Text("help".tr,style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: "OpenSans",
                color: Color(0xFFFFFFFF))),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Color(0xFFEC6019), Color(0xFFFEB148),Color(0xFFFEB148)])),
            )),
        body: WillPopScope(
          onWillPop: ()async{
            Get.offAllNamed("/dashBoard");
            return false;
          }, child:
            SfPdfViewer.network(userManual))
    );
  }
}