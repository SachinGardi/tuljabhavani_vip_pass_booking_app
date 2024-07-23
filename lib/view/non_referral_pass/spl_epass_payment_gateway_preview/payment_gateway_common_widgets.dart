import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

PreferredSizeWidget paymentGatewayAppBar(String title,BuildContext context)=>
    AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
          systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2),
        ),
        elevation: 0,
        leading:IconButton(
          onPressed: (){
            showPaymenytDialog(context);
          },
          icon: SvgPicture.asset("assets/images/Back Arrow.svg",color: Colors.white,height: 35,),
        ),
        title: Row(
          children: [
            Text(title,style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: "OpenSans",
                color: Color(0xFFFFFFFF))),
          ],
        ),

        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFEC6019), Color(0xFFFEB148),Color(0xFFFEB148)])),
        ));





Future<void> showPaymenytDialog(BuildContext context) async {
  await  showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent.withOpacity(0.5),

      context: context,

      builder: (_) =>

          AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding:  EdgeInsets.zero,
            content: SizedBox(
              height: MediaQuery.of(context).size.height/4.3,
              width: MediaQuery.of(context).size.width/1.15 ,
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width/20,
                            vertical: MediaQuery.of(context).size.height /80
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('cancelPaymentTitle'.tr,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height /45,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "OpenSans",
                                  color: Colors.black),),
                            const Spacer(),
                            GestureDetector(
                                onTap: (){
                                  Get.back();
                                },
                                child: const Icon(Icons.cancel_outlined,color: Colors.redAccent,))
                          ],
                        ),
                      ),

                      const Divider(
                        height: 2,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width/20,
                        vertical: MediaQuery.of(context).size.height /50
                    ),
                    child: Text('cancelPaymentMsg'.tr),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height /40,),
                  Padding(
                    padding:EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width/20,

                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height /28,
                                  width: MediaQuery.of(context).size.width /5.5,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Adjust shadow color and opacity
                                          spreadRadius: 2, // Adjust the spread radius
                                          blurRadius: 5, // Adjust the blur radius
                                          offset: const Offset(0, 3), // Adjust the offset
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Center(
                                      child: Text(
                                        "No".tr,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height /65,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            color: Colors.black),
                                      )),
                                ))
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width /30,),
                        GestureDetector(
                            onTap: () async {
                              Get.offAllNamed("/splDonationEPassPaymentDetails");
                            },
                            child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height /28,
                                  width: MediaQuery.of(context).size.width /5.5,
                                  decoration:  BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          // Adjust shadow color and opacity
                                          spreadRadius: 2,
                                          // Adjust the spread radius
                                          blurRadius: 5,
                                          // Adjust the blur radius
                                          offset: const Offset(0, 3), // Adjust the offset
                                        ),
                                      ],
                                      gradient:  const LinearGradient(
                                          colors: [Color(0xFFFEB349),Color(0xFFFEB349), Color(0xFFE74E0E)],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight),
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Center(
                                      child: Text(
                                        "Yes".tr,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height /65,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "OpenSans",
                                            color: Colors.white),
                                      )),
                                ))
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

          ));









}




Future<void> showTimeOutDialog(BuildContext context) async {
  await  showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent.withOpacity(0.5),

      context: context,

      builder: (_) =>

          AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding:  EdgeInsets.zero,
            content: SizedBox(
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width/1.15 ,


              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height /40,),
                  Icon(Icons.info_outlined,color: Colors.orange,
                    size: MediaQuery.of(context).size.height/30,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height /60,),
                  Text('timeOut'.tr,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height /45,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans",
                        color: Colors.black),),
                  SizedBox(height: MediaQuery.of(context).size.height /40,),
                  GestureDetector(
                    onTap: (){
                      Get.offAllNamed("/splDonationEPassPaymentDetails");
                    },
                    child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height /28,
                          width: MediaQuery.of(context).size.width /3,
                          decoration:  BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  // Adjust shadow color and opacity
                                  spreadRadius: 2,
                                  // Adjust the spread radius
                                  blurRadius: 5,
                                  // Adjust the blur radius
                                  offset: const Offset(0, 3), // Adjust the offset
                                ),
                              ],
                              gradient:  const LinearGradient(
                                  colors: [Color(0xFFFEB349),Color(0xFFFEB349), Color(0xFFE74E0E)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                                'tryagain'.tr,
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height /65,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    color: Colors.white),
                              )),
                        )),
                  )

                ],
              ),
            ),

          ));









}




Widget devoteeInformation(BuildContext context, String key, String value,
    {Color valueColor = Colors.redAccent}) =>
    Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height/65),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex:5,
                      child: Text(
                        key,
                        style:
                        TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: MediaQuery.of(context).size.width/28,
                            color: Colors.black),
                      ),
                    ),

                    const Spacer(),
                    Expanded(
                      child: Text(
                        ':  ',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: MediaQuery.of(context).size.width/28,
                            color: Colors.black),
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w800,
                      fontSize: MediaQuery.of(context).size.width/28,
                      color: Colors.black),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );