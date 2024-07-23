import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../baseUrl/base_url.dart';
import '../../internet_service/CheckInternetCon.dart';
import '../../internet_service/snackbar.dart';
import '../../modal/validator/validator_scannar_modal.dart';
import '../../view/common_widget/snack_bar.dart';
import '../../view/validator_module/scan_pass/scanner_view.dart';
final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
class GetScannarDetailsRepo {
  static var queryParameters;
  static Map temp ={};
  static List<ValidatorScannarModal> scannerDetails= [];
  static validate(String devoteeId, BuildContext context) async {
    queryParameters = {
      "DevoteeId": devoteeId,
    };

    Uri uri = Uri.http(uatBaseUrl,
        '/api/TuljapurEpassWebApi/ePassBooking/GetScanningDetailsById',
        GetScannarDetailsRepo.queryParameters);


    try {
      var time1 = DateTime.now().millisecondsSinceEpoch;
      http.Response response = (await http.get(uri));
      print("*****************");
      print(DateTime.now().millisecondsSinceEpoch - time1);
      print(response.statusCode);
      if (response.statusCode == 200) {
        temp = json.decode(utf8.decode(response.bodyBytes));
        print(temp);

        if(temp["statusMessage"] == "e-Pass details are not available." ){
          isScanned.value = false;
          if(context.mounted){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "invalidPass".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height /50,
                        fontFamily: "OpenSans",
                        color: Colors.black),
                  ),
                  titlePadding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 30,
                      right: MediaQuery.of(context).size.width / 30,
                      top: MediaQuery.of(context).size.height / 70),
                  contentPadding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 30,
                    right: MediaQuery.of(context).size.width / 30,
                  ),
                  actionsPadding: EdgeInsets.zero,

                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: Text(
                        'ok'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height / 60,
                            fontFamily: "OpenSans",
                            color: Colors.orange),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        }
        else if(temp["statusMessage"] == "e-Pass details fetched successfully."){

             temp['responseData'].forEach((v){
              if((v["statusId"]) == 5 || (v["statusId"]) == 6 ){
                if(DateFormat("yyyy-MM-dd").format(DateTime.parse(v["visitDate"].toString())) != date){
                  print(v["visitDate"]);
                  print(date);

                  if(context.mounted){
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Invalid Visit Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height /50,
                                fontFamily: "OpenSans",
                                color: Colors.black),
                          ),
                          titlePadding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 30,
                              right: MediaQuery.of(context).size.width / 30,
                              top: MediaQuery.of(context).size.height / 70),
                          contentPadding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 30,
                            right: MediaQuery.of(context).size.width / 30,
                          ),
                          actionsPadding: EdgeInsets.zero,
                          content: SizedBox(
                            width: double.maxFinite,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                const Divider(
                                  color: Colors.grey,
                                ),
                                Text("Visit on  ${DateFormat("dd-MM-yyyy").format(DateTime.parse(v["visitDate"].toString()))}"  ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                Get.back();
                              },
                              child: Text(
                                'ok'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.height / 60,
                                    fontFamily: "OpenSans",
                                    color: Colors.orange),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }


                }
                else{
                  isScanned.value = false;
                 Get.toNamed('vipPassDetail');
                }
               }


              else if((v["statusId"]) == 7){

                 isScanned.value = false;
                 Get.toNamed('vipPassDetail',arguments:"Visited");

               }
              else if((v["statusId"]) == 8 ){

                isScanned.value = false;
                Get.toNamed('vipPassDetail',arguments:"Expired");

              }

             });


        }
        temp['responseData'].forEach((v){
          scannerDetails.add(ValidatorScannarModal(
            id: v["id"],
            devoteeId: v["devoteeId"],
            devoteeName: v["devoteeName"],
            mobileNo: v["mobileNo"],
            gender: v["gender"],
            dateOfBirth: v["dateOfBirth"] == null ? null : DateTime.parse(v["dateOfBirth"]),
            age: v["age"],
            address: v["address"],
            aadharNo: v["aadharNo"],
            referById: v["referById"],
            referBy: v["referBy"],
            visitDate: v["visitDate"] == null ? null : DateTime.parse(v["visitDate"]),
            visitTime: v["visitTime"],
            donation: v["donation"],
              imagePath: v["imagePath"],
            barcodeText: v["barcodeText"],
            ePassName: v["ePassName"],
            statusId: v["statusId"],
            transactionId: v["transactionId"],
            transactionDate: v["transactionDate"] == null ? null : DateTime.parse(v["transactionDate"]),
            scanDate: v["scanDate"] == null ? null : DateTime.parse(v["scanDate"]),
            validatorName: v["validatorName"],
            bookingId: v["bookingId"],
            bookingDate: v["bookingDate"] == null ? null:DateTime.parse(v["bookingDate"]),

          ));
        });
          return scannerDetails;
        }
    } catch (e) {
     print(e);
    }
  }
}
