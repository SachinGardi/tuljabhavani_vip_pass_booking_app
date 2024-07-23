import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tulajapur/view/login_page/login_string.dart';
import '../../internet_service/CheckInternetCon.dart';
import '../common_widget/common_button.dart';
import '../common_widget/progress_indicator.dart';
import '../common_widget/snack_bar.dart';
import '../dashboard/dashboard_view.dart';
import '../forgot_password/forgot_password_string.dart';
import '../forgot_password/forgot_password_view.dart';
import '../forgot_password/forgot_password_widget.dart';
import 'login_functionality.dart';
import 'login_widgets.dart';

bool loginVisited = false;
bool? loginPressed ;
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode fNode = FocusNode();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    setState(() {
      loginPressed = false;
      loginVisited = true;
      loginPasswordVisibility = true;
      loginUserName.clear();
       loginPassword.clear();
      isValidatorSelected= true;
      userLoginId = 2;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    return Obx(()=>
     ModalProgressHUD(
      color: Colors.black,
      inAsyncCall:loginTap.value == true ,
      progressIndicator: progressIndicator(),
      child: Scaffold(
          extendBody: true,
          backgroundColor: const Color(0xFFF5F6F9),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: WillPopScope(
                    onWillPop: () async {
                      Get.offAllNamed("/dashBoard");
                      return false;
                    },
                    child: Stack(
                      children: [
                    Material(
                      textStyle: const TextStyle(decoration: TextDecoration.none),
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
                              EdgeInsets.only(top: MediaQuery.of(context).size.height/8.2),
                          child:  Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height/2.10,
                              width: MediaQuery.of(context).size.width/1.20,
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
                                padding:  EdgeInsets.only(
                                  top:MediaQuery.of(context).size.height/100 ,
                                    left:MediaQuery.of(context).size.width/26,
                                    right:MediaQuery.of(context).size.width/26,
                                bottom:MediaQuery.of(context).size.height/140 ),
                                child: Form(
                                  key: formKey,
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [

                                      Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(width: MediaQuery.of(context).size.width/3.2),

                                          Center(
                                            child: CircleAvatar(
                                              radius: MediaQuery.of(context).size.height/34,
                                              foregroundColor: Colors.white,
                                              backgroundColor: Colors.white,
                                              child: const Image(image: AssetImage("assets/images/dashboard/Tuljapurlogo_new1.png",),fit: BoxFit.fill,),
                                            ),

                                          ),
                                          const Spacer(),
                                             GestureDetector(
                                               onTap: (){
                                                 assetsAudioPlayer.stop();
                                                 Get.offAllNamed("/dashBoard");
                                               },
                                               child: Padding(
                                                 padding: EdgeInsets.only(
                                                   top: MediaQuery.of(context).size.height/230,
                                                     bottom: MediaQuery.of(context).size.height/15
                                                 ),
                                                 child: Row(
                                                   children: [
                                                     Icon(Icons.arrow_back_ios,size: MediaQuery.of(context).size.height/60,),
                                                     Text("back".tr,style:
                                                     TextStyle(
                                                         fontFamily: "OpenSans",
                                                         fontWeight: FontWeight.w500,
                                                         fontSize: MediaQuery.of(context).size.height/60,
                                                         color: Colors.black))
                                                   ],
                                                 ),
                                               ),
                                             )


                                        ],
                                      ),

                                       Center(
                                        child: Text(
                                          "loginTitle".tr,
                                          style:
                                       TextStyle(
                                              fontFamily: "OpenSans",
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context).size.height/35, color: Colors.black),
                                        ),
                                      ),
                                      SizedBox(height:MediaQuery.of(context).size.height/130),
                                       /*const TrusteeValidatorTab(),*/
                                      SizedBox(height:MediaQuery.of(context).size.height/45),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height/19,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],


                                          controller: loginUserName,
                                          keyboardType: TextInputType.number,


                                          cursorColor: Colors.black26,
                                          cursorWidth: 1,

                                          style:  TextStyle(
                                            fontSize: MediaQuery.of(context).size.height/48,
                                            fontFamily: "OpenSans",
                                            color: Colors.black,
                                          ),

                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(bottom:2),
                                              prefixIcon:
                                              SvgPicture.asset(
                                                'assets/images/login/Username_Validator.svg',
                                                color: Colors.black,
                                                fit: BoxFit.scaleDown,
                                                height: 6,
                                                width: 5,

                                              ),

                                              filled: true,

                                              fillColor: const Color(0xFFF2F2F2),
                                              isDense: true,
                                              hintText: "userNameHint".tr,
                                              hintStyle:   TextStyle(

                                                fontFamily: "OpenSans",
                                                fontSize: MediaQuery.of(context).size.height/61,
                                                color:  const Color(0xFF797979),

                                              ),

                                              border: OutlineInputBorder(

                                                borderRadius: BorderRadius.circular(7),
                                                borderSide: BorderSide.none,)),
                                        ),
                                      ),
                                      SizedBox(height:MediaQuery.of(context).size.height/60),
                                      SizedBox(
                                        height:  MediaQuery.of(context).size.height/19,
                                        width: MediaQuery.of(context).size.width,
                                        child: TextFormField(


                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(42),

                                            FilteringTextInputFormatter.deny(
                                                  RegExp(r'\s')),
                                          ],
                                          controller: loginPassword,
                                          focusNode: fNode,
                                          obscureText: loginPasswordVisibility,
                                          onChanged: (value){
                                            setState(() {
                                              if(value.length == 42){
                                                FocusScope.of(context).unfocus();
                                              }
                                            });

                                          },

                                          onTapOutside:   (value) async {

                                            FocusScope.of(context).unfocus();
                                      },
                                          keyboardType: TextInputType.emailAddress,
                                          cursorColor: Colors.black26,
                                          cursorWidth: 1,
                                          expands: false,
                                          style:  TextStyle(
                                            fontSize: MediaQuery.of(context).size.height/48,
                                            fontFamily: "OpenSans",
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(
                                                bottom: 2),
                                              suffixIcon:
                                              IconButton(onPressed: (){

                                               setState(() {
                                                 loginPasswordVisibility  =! loginPasswordVisibility;
                                               });
                                                }, icon: loginPasswordVisibility
                                                  ? const Icon(Icons.visibility_off,color: Colors.black45)
                                                  : const Icon(Icons.visibility,color: Colors.black45)),
                                              prefixIcon:  SvgPicture.asset(
                                                'assets/images/login/Password_Validator.svg',
                                                fit: BoxFit.scaleDown,
                                                height: 5,
                                                width: 5,
                                                color: Colors.black,

                                              ),
                                              filled: true,
                                              fillColor: const Color(0xFFF2F2F2),
                                              isDense: true,
                                              hintText: "passwordHint".tr,

                                              hintStyle: TextStyle(
                                                fontFamily: "OpenSans",
                                                fontSize: MediaQuery.of(context).size.height/60,
                                                color:  const Color(0xFF797979),
                                              ),
                                              focusedBorder: OutlineInputBorder(

                                                borderSide: BorderSide.none,

                                                borderRadius: BorderRadius.circular(10),

                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(7),
                                                borderSide: BorderSide.none,)),
                                        ),
                                      ),
                                      SizedBox(height:MediaQuery.of(context).size.height/50),
                                      GestureDetector(
                                        onTap: (){

                                        setState(() {
                                          forgotPageVisited = false;
                                          sentOTPDone = false;
                                          isPressed .value = false;
                                          getotp.value = false;
                                          isShowResendBtn.value = true;
                                          Get.offAllNamed("/forgotPassword");

                                        });
                                        },
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            Text("forgotPassword".tr,style:
                                            TextStyle(fontSize: MediaQuery.of(context).size.height/60,
                                                fontFamily: "OpenSans",
                                                color: const Color(0xFF505EBC).withOpacity(1)),),
                                          ],
                                        )
                                      ),
                                      SizedBox(
                                        height:MediaQuery.of(context).size.height/40,
                                      ),
                                  GestureDetector(
                                                onTap: ()  {
                                                  if(loginUserName.text.isEmpty && loginPassword.text.isEmpty){
                                                  toastMessage(context, "emptyPasswordUserName".tr,color:Colors.red);
                                                  }
                                                  else if(loginUserName.text.isEmpty || loginUserName.text.length<10){
                                                    toastMessage(context, "invalidUserName".tr,color:Colors.red);
                                                  }
                                                  else if(
                                                  loginUserName.text.startsWith("0") ||
                                                      loginUserName.text.startsWith("1") ||
                                                      loginUserName.text.startsWith("2") ||
                                                      loginUserName.text.startsWith("3") ||
                                                      loginUserName.text.startsWith("4") ||
                                                      loginUserName.text.startsWith("5")){
                                                    toastMessage(context, "invalidUserName".tr,color:Colors.red);
                                                       }
                                                  else if(loginPassword.text.isEmpty){
                                                    toastMessage(context, "emptyPasswordSnackBar".tr,color:Colors.red);
                                                  }
                                                  else {
                                                    if(loginPressed == false){

                                                      loggedIn(context);
                                                    }

                                                    }
                                                    },


                                                child: commonButton(context,  "loginBtnText".tr)),




                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
          ),
        ),
    ),
    );
  }
}
