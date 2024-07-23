import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


PreferredSizeWidget registrationAppBar(String title)=>
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFEC6019), Color(0xFFFEB148),Color(0xFFFEB148)])),
        ));