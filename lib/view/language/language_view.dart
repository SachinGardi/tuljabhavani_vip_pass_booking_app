import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_widget/common_appBar.dart';
import '../common_widget/common_button.dart';
import 'language_string.dart';
import 'language_widget.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  State<ChooseLanguage> createState() => ChooseLanguageState();
}

class ChooseLanguageState extends State<ChooseLanguage> {

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Get.offAllNamed("/dashBoard");
        return false;
      },
      child: Scaffold(
        appBar: allNotification('changeLanguage'.tr),
        body: Column(
           crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(height: MediaQuery.of(context).size.height/40,),
             Padding(
              padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/20,
                  bottom: MediaQuery.of(context).size.height/70),
              child: Text("selectLanguage".tr,
                style:  TextStyle(
                  fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height/55,
                    color: Colors.black),),
            ),
            const RadioButtonWidget(),
             SizedBox(height: MediaQuery.of(context).size.height/30,),
            GestureDetector(
                onTap: ()async{
                  var locale = selectedLanguage == english
                        ? const Locale('en', "US")
                        : selectedLanguage == marathi
                        ? const Locale('mr', "IN")
                        : const Locale('en', "US");
                    Get.updateLocale(locale);
                    SharedPreferences pref= await SharedPreferences.getInstance();
                    pref.setString('language', selectedLanguage);
                   Get.offAllNamed("/dashBoard");

                },
                child: commonButton(context,"OK".tr)
            )
          ],
        ),
      ),
    );
  }
}
