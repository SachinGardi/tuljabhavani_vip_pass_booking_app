import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../view_modal/about_temple_vm/about_temple_vm.dart';
import '../common_widget/common_appBar.dart';
import '../common_widget/progress_indicator.dart';

class AboutTemple extends StatefulWidget {
  const AboutTemple({Key? key}) : super(key: key);

  @override
  State<AboutTemple> createState() => _AboutTempleState();
}

class _AboutTempleState extends State<AboutTemple> {

  final abouttempleVM = Get.put(AbouttempleVM());
  apiCalling()async{
    abouttempleVM.templeList.clear();
    abouttempleVM.isLoading.value = true;
    await abouttempleVM.getTempleInfo();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCalling();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed("/dashBoard");
        return false;
      },
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: Scaffold(
          appBar: allNotification("aboutTempleAppBarTitle".tr),

          body: Obx(()=>
              ModalProgressHUD(
                color: Colors.black,
                inAsyncCall: abouttempleVM.isLoading.value == true,
                progressIndicator: progressIndicator(),
              child: Padding(
                padding:  EdgeInsets.only(top:20,left:MediaQuery.of(context).size.width/30,right: MediaQuery.of(context).size.width/30),
                child: ListView(
                  children: [

                    (abouttempleVM.isLoading.value == true ||
                        abouttempleVM.templeList.isEmpty || imagePathTemple == null)
                        ?Container(
                        height: MediaQuery.of(context).size.height/3.8,
                        width:MediaQuery.of(context).size.width,

                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                        child:Image(
                            image: ResizeImage(
                              allowUpscaling: true,
                              policy: ResizeImagePolicy.exact,
                            const AssetImage("assets/images/dashboard/DeviImage.png"),
                              width: MediaQuery.of(context).size.width.toInt(),
                              height: MediaQuery.of(context).size.height ~/3.8,
                            ),
                            fit: BoxFit.fill,
                            colorBlendMode: BlendMode.darken,
                            filterQuality: FilterQuality.high)
                    ):
                    Container(
                      height: MediaQuery.of(context).size.height/3.8,
                      width:MediaQuery.of(context).size.width,

                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                      child:Image(
                          image: ResizeImage(
                            allowUpscaling: true,
                            policy: ResizeImagePolicy.exact,
                            NetworkImage(imagePathTemple==null ?"":imagePathTemple!),

                            width: MediaQuery.of(context).size.width.toInt(),
                            height: MediaQuery.of(context).size.height ~/3.8,
                          ),
                          fit: BoxFit.fill,
                          colorBlendMode: BlendMode.darken,
                          filterQuality: FilterQuality.high)
                    ),
                    const SizedBox(height: 20),
                    Center(child:Text(headingTemple == null ? "":headingTemple!,style: TextStyle(fontSize: MediaQuery.of(context).size.height/50,
                        fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",color: const Color(0xFFED6A1F)),)),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/50,right:MediaQuery.of(context).size.width/120 ),
                      child: Text(
                        descriptionTemple== null? "":descriptionTemple!,
                          textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: MediaQuery.of(context).size.height/52,
                          fontFamily: "OpenSans",color: Colors.black),),
                    )
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
