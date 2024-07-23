import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/view/non_referral_pass/devotee_profile/profile_common_widgets.dart';

import '../../../firebase_notification_service/firebase_noti_service.dart';
import '../../../view_modal/spl_donation_epass_vm/devotee_profile_details_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/devotee_registration_vm.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/progress_indicator.dart';
import '../../common_widget/snack_bar.dart';
import 'camera_design.dart';
import 'image_uploading_file.dart';

class DevoteeUpdateProfile extends StatefulWidget {
  const DevoteeUpdateProfile({Key? key}) : super(key: key);

  @override
  State<DevoteeUpdateProfile> createState() => _DevoteeUpdateProfileState();
}

///TextField Controller
TextEditingController? updateMobController ;
TextEditingController? updateNameController ;
TextEditingController? dateOfBirthPicController;
TextEditingController? aadhaarNumberController;

/// radio button string
String male = 'Male';
String female = 'Female';
String? gender;





class _DevoteeUpdateProfileState extends State<DevoteeUpdateProfile> {
  final DevoteeProfileDetailsVM devoteeProfileDetailsVM =Get.put(DevoteeProfileDetailsVM());
  final DevoteeRegistrationVM updateRegistrationVM = Get.put(DevoteeRegistrationVM());

  profileDetailsApi()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String devoteeMobNo = preferences.getString("mob")!;
    devoteeProfileDetailsVM.devoteeProfileDetailsList.clear();
    devoteeProfileDetailsVM.isLoading.value = true;

    await devoteeProfileDetailsVM.getDevoteeProfileDetails(devoteeMobNo, context);
    updateMobController  = TextEditingController(text: devoteeProfileDetailsVM.mobileNumber ?? "");
    updateNameController    = TextEditingController(text: devoteeProfileDetailsVM.devoteeName ?? "");
    dateOfBirthPicController = TextEditingController(text: devoteeProfileDetailsVM.dob ?? "");
    aadhaarNumberController = TextEditingController(text: devoteeProfileDetailsVM.aadhaarNo ?? "");
    gender = devoteeProfileDetailsVM.gender;
  }
  updateDevoteeRegistartionData()async{
     if(imgLink.value == ""){
       toastMessage(
           context, 'updateProfileImage'.tr);
    }
    else if(updateNameController!.text.isEmpty){
      toastMessage(
          context, 'enterDevoteeName'.tr);
    }
    else if(aadhaarNumberController!.text.isEmpty){
      toastMessage(
          context, 'pleaseEnterAadhaar'.tr);
    }
    else if(aadhaarNumberController!.text.startsWith("1") || aadhaarNumberController!.text.startsWith("0") ||
         aadhaarNumberController!.text.length<12 ){
       toastMessage(
           context, 'pleaseEnterValidAadhaar'.tr);
     }



    else {
       DateTime date = DateFormat('dd-MM-yyyy').parseStrict(dateOfBirthPicController!.text);
       String devoteeDOB = DateFormat('yyyy-MM-dd').format(date);
      updateRegistrationVM.isLoading.value = true;
      await updateRegistrationVM.postDevoteeRegistrationData(
          devoteeProfileDetailsVM.id!,
          updateNameController!.text,
          updateMobController!.text,
          devoteeDOB,
          gender!,
          aadhaarNumberController!.text,
          imgLink.value,
          fcmToken!,
          context);

      if(updateRegistrationVM.statusCode == "200"){
        toastMessage(context, "dRecordUpdatedSuccessSnackBar".tr);
        Get.offAllNamed("/devoteeProfile");
      }
      else{
        toastMessage(context, updateRegistrationVM.statusMessage! );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateRegistrationVM.isLoading.value = false;
    profileDetailsApi();
  }



  ///For image uploading
  FilePickerResult? result;
  String fileName = '';
  bool isLoading = false;
  PlatformFile? pickedfile;
  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg'],
        allowMultiple: false,
      );

      if (result != null) {
        fileName = result!.files.first.name;
        pickedfile = result!.files.first;
        devoteeProfileImagePath = File(result!.files.single.path ?? "");
        print('File name $fileName');
        uploadDevoteeFileOrDocs(context);
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }


  ///For profile open bottomSheet
  void devoteeUpdateImage() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 15,
                      top: MediaQuery.of(context).size.height / 75),
                  child: Text(
                    "profilePhoto".tr,
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context).size.height / 55,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height /50,
                      left: MediaQuery.of(context).size.width / 10,
                      right: MediaQuery.of(context).size.width / 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          PermissionStatus status = await Permission.camera.request();
                          if(status == PermissionStatus.permanentlyDenied ||status == PermissionStatus.denied )
                          {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 3),
                                    content: Row(
                                      children: [
                                        Text("cameraPermission".tr),
                                        const Spacer(),
                                        TextButton(onPressed: (){
                                          openAppSettings();
                                        }, child:  Text("setting".tr))

                                      ],
                                    ),
                                  ));
                            });
                            Get.back();


                          }
                          if (status.isGranted) {

                            //pickCameraFile1();
                            //Get.toNamed("/profileCameraPage");
                            Get.toNamed('/devoteeProfileCameraPage')!.then((_) => setState(() {}));
                            //   Get.back();
                          }
                        },
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(
                                      100),
                                  gradient: const LinearGradient(
                                      begin:
                                      Alignment.centerLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[
                                        Color(0xFFEC6019),
                                        Color(0xFFFEB148),
                                        Color(0xFFFEB148)
                                      ])),
                              child:
                              CircleAvatar(

                                backgroundColor: Colors
                                    .white
                                    .withOpacity(
                                    0.0),
                                radius:
                                MediaQuery.of(context).size.height/25,
                                child:  Icon(
                                    Icons
                                        .camera_alt,
                                    color: Colors
                                        .white,
                                    size:MediaQuery.of(context).size.height/30),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'dCameraBtn'
                                  .tr,
                              style:  TextStyle(
                                  fontSize:
                                  MediaQuery.of(context).size.height/55,
                                  fontFamily:
                                  'OpenSans'),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final deviceInfo = await DeviceInfoPlugin().androidInfo;
                          if(deviceInfo.version.sdkInt > 32){
                            PermissionStatus storageStatus = await Permission.photos .request();
                            if(storageStatus == PermissionStatus.permanentlyDenied|| storageStatus == PermissionStatus.denied )
                            {
                              SchedulerBinding.instance.addPostFrameCallback((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 3),
                                      content: Row(
                                        children: [
                                          Text("storagePermission".tr),
                                          const Spacer(),
                                          TextButton(onPressed: (){
                                            openAppSettings();
                                          }, child:  Text("setting".tr))

                                        ],
                                      ),
                                    ));
                              });
                              Get.back();
                            }
                            else{
                              pickFile();
                              Get.back();
                            }
                          }
                          else{
                            PermissionStatus storageStatus = await Permission.storage .request();
                            if( storageStatus == PermissionStatus.permanentlyDenied||  storageStatus == PermissionStatus.denied)
                            {
                              SchedulerBinding.instance.addPostFrameCallback((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 3),
                                      content: Row(
                                        children: [
                                          Text("storagePermission".tr),
                                          const Spacer(),
                                          TextButton(onPressed: (){
                                            openAppSettings();
                                          }, child:  Text("setting".tr))

                                        ],
                                      ),
                                    ));
                              });
                              Get.back();


                            }
                            else{
                              pickFile();
                              Get.back();
                            }
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(100),
                                  gradient: const LinearGradient(
                                      begin:
                                      Alignment.centerLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[
                                        Color(0xFFEC6019),
                                        Color(0xFFFEB148),
                                        Color(0xFFFEB148)
                                      ])),
                              child:
                              CircleAvatar(
                                backgroundColor: Colors
                                    .white
                                    .withOpacity(
                                    0.0),
                                radius:MediaQuery.of(context).size.height/25,
                                child:  Icon(
                                    Icons
                                        .photo,
                                    color: Colors
                                        .white,
                                    size:MediaQuery.of(context).size.height/30),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'dGalleryBtn'
                                  .tr,
                              style:  TextStyle(
                                  fontSize:MediaQuery.of(context).size.height/55,
                                  fontFamily:
                                  'OpenSans'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
    //pickFile();
  }



  ///Calender for dob
  DateTime? pickedDate;
  void openCalender2() async {
    pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),

      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFFE95915), // <-- SEE HERE
                  onPrimary: Colors.white, // <-- SEE HERE
                  onSurface: Colors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, // button text color
                    ))),
            child: child!);
      },
    );
    if (pickedDate != null) {
      setState(() {
        dateOfBirthPicController?.text = DateFormat('dd-MM-yyyy').format(pickedDate!);
        print(dateOfBirthPicController?.text);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
          ()=> ModalProgressHUD(
        inAsyncCall: devoteeProfileDetailsVM.isLoading.value == true  ||
            updateRegistrationVM.isLoading.value == true ||
            uploadPhotoLoaderPofile.value == true,
        progressIndicator: progressIndicator(),
        child: WillPopScope(
          onWillPop: ()async{
            Get.offAllNamed("/devoteeProfile");
            return false;
          },
          child: Scaffold(
            appBar: updateProfileAppbar(context,"updateProfileTitle".tr),
            body: SingleChildScrollView(
              scrollDirection:Axis.vertical,
              child: SizedBox(
                height: MediaQuery.of(context).size.height/1.18,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height /35,
                      left: MediaQuery.of(context).size.width / 20,
                      right: MediaQuery.of(context).size.width / 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          devoteeUpdateImage();
                        },
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width /3,
                            height: MediaQuery.of(context).size.height /7,
                            child: Stack(
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
                                        imgLink.value,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/40,
                                      bottom: MediaQuery.of(context).size.height/70),
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                          onTap: () async {
                                            devoteeUpdateImage();
                                          },
                                          child: CircleAvatar(
                                              radius: MediaQuery.of(context).size.height /60,
                                              backgroundColor: Colors.black54,
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: MediaQuery.of(context).size.height / 55,
                                              )))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/40,),
                      updateProfileLabels(context,"pMobileNo".tr),
                      SizedBox(height: MediaQuery.of(context).size.height/100,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/20,
                        child: TextFormField(
                          readOnly: true,
                          controller: updateMobController,
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontSize: MediaQuery.of(context).size.height/60,
                          ),
                          cursorColor: Colors.black26,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),

                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:MediaQuery.of(context).size.width/70),
                            filled: true,
                            fillColor: const Color(0xFFF2F2F2),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "dMobileHint".tr,
                            hintStyle: TextStyle(
                              fontFamily: "NotoSans",
                              color: Colors.black54,
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery.of(context).size.height/60,
                            ),
                          ),
                          keyboardType: TextInputType.number,),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/40,),
                      updateProfileLabels(context,"rName".tr),
                      SizedBox(height: MediaQuery.of(context).size.height/100,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/20,
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: updateNameController,
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontSize: MediaQuery.of(context).size.height/60,
                          ),
                          cursorColor: Colors.black26,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z ]')),
                            LengthLimitingTextInputFormatter(50),
                            TextInputFormatter.withFunction((oldValue, newValue) {
                              String trimmedText = newValue.text.trimLeft();
                              final cursorOffset = newValue.selection.baseOffset - (newValue.text.length - trimmedText.length);
                              return TextEditingValue(
                                text: trimmedText,
                                selection: TextSelection.collapsed(offset: cursorOffset),
                              );
                            }),
                          ],
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:MediaQuery.of(context).size.width/70),
                            isDense: false,

                            filled: true,
                            fillColor: const Color(0xFFF2F2F2),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "enterDevoteeName".tr,
                            hintStyle: TextStyle(
                              fontFamily: "NotoSans",
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery.of(context).size.height/60,
                            ),


                          ),

                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words, // Capitalize the first letter of each word
                          // You can add more properties like validators, controllers, and onChanged as needed
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/40,),
                      updateProfileLabels(context,"selectGender".tr),
                      Row(
                        children: [
                          Radio(
                            activeColor: const Color(0xFFEC6019),
                            value: male,
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                                print(gender);
                              });
                            },
                          ),
                          Text(
                            "male".tr,
                            style:TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                              fontSize: MediaQuery.of(context).size.height/60,
                            ),
                          ),
                          Radio(
                            activeColor: const Color(0xFFEC6019),
                            value: female,
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                                print(gender);
                              });
                            },
                          ),
                          Text(
                            "female".tr,
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                              fontSize: MediaQuery.of(context).size.height/60,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/40,),
                      updateProfileLabels(context,"dDateOfBirth".tr),
                      SizedBox(height: MediaQuery.of(context).size.height/100,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/19,
                        child: TextFormField(
                          readOnly: true,
                          cursorColor: const Color(0xFFF3822C),
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontSize: MediaQuery.of(context).size.height/60,
                          ),
                          keyboardType: TextInputType.none,
                          onTap: openCalender2,
                          controller: dateOfBirthPicController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              hintText: 'selectDatee'.tr,
                              hintStyle:  TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: MediaQuery.of(context).size.height/55,
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                              filled: true,
                              fillColor: const Color(0xFFF2F2F2),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              isDense: true,
                              border: InputBorder.none,
                              suffixIcon: const Icon(
                                Icons.calendar_month,
                                size: 20,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/40,),
                      updateProfileLabels(context,"aadhaarNumber".tr),
                      SizedBox(height: MediaQuery.of(context).size.height/100,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/20,
                        child: TextFormField(
                          controller: aadhaarNumberController,
                          style:  TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontSize: MediaQuery.of(context).size.height/60,
                          ),
                          cursorColor: Colors.black26,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(12),

                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:MediaQuery.of(context).size.width/70),
                            filled: true,
                            fillColor: const Color(0xFFF2F2F2),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "pleaseEnterAadhaar".tr,
                            hintStyle: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                              fontSize: MediaQuery.of(context).size.height/55,
                            ),
                          ),
                          keyboardType: TextInputType.number,),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/15,),


                      GestureDetector(
                        onTap: (){
                          updateDevoteeRegistartionData();
                        },
                          child: commonButton(context,"update".tr)),

                    ],

                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
