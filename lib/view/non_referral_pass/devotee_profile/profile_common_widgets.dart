import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'devotee_profile.dart';


///AppBar for profile
PreferredSizeWidget devoteeProfileAppbar(BuildContext context,String title)=>
    AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
          systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2),
        ),
        elevation: 0,
        leading:IconButton(
          onPressed: (){
            Get.offAllNamed("/dashBoard");
          },
          icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 35,),
        ),
        title: Text(title,style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: "OpenSans",
            color: Color(0xFFFFFFFF))),
        actions: [

          Padding(
            padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/30),
            child: IconButton(
              onPressed: (){
                Get.toNamed("/devoteeUpdateProfile",arguments:"Profile");
              },
              icon: SvgPicture.asset("assets/images/MapDesign/Edit.svg",color: Colors.white,height: 35,),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFEC6019), Color(0xFFFEB148),Color(0xFFFEB148)])),
        ));






///Devotee Details like gender,dob,Aadhaar
Widget devoteeProfileDetail(BuildContext context, String key, String value, {Color valueColor = Colors.redAccent}) =>
    Padding(
      padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height/26,
            width: MediaQuery.of(context).size.width/2.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      key,
                      style:
                      TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: MediaQuery.of(context).size.height/60,
                          color: Colors.black),
                    ),
                    const Spacer(),
                    Text(
                      '  :  ',
                      style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: MediaQuery.of(context).size.height/50,
                          color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: MediaQuery.of(context).size.height/60,
                      color: Colors.black),
                  // maxLines: 2,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );



PreferredSizeWidget updateProfileAppbar(BuildContext context,String title)=>
    AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
          systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2),
        ),
        elevation: 0,
        leading:IconButton(
          onPressed: (){
            Get.offAllNamed("/devoteeProfile");
            },
          icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 35,),
        ),
        title: Text(title,style: const TextStyle(
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
        ));

///Update profile labels

Widget updateProfileLabels(BuildContext context,String labelName) => RichText(
  text:TextSpan(
      text: labelName,
      style:  TextStyle(
          color: const Color(0xFF3B3B3B),
          fontFamily: "NotoSans",
          fontSize: MediaQuery.of(context).size.height/60,
          fontWeight: FontWeight.bold),
      children: [
        TextSpan(
            text: " *",
            style:  TextStyle(
              color:  Colors.redAccent,
              fontSize: MediaQuery.of(context).size.height/60,
            )
        )
      ]
  ) ,

);