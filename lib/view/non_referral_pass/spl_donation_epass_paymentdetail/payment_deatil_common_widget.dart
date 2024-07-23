import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


String paymentMethod = "sbiChoose";
String groupPaymentMethod = "";

PreferredSizeWidget paymentDetailAppBar(String title) => AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: const Color(0xFFEC6019).withOpacity(0.1),
      systemNavigationBarDividerColor: const Color(0xFFEC6019).withOpacity(0.2),
    ),
    elevation: 0,
    leading: IconButton(
      onPressed: () {
        Get.offAllNamed("/splePassDetailsView");
      },
      icon: SvgPicture.asset(
        "assets/images/Back Arrow.svg",
        color: Colors.white,
        height: 35,
      ),
    ),
    title: Text(title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: "OpenSans",
            color: Color(0xFFFFFFFF))),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
            Color(0xFFEC6019),
            Color(0xFFFEB148),
            Color(0xFFFEB148)
          ])),
    ));

Widget devoteePaymentDetail(BuildContext context, String key, String value,
        {Color valueColor = Colors.redAccent}) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 24.5,
          width: MediaQuery.of(context).size.width / 2.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    key,
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.height / 55,
                        color: Colors.black),
                  ),
                  const Spacer(),
                  Text(
                    '  :   ',
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: MediaQuery.of(context).size.height / 50,
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
                    fontWeight: FontWeight.w700,
                    fontSize: MediaQuery.of(context).size.height / 58,
                    color: Colors.black),
                // maxLines: 2,
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    );

Widget tableLabel(BuildContext context, String name) => Center(
      child: Text(
        name,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 65,
            fontWeight: FontWeight.w600,
            fontFamily: "OpenSans",
            color: Colors.black),
      ),
    );

Widget tableLabel2(BuildContext context, String name) => Center(
      child: Text(
        name,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 55,
            fontWeight: FontWeight.w600,
            fontFamily: "OpenSans",
            color: Colors.black),
      ),
    );


Future<void> capacityFullDialogue(BuildContext context) async {
  await  showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent.withOpacity(0.5),
      context: context,

      builder: (_) =>
          AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding:  EdgeInsets.zero,
            content: SizedBox(
              height: MediaQuery.of(context).size.height/3.8,
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
                            const Spacer(),
                            GestureDetector(
                                onTap: (){
                                  Get.back();
                                },
                                child: const Icon(Icons.cancel_outlined,color: Colors.redAccent,))
                          ],
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width/20,
                    ),
                    child: Text('fullCapacity'.tr

                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height /40,),
                  Center(
                    child: GestureDetector(
                        onTap: () async {
                          Get.offAllNamed("/splePassDetailsView");
                        },
                        child: Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height /26,
                              width: MediaQuery.of(context).size.width /5,
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
                                    "Yes".tr,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height /65,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        color: Colors.white),
                                  )),
                            ))
                    ),
                  ),
                ],
              ),
            ),

          ));
}
Future<void> blockDayDialogue(BuildContext context) async {
  await  showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent.withOpacity(0.5),
      context: context,

      builder: (_) =>
          AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding:  EdgeInsets.zero,
            content: SizedBox(
              height: MediaQuery.of(context).size.height/3.8,
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
                            const Spacer(),
                            GestureDetector(
                                onTap: (){
                                  Get.back();
                                },
                                child: const Icon(Icons.cancel_outlined,color: Colors.redAccent,))
                          ],
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width/20,
                    ),
                    child: Text("blockDay".tr,

                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height /40,),
                  Center(
                    child: GestureDetector(
                        onTap: () async {
                          Get.offAllNamed("/splePassDetailsView");
                        },
                        child: Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height /26,
                              width: MediaQuery.of(context).size.width /5,
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
                                    "Yes".tr,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height /65,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        color: Colors.white),
                                  )),
                            ))
                    ),
                  ),
                ],
              ),
            ),

          ));









}