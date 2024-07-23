import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import '../../internet_service/CheckInternetCon.dart';
import '../../modal/devotee/post_otp_modal.dart';
import '../../view_modal/devotee_vm/postotp_login.dart';
import 'forgot_password_string.dart';

var isPressed = false.obs;
var getotp = false.obs;
var resendOtpbtn = false;
bool sentOTPDone = false;
var passwordVisibility = true.obs;
var newPasswordVisibility = true.obs;
var otpVarifiedSuccessfully = false.obs;

const String checkAll = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
const String checkSpecial = r'^(?=.*?[!@#\$&*~])';
const String checkCapitalLetters = r'^(?=.*?[A-Z])';
const String checkSmallLetters = r'^(?=.*?[a-z])';
const String checkNumbers = r'^(?=.*?[0-9])';
class NumberWidget extends StatefulWidget {
  const NumberWidget({Key? key}) : super(key: key);

  @override
  State<NumberWidget> createState() => NumberWidgetState();
}

class NumberWidgetState extends State<NumberWidget> {
   myCallback() async {
     await addOTPVM.forgotPassOTP(DevoteePostOTPModal(), context);
   }

  @override
  Widget build(BuildContext context) {
    return Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
            height:  MediaQuery.of(context).size.height/20,
            child: TextFormField(
              controller: otpNumber,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value){

              },
              keyboardType: TextInputType.phone,

              cursorColor: Colors.black26,
              cursorWidth: 1,
              expands: false,
              style:  TextStyle(
                fontSize: MediaQuery.of(context).size.height/50,
                fontFamily: "OpenSans",
                color: const Color(0xFF868686),
              ),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF2F2F2),
                  hintText: "fMobileNOHint".tr,
                  hintStyle:  TextStyle(
                    fontSize: MediaQuery.of(context).size.height/60,
                    fontFamily: "OpenSans",
                    color:const Color(0xFF868686),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  )),
            ),
          ),
        ),
         Expanded(
              flex: 3,
              child: MaterialButton(
                onPressed: () async {
                  setState(() {
                    if(otpNumber.text.isEmpty){
                      toastMessage(context, "dEmptyMobileSnackBar".tr,color: Colors.redAccent);
                    }
                    else if(otpNumber.text.length<10){
                      toastMessage(context, "numberValidator".tr,color: Colors.redAccent);
                    }
                    else{
                      (sentOTPDone == false)? myCallback() : null;
                    }

                  });
                },
                child: Center(
                    child: Container(
                  height:  MediaQuery.of(context).size.height/21.70,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color(0xFFFEB349),
                        Color(0xFFE74E0E)
                      ]),
                      borderRadius: BorderRadius.circular(6)),
                  child:  Center(
                      child: Text(
                    "fSendOtpBtnText".tr,
                    style: const TextStyle(fontSize: 12, color: Color(0xFFFFFFFF)),
                  )),
                )),
              ))

      ],
    );
  }
}


AddOTPVM addOTPVM = Get.put(AddOTPVM());
final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());

Widget enterOTP(BuildContext context) => Padding(
  padding: const EdgeInsets.only(right: 8.0),
  child:   SizedBox(
      height: MediaQuery.of(context).size.height/20,
        child: TextFormField(
          controller: verifyOTP,
          inputFormatters: [
            LengthLimitingTextInputFormatter(5),
            FilteringTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.phone,
          cursorHeight: 25,
          cursorColor: Colors.black26,
          cursorWidth: 1,
          expands: false,
          style:  TextStyle(
            fontSize: MediaQuery.of(context).size.height/50,
            fontFamily: "OpenSans",
            color: const Color(0xFF868686),
          ),
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF2F2F2),
              hintText: "fOtpHint".tr,
              hintStyle:  TextStyle(
                fontSize: MediaQuery.of(context).size.height/60,
                fontFamily: "OpenSans",
                color:const Color(0xFF868686),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              )),)
      ),
);
var validPassword = false.obs;

Widget newPassword(BuildContext context) => Obx(()=>
   TextFormField(
     inputFormatters: [
       LengthLimitingTextInputFormatter(42),
       FilteringTextInputFormatter.deny(
           RegExp(r'\s')),
     ],

        controller: forgotNewPass,
        cursorColor: Colors.black45,
        cursorWidth: 1,
     obscureText: passwordVisibility.value,


     onChanged: (String value) {
       if (RegExp(checkAll).hasMatch(value)) {

       }
       else{
         validPassword.value = false;
       }
       },

     onTapOutside:   (value) async {

       FocusScope.of(context).unfocus();

     },

     autovalidateMode: AutovalidateMode.always,
     validator: (value) {
       if(forgotNewPass.text.isEmpty){
         return '';
       }
       else if ( value!.trim().length < 8) {

         return 'passLength'.tr;
       }

      else if (!RegExp(checkSmallLetters).hasMatch(value)) {

         return 'passLowerCase'.tr;
       }
       else if (!RegExp(checkCapitalLetters).hasMatch(value)) {

         return 'passUpperCase'.tr;
       }


       else if (!RegExp(checkNumbers).hasMatch(value)) {

         return 'passNumber'.tr;
       }

       else if (!RegExp(checkSpecial).hasMatch(value)) {

         return 'passSpecial'.tr;
       }

     },

     style:  TextStyle(
       fontSize: MediaQuery.of(context).size.height/50,
       fontFamily: "OpenSans",
       color: const Color(0xFF868686),
     ),

        decoration: InputDecoration(
          errorMaxLines: 2,
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10),),
              borderSide: BorderSide(
                width: 1,
                color:Colors.black12,
              )
          ),
          focusedErrorBorder:  const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
          isDense: true,



          contentPadding:
            EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/70, horizontal: 10),
          isCollapsed: true,

          hintText: "nNewPasswordHint".tr,

          hintStyle:  TextStyle(
            fontSize: MediaQuery.of(context).size.height/57,
            fontFamily: "OpenSans",
            color:const Color(0xFF868686),
          ),
          // Image(image: AssetImage('images/mail.svg')),
          filled: true,
          errorStyle:  TextStyle(
            fontSize: MediaQuery.of(context).size.height/80,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            color:Colors.red,
          ),
          fillColor: const Color(0xFFF2F2F2),
          suffixIcon:
              IconButton(onPressed: (){

                passwordVisibility.value  =! passwordVisibility.value;

              }, icon: passwordVisibility.value
                  ? const Icon(Icons.visibility_off,color: Colors.black45)
                  : const Icon(Icons.visibility,color: Colors.black45)),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(7),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
);

Widget confirmPassword(BuildContext context) => Obx(()=>(
  TextFormField(
    inputFormatters: [
      LengthLimitingTextInputFormatter(42),
      FilteringTextInputFormatter.deny(
          RegExp(r'\s')),
    ],
      controller: forgotReEnterPass,
    obscureText: newPasswordVisibility.value,

    cursorColor: Colors.black45,
   cursorWidth: 1,
    onTapOutside:   (value) async {

      FocusScope.of(context).unfocus();
    },

    autovalidateMode: AutovalidateMode.always,
    validator: (value) {
      if(forgotReEnterPass.text.isEmpty){
        return '';
      }
      else if ( value!.trim().length < 8) {

        return 'passLength'.tr;
      }

     else if (!RegExp(checkSmallLetters).hasMatch(value)) {

        return 'passLowerCase'.tr;
      }
    else  if (!RegExp(checkCapitalLetters).hasMatch(value)) {

        return 'passUpperCase'.tr;
      }


      else if (!RegExp(checkNumbers).hasMatch(value)) {

        return 'passNumber'.tr;
      }

      else   if (!RegExp(checkSpecial).hasMatch(value)) {

        return 'passSpecial'.tr;
      }

      return null; // to indicate a success
    },


    style:  TextStyle(
      fontSize: MediaQuery.of(context).size.height/50,
      fontFamily: "OpenSans",
      color: const Color(0xFF868686),
    ),


        decoration: InputDecoration(
          errorMaxLines: 2,
          errorStyle:  TextStyle(
            fontSize: MediaQuery.of(context).size.height/80,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            color:Colors.red,
          ),

          isDense: true,

          contentPadding:

          EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/70, horizontal: 10),

          isCollapsed: true,
          suffixIcon:
          IconButton(onPressed: (){

            newPasswordVisibility.value  =! newPasswordVisibility.value;

          }, icon: newPasswordVisibility.value
              ? const Icon(Icons.visibility_off,color: Colors.black45)
              : const Icon(Icons.visibility,color: Colors.black45)),

          hintText: 'confirmNewPasswordHint'.tr,


          hintStyle:  TextStyle(
            fontSize: MediaQuery.of(context).size.height/57,
            fontFamily: "OpenSans",
            color:const Color(0xFF868686),
          ),

          // Image(image: AssetImage('images/mail.svg')),

          filled: true,

          fillColor: const Color(0xFFF2F2F2),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10),),
              borderSide: BorderSide(
                width: 1,
                color:Colors.black12,
              )
          ),
          focusedErrorBorder:  const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
          enabledBorder: OutlineInputBorder(

            borderSide: BorderSide.none,

            borderRadius: BorderRadius.circular(10),

          ),

          focusedBorder: OutlineInputBorder(

            borderSide: BorderSide.none,

            borderRadius: BorderRadius.circular(10),

          ),

        ),

      ))
);
