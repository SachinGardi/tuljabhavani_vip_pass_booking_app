import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/view/non_referral_pass/devotee_profile/image_uploading_file.dart';
import 'package:tulajapur/view/non_referral_pass/devotee_profile/profile_common_widgets.dart';

import '../../../view_modal/spl_donation_epass_vm/devotee_profile_details_vm.dart';
import '../../common_widget/progress_indicator.dart';

class DevoteeProfile extends StatefulWidget {
  const DevoteeProfile({Key? key}) : super(key: key);

  @override
  State<DevoteeProfile> createState() => _DevoteeProfileState();
}

class _DevoteeProfileState extends State<DevoteeProfile> {

  final DevoteeProfileDetailsVM profileDetailsVM =Get.put(DevoteeProfileDetailsVM());
  profileDetailsApi()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String devoteeMobNo = preferences.getString("mob")!;
    profileDetailsVM.devoteeProfileDetailsList.clear();
    profileDetailsVM.isLoading.value = true;
    await profileDetailsVM.getDevoteeProfileDetails(devoteeMobNo, context);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileDetailsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> ModalProgressHUD(
        inAsyncCall: profileDetailsVM.isLoading.value == true,
        progressIndicator: progressIndicator(),
        child: WillPopScope(
          onWillPop: ()async{
            Get.offAllNamed("/dashBoard");
            return false;
          },
          child: Scaffold(
              backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.95),
              appBar: devoteeProfileAppbar(context,"pAppBarTitleText".tr),
              body: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height /27,
                    left: MediaQuery.of(context).size.width / 14,
                    right: MediaQuery.of(context).size.width / 14),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.2,
                  width:  MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(1),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.7), blurRadius: 6)
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height /25,
                        left: MediaQuery.of(context).size.width / 14,
                        right: MediaQuery.of(context).size.width / 14),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width /3,
                          height: MediaQuery.of(context).size.height /7,
                          clipBehavior: Clip.hardEdge,
                          decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orangeAccent,
                            image: (imgLink.value == "" ||imgLink.value == null)
                                ? const DecorationImage(
                              image: AssetImage(
                                  "assets/images/MapDesign/emptyProfile.png"),
                              fit: BoxFit.contain,
                            )
                                : DecorationImage(
                              image: NetworkImage(
                                imgLink.value!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),

                        ),
                        SizedBox(height: MediaQuery.of(context).size.height /70,),
                        Center(child:Text(profileDetailsVM.devoteeName ?? "",
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height/55,
                              color: Colors.black))),
                        SizedBox(height: MediaQuery.of(context).size.height /35),
                        Center(child: devoteeProfileDetail(context, "mobileNo".tr,profileDetailsVM.mobileNumber ?? "-")),
                        Center(child: devoteeProfileDetail(context, "vipPassGender".tr,profileDetailsVM.gender ?? "-")),
                        devoteeProfileDetail(context, "dateOfBirth".tr,profileDetailsVM.dob ?? "-"),
                        devoteeProfileDetail(context, "aadhaarNumber".tr,profileDetailsVM.aadhaarNo ?? "-"),

                      ],
                    ),

                  ),
                ),
              )),
        ),
      ),
    );
  }
}
