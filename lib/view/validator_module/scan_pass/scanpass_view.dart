import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/view/common_widget/common_button.dart';
import 'package:tulajapur/view/validator_module/scan_pass/scanner_view.dart';
import '../../../view_modal/logout_vm.dart';
import '../../common_widget/snack_bar.dart';


class ScanPass extends StatefulWidget {
  const ScanPass({Key? key}) : super(key: key);
  @override
  State<ScanPass> createState() => _ScanPassState();
}
LogoutViewModal logoutViewModal = Get.put(LogoutViewModal());
RxString userName = "".obs;

class _ScanPassState extends State<ScanPass> {
 Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userName.value = preferences.getString("userName")!;
  }
  /// For trminating Application
 DateTime preBackpress = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getName();
    });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: ()async{
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          toastMessage(context,"Press back button again to exit");
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6F9),
        body: Stack(
          children: [
            Material(
              clipBehavior: Clip.antiAlias,
              shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35.0),
                      bottomRight: Radius.circular(35.0))),
              child: Container(
                height: MediaQuery.of(context).size.height /2,
                width: MediaQuery.of(context).size.width,
                clipBehavior: Clip.hardEdge,
                decoration:  BoxDecoration(
                  color:  const Color(0xFFEC6019).withOpacity(0.9),
                ),
                child:  ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      const Color(0xFFE23500).withOpacity(0.4), BlendMode.dstATop),
                  child: const Image(
                    image: AssetImage("assets/images/loginImage.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height/9),
              child:Center(
                child: Container(
                  height: MediaQuery.of(context).size.height/4,
                  width: MediaQuery.of(context).size.width / 1.21,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFFFFFFF),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 3),
                            blurRadius: 6)
                      ]),
                  child: Padding(
                    padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width/22,right:MediaQuery.of(context).size.width/22 ),
                    child:  Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height/100),
                        Center(
                          child:CircleAvatar(
                            radius: MediaQuery.of(context).size.height/28,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white,
                            child: const Image(image: AssetImage("assets/images/dashboard/Tuljapurlogo_new1.png"),fit: BoxFit.fill,),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/80,
                        ),
                        Obx(
                          ()=> Text(userName.value == ""? "hello".tr
                                :"${"hello".tr} ${userName.value}",
                            style:
                            TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.height/55, color:Colors.black),),
                        ),
                        GestureDetector(
                          onTap: ()  async {
                            PermissionStatus status = await Permission.camera.request();
                            if(status == PermissionStatus.permanentlyDenied ||status == PermissionStatus.denied )
                              {
                                SchedulerBinding.instance.addPostFrameCallback((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 3),
                                        content: Row(
                                          children: [
                                           Text("cameraPermission".tr),
                                            const Spacer(),
                                            TextButton(onPressed: (){
                                              openAppSettings();
                                            }, child:  Text("setting".tr))

                                          ],
                                        ),
                                      ));
                                });


                              }
                              else{
                                isScanned.value = false;
                                Get.toNamed("/scannerView");
                              }

                              },

                          child: Padding(
                            padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/15,right: MediaQuery.of(context).size.width/15,top:MediaQuery.of(context).size.height/40),
                            child: Container(
                              height:MediaQuery.of(context).size.height/16,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black38.withOpacity(0.1)),
                                  color: const Color(0xFFFFFFFF),
                                  boxShadow:  const [
                                    BoxShadow(
                                        color:  Colors.black38,
                                       offset: Offset(2, 3),
                                        blurRadius: 6)
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/images/validator/Scan Pass.svg",fit: BoxFit.fill,height: MediaQuery.of(context).size.height/30,),
                                  SizedBox(width: MediaQuery.of(context).size.width/20,),
                                  Text("scanPassBtnText".tr, style:
                                  TextStyle(
                                      fontFamily: "OpenSans",
                                      fontWeight: FontWeight.w600,
                                      fontSize: MediaQuery.of(context).size.height/45, color:Colors.black),
                                  ),
                                ],
                              ),),
                          ),
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/1.6),
              child:Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/6,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         GestureDetector(
                           onTap: (){
                             Get.toNamed("/changePassword");
                           },
                           child:commonButton(context,"changePasswordAppBarTitle".tr)),

                        GestureDetector(
                          onTap: (){
                            showDialog(
                                barrierDismissible: false,
                                barrierColor: Colors.transparent.withOpacity(0.5),
                                context: context,

                                builder: (_) =>

                            AlertDialog(
                            title: Text("logOutBtnText".tr,),
                            content: Text("logoutAlert".tr),
                            actions: <Widget>[
                            TextButton(
                            onPressed: () {
                            Get.back();
                            },
                            child: Text("No".tr,style:   TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.height/60, color:Colors.orange),
                            ),
                            ),
                            TextButton(
                            onPressed: () async {
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              await logoutViewModal.logoutCurrentUser(pref.getString("loginUserId").toString(),"0",context);
                            if(logoutViewModal.statusCode == "200"){
                              toastMessage(context, "LogoutToast".tr);
                              Get.offAllNamed("/loginView");
                              SharedPreferences preferences = await SharedPreferences.getInstance();
                              preferences.remove('login') ;
                              preferences.remove('loginUserId') ;
                              preferences.remove('userName') ;
                              preferences.remove('trusteeLogin');
                            }
                            else{
                              toastMessage(context, "Please try again");
                            }
                         },
                            child: Text("Yes".tr,
                                style:   TextStyle(
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.w600,
                                    fontSize: MediaQuery.of(context).size.height/60, color:Colors.orange)),
                            ),

                            ],
                            ));
                          },



                          child: commonButton(context, "logOutBtnText".tr)

                        ),
                      ],
                    ),
                ),
              ),

            )

          ],
        ),
      ),
    );
  }
}
