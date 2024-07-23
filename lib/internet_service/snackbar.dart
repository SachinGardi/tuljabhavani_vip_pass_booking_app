import 'package:flutter/material.dart';
import 'package:get/get.dart';

internetToastMessage(){
  Get.snackbar('Network Error', 'Please Check Internet Connection',
      duration: Duration(seconds: 1),
      backgroundColor: Colors.white.withOpacity(0.1),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(bottom:30,left: 30,right: 30)
  );
}