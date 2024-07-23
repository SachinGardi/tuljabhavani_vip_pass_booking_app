import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_notification_service/firebase_noti_service.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
var type;
void getValue() async {

  SharedPreferences preferences = await SharedPreferences.getInstance();
    type = preferences.getString('login');

  if(type == "1" || type == "5"){
    Timer(const Duration(seconds:1),() async {
      Get.offAllNamed('/mapDesign');
    });

  }
  else if(type == "2"){
    Future.delayed(const Duration(seconds:1),(){

      Get.offAllNamed('/scanPass');
    });

  }
  else{
    Timer(const Duration(seconds:1),() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isMute');
      await prefs.setBool('hasShownPopUp', false);
      Get.offAllNamed('/dashBoard');
    });

  }

}
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  final String imagePath = 'assets/images/STPL_Logo.png';
  @override
  void initState() {
    super.initState();
    isAnimation();
    flutterLocalNotificationsPlugin.cancelAll();
  }
  bool isAnimationFalse = false;
  Future isAnimation()async{
    await Future.delayed(Duration(milliseconds: 300),(){
      setState(() {
        isAnimationFalse = true;
      });
    });
    await Future.delayed(Duration(milliseconds: 800),(){
      setState(() {
        getValue();
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
      decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFEC6019), Color(0xFFFEB148),Color(0xFFFEB148),Color(0xFFFEB148).withOpacity(0.4),Color(0xFFFEB148).withOpacity(0.2),Color(0xFFFEB148).withOpacity(0.1)])),

          ),
          AnimatedPositioned(
            top:  isAnimationFalse ?MediaQuery.of(context).size.height/3.5 :-(MediaQuery.of(context).size.height/3.5),
            left: MediaQuery.of(context).size.width/7,
            duration: const Duration(milliseconds:500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/deviimages.png",
                    height: MediaQuery.of(context).size.height/3.8,width:MediaQuery.of(context).size.width/1.6,
                fit: BoxFit.fill,),

                SizedBox(height: MediaQuery.of(context).size.height/40 ),
                Center(
                  child: Text("||श्री तुळजाभवानी प्रसन्न||", style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height/32,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold,
                      color: Colors.white),),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/90 ),
                Center(
                  child: Text('श्री तुळजाभवानी मंदिर संस्थान, तुळजापूर', style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height/60,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold,
                      color: Colors.white),),
                )
              ],
            ),
          ),


      Column(
        children: [
        Spacer(),
          Center(
            child: Text("Version : 1.0.3",style: TextStyle(
              fontSize: MediaQuery.of(context).size.height/80,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
              color:Colors.deepOrangeAccent,
            ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text(
                  "Powered By : ",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height/80,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    color:Colors.black,
                  )),
              SizedBox(height: MediaQuery.of(context).size.height/20,),
              Image.asset(imagePath,
                height: MediaQuery.of(context).size.height/25,
                fit: BoxFit.fill,),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height/80,)
        ],
      )
       





        ],
      ),
    );
  }
}


