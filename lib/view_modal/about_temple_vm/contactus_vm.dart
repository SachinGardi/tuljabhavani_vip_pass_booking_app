import 'dart:async';

import 'package:get/get.dart';
import 'package:tulajapur/view/contact_us/contact_us_view.dart';

import '../../modal/about_temple_modal/about_temple_modal.dart';
import '../../modal/about_temple_modal/contact_us.dart';
import '../../repository/about_temple_repo/about_temple_repo.dart';
import '../../repository/about_temple_repo/contact_us_repo.dart';




String? templeAddress;
String? email1;
String? email2;
String? visitTime;
String? contactPerson;
String? cDesignation;
String? contact1;
String? contact2;
String? TemplemoreInfo;
class ContactUsVM extends GetxController{
  List<ContactUsModal> templeContactDetails=[];
  var isLoading = true.obs;


  getTempleContactInfo() async {
    var templeInformation = await TempleContactUs.getContactDetails();
    print("--$templeInformation");
    if(templeInformation != null){
      templeContactDetails = templeInformation;
      isLoading.value = false;
    }
    else if(templeInformation == null){
      Timer(Duration(seconds: 2),(){
        isLoading.value = false;
      });
    }
    templeContactDetails.forEach((element) {
      templeAddress = element.address;
      email1 = element.emailId1;
      email2 = element.emailId2;
      visitTime = element.workingHours;
      contactPerson = element.contactPerson;
      cDesignation = element.contactPersonDesignation;
      contact1 = element.contactNo1;
      contact2= element.contactNo2;
      TemplemoreInfo= element.information;
    });
  }
}