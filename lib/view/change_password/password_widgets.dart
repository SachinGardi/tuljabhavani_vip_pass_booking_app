import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tulajapur/view/change_password/password_design.dart';
import 'package:tulajapur/view/forgot_password/forgot_password_widget.dart';

String? validation(String? value, TextEditingController controller){
  if(controller.text.isEmpty){
    return '';
  }
  else if(value!.trim().length < 8){
    return 'passLength'.tr;
  }
  else if(!RegExp(checkSmallLetters).hasMatch(value)){
    return 'passLowerCase'.tr;
  }
  else if(!RegExp(checkCapitalLetters).hasMatch(value)){
    return 'passUpperCase'.tr;
  }
  else if (!RegExp(checkNumbers).hasMatch(value)) {
    return 'passNumber'.tr;
  }
  else if (!RegExp(checkSpecial).hasMatch(value)) {
    return 'passSpecial'.tr;
  }
}

Widget currentPassword(BuildContext context, Function toggle,bool obscureText) => Padding(
  padding:  EdgeInsets.only(
      top: MediaQuery.of(context).size.width/13,
      left: MediaQuery.of(context).size.width/50,
      right: MediaQuery.of(context).size.width/50
  ),
  child: SizedBox(
    height: MediaQuery.of(context).size.height/11,
    child: TextFormField(
      controller: currentPasswordController,
      cursorColor: const Color(0xFFFEB148),
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp('(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
        LengthLimitingTextInputFormatter(42),
        FilteringTextInputFormatter.deny(
            RegExp(r'\s')),
      ],
      decoration: InputDecoration(

        suffixIcon: GestureDetector(
            onTap:()=> toggle(),

            child: obscureText?const Icon(Icons.visibility_off,color:Color(0xFFEC6019),):const Icon(Icons.visibility,color:Color(0xFFEC6019))
        ),
        counterText: "",
        isDense: true,
        // contentPadding:EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/60, horizontal: 10),
        // isCollapsed: true,
        hintText: 'currentPasswordHint'.tr,
        hintStyle:  TextStyle(
          fontSize: MediaQuery.of(context).size.width/28,
          fontFamily: 'OpenSans',
        ),
        // Image(image: AssetImage('images/mail.svg')),
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        errorStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.height/80,
          fontFamily: "OpenSans",
          fontWeight: FontWeight.bold,
          color:Colors.red,
        ),
        errorMaxLines: 2,
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color:Colors.black12,
            ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(7),
        ),
      ),

      obscureText: obscureText,
      onChanged: (String value){
        if(RegExp(checkAll).hasMatch(value)){

        }
        else{
          validPassword.value = false;
        }
      },
      onTapOutside: (value)async{
        FocusScope.of(context).unfocus();
      },
      autovalidateMode:  AutovalidateMode.always,
      validator: (value) => validation(value,currentPasswordController),

    ),
  ),
);

Widget newPassword(BuildContext context,Function toggle,bool obscureText) => Padding(
  padding:  EdgeInsets.only(
      top: 5,
      left: MediaQuery.of(context).size.width/50,
      right: MediaQuery.of(context).size.width/50
  ),
  child: SizedBox(
      height: MediaQuery.of(context).size.height/11,
    child: TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp('(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
        LengthLimitingTextInputFormatter(42),
        FilteringTextInputFormatter.deny(
            RegExp(r'\s')),
      ],
      controller: newPasswordController,
      cursorColor: const Color(0xFFFEB148),
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
            onTap:()=>toggle(),
            child: obscureText?const Icon(Icons.visibility_off,color:Color(0xFFEC6019),):const Icon(Icons.visibility,color:Color(0xFFEC6019))
        ),
        counterText: "",
        isDense: true,
        // contentPadding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/60, horizontal: 10),
        // isCollapsed: true,
        hintText: 'newPasswordHint'.tr,
        hintStyle:  TextStyle(
            fontSize: MediaQuery.of(context).size.width/28,
          fontFamily: 'OpenSans'
        ),
        // Image(image: AssetImage('images/mail.svg')),
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        errorStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.height/80,
          fontFamily: "OpenSans",
          fontWeight: FontWeight.bold,
          color:Colors.red,
        ),
        errorMaxLines: 2,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color:Colors.black12,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      obscureText: obscureText,
      onTapOutside:   (value) async {
        FocusScope.of(context).unfocus();
      },
      autovalidateMode: AutovalidateMode.always,
      validator: (value)=>validation(value,newPasswordController),

    ),
  ),
);

Widget confirmPassword(BuildContext context,Function toggle,bool obscureText ) => Padding(
  padding:  EdgeInsets.only(
      top: 5,
      left: MediaQuery.of(context).size.width/50,
      right: MediaQuery.of(context).size.width/50
  ),
  child: SizedBox(
    height: MediaQuery.of(context).size.height/11,
    child: TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp('(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
        LengthLimitingTextInputFormatter(42),
        FilteringTextInputFormatter.deny(
            RegExp(r'\s')),
      ],
      controller: confirmPasswordController,
      cursorColor: const Color(0xFFFEB148),
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
            onTap:()=>toggle(),
            child: obscureText?const Icon(Icons.visibility_off,color:Color(0xFFEC6019),):const Icon(Icons.visibility,color:Color(0xFFEC6019))
        ),
        counterText: "",
        isDense: true,
        // contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/60, horizontal: 10),
        // isCollapsed: true,
        errorMaxLines: 2,
        errorStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.height/80,
          fontFamily: "OpenSans",
          fontWeight: FontWeight.bold,
          color:Colors.red,
        ),
        hintText: 'confirmNewPasswordHint'.tr,
        hintStyle:TextStyle(
            fontSize: MediaQuery.of(context).size.width/28,
            fontFamily: 'OpenSans'
        ),
        // Image(image: AssetImage('images/mail.svg')),
        filled: true,
        fillColor: const Color(0xFFF2F2F2),

        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color:Colors.black12,
            ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(10),
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
      obscureText: obscureText,
      onTapOutside: (value)async{
        FocusScope.of(context).unfocus();
      },
      autovalidateMode: AutovalidateMode.always,
      validator: (value)=>validation(value,confirmPasswordController),
    ),
  ),
);