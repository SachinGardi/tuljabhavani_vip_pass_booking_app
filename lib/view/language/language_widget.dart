import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_string.dart';

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget({Key? key}) : super(key: key);
  @override
  State<RadioButtonWidget> createState() => RadioButtonWidgetState();
}


class RadioButtonWidgetState extends State<RadioButtonWidget> {

  ///selected Language value
  void getLanguage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage =  pref.getString('language') ?? english;
    });

  }
  ///Method to handle language Change
  _handleChange(String? value) {
    setState(()  {
      selectedLanguage = value.toString();
    });
  }

  @override
  void initState() {
    setState(() {
      getLanguage();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17.0),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                _handleChange(english);
              });
            },
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              dense: true,
              visualDensity: const VisualDensity(vertical: -4.0,),
              horizontalTitleGap: 5,
              leading: Transform.scale(
                scale: 1,
                child: Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: const Color(0xFFEC6019),
                    value: english,
                    groupValue: selectedLanguage,
                    onChanged: _handleChange),
              ),
              title:  Text("english".tr,style: const TextStyle(fontSize: 15,fontFamily :"OpenSans",color: Colors.black),),
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                _handleChange(marathi);
              });
            },
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              horizontalTitleGap: 5,
              dense: true,

              leading: Radio(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: const Color(0xFFEC6019),
                  value: marathi,
                  groupValue: selectedLanguage,
                  onChanged: _handleChange),
              title:  const Text("मराठी",style: TextStyle(fontSize: 15,fontFamily :"OpenSans",color: Colors.black),),
            ),
          ),

        ],
      ),
    );
  }
}



