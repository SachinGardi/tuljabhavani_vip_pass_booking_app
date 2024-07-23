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
import 'package:tulajapur/view/common_widget/snack_bar.dart';
import 'package:tulajapur/view/non_referral_pass/spl_donation_epass_details/camera_design.dart';
import 'package:tulajapur/view/non_referral_pass/spl_donation_epass_details/spl_donation_epass_widgets.dart';
import 'package:tulajapur/view/non_referral_pass/spl_donation_epass_details/upload_files.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import '../../../repository/spl_donation_epass_repo/free_pass_details_repo.dart';
import '../../../view_modal/spl_donation_epass_vm/free_pass_details_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/spl_epass_add_details_vm/add_devotee_details_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/spl_epass_add_details_vm/cancel_booking_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/spl_epass_add_details_vm/delete_devotee_record_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/spl_epass_add_details_vm/multiple_devotee_details_vm.dart';
import '../../../view_modal/spl_donation_epass_vm/spl_epass_add_details_vm/visitdate_time_deatils_vm.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/progress_indicator.dart';
import '../devotee_profile/common_name.dart';
import '../spl_donation_epass_paymentdetail/payment_deatil_common_widget.dart';

VisitDateAndTimeDetailsVM visitDateAndTimeDetailsVM = Get.put(VisitDateAndTimeDetailsVM());
AddDevoteeDetailsVM addDevoteeDetailsVM = Get.put(AddDevoteeDetailsVM());
MultipleDevoteeDetailsVM multipleDevoteeDetailsVM = Get.put(MultipleDevoteeDetailsVM());
DeleteDevoteeRecordVm deleteDevoteeRecordVm = Get.put(DeleteDevoteeRecordVm());
CancelSplePassBookingVM cancelSplePassBookingVM = Get.put(CancelSplePassBookingVM());
FreePassDetailsVM freePassDetailsVM = Get.put(FreePassDetailsVM());
class SplePassDetailsView extends StatefulWidget {
  const SplePassDetailsView({Key? key}) : super(key: key);

  @override
  State<SplePassDetailsView> createState() => _SplePassDetailsViewState();
}

class _SplePassDetailsViewState extends State<SplePassDetailsView> {


  bool isEditable = false;
  int? editableId;
  int? editableDevoteeId;
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
        uploadedDevoteeImagePath = File(result!.files.single.path ?? "");
        print('File name $fileName');
        uploadAllDevoteeFileOrDocs(context);
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  TextEditingController devoteeDetailsNameController = TextEditingController();
  TextEditingController devoteeDetailsDOBController = TextEditingController();
  TextEditingController devoteeDetailsAadhaarController = TextEditingController();

  ///For profile open bottomSheet
  void allDevoteeUpdateImage() {
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
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .height / 55,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height / 50,
                      left: MediaQuery
                          .of(context)
                          .size
                          .width / 10,
                      right: MediaQuery
                          .of(context)
                          .size
                          .width / 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          PermissionStatus status = await Permission.camera
                              .request();
                          if (status == PermissionStatus.permanentlyDenied ||
                              status == PermissionStatus.denied) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 3),
                                    content: Row(
                                      children: [
                                        Text("cameraPermission".tr),
                                        const Spacer(),
                                        TextButton(onPressed: () {
                                          openAppSettings();
                                        }, child: Text("setting".tr))

                                      ],
                                    ),
                                  ));
                            });
                            Get.back();
                          }
                          if (status.isGranted) {
                            //pickCameraFile1();
                            //Get.toNamed("/profileCameraPage");
                            Get.toNamed('/allDevoteeCameraPage')!.then((_) =>
                                setState(() {}));
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
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height / 25,
                                child: Icon(
                                    Icons
                                        .camera_alt,
                                    color: Colors
                                        .white,
                                    size: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 30),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'dCameraBtn'
                                  .tr,
                              style: TextStyle(
                                  fontSize:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height / 55,
                                  fontFamily:
                                  'OpenSans'),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final deviceInfo = await DeviceInfoPlugin()
                              .androidInfo;
                          if (deviceInfo.version.sdkInt > 32) {
                            PermissionStatus storageStatus = await Permission
                                .photos.request();
                            if (storageStatus == PermissionStatus
                                .permanentlyDenied ||
                                storageStatus == PermissionStatus.denied) {
                              SchedulerBinding.instance.addPostFrameCallback((
                                  _) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 3),
                                      content: Row(
                                        children: [
                                          Text("storagePermission".tr),
                                          const Spacer(),
                                          TextButton(onPressed: () {
                                            openAppSettings();
                                          }, child: Text("setting".tr))

                                        ],
                                      ),
                                    ));
                              });
                              Get.back();
                            }
                            else {
                              pickFile();
                              Get.back();
                            }
                          }
                          else {
                            PermissionStatus storageStatus = await Permission
                                .storage.request();
                            if (storageStatus == PermissionStatus
                                .permanentlyDenied ||
                                storageStatus == PermissionStatus.denied) {
                              SchedulerBinding.instance.addPostFrameCallback((
                                  _) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 3),
                                      content: Row(
                                        children: [
                                          Text("storagePermission".tr),
                                          const Spacer(),
                                          TextButton(onPressed: () {
                                            openAppSettings();
                                          }, child: Text("setting".tr))

                                        ],
                                      ),
                                    ));
                              });
                              Get.back();
                            }
                            else {
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
                                radius: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 25,
                                child: Icon(
                                    Icons
                                        .photo,
                                    color: Colors
                                        .white,
                                    size: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 30),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'dGalleryBtn'
                                  .tr,
                              style: TextStyle(
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 55,
                                  fontFamily:
                                  'OpenSans'),
                            )
                          ],
                        ))
                    ],
                  ),
                ),
              ],
            ),
          );
        });
    //pickFile();
  }

  visitDateTimeApiCalling() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String devoteeMobileNo = preference.getString("mob")!;
    visitDateAndTimeDetailsVM.visitDateAndTimeDetailsList.clear();
    visitDateAndTimeDetailsVM.isLoading.value = true;
    await visitDateAndTimeDetailsVM.getVisitDateTimeDetails(devoteeMobileNo!);


    if(visitDateAndTimeDetailsVM.isExpired == 8){
      preference.remove("isPassGenerated");
      Get.offAllNamed("/nonReferralPassBooking");
    }
    multipleDevoteeDetailsVM.allDevoteeDetailsList.clear();
    multipleDevoteeDetailsVM.isLoading.value = true;
    await multipleDevoteeDetailsVM.getAllDevoteeDetails(devoteeMobileNo!);
  }

  deleteDevotee() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String devoteeMobileNo = preference.getString("mob")!;
    deleteDevoteeRecordVm.isLoading.value = true;
    await deleteDevoteeRecordVm.deleteDevoteeRecord(editableId!, editableDevoteeId!, context);
    if(deleteDevoteeRecordVm.statusCode == "200"){
      toastMessage(context, 'dRecordDeleteSnackBar'.tr);
      devoteeDetailsNameController.clear();
      devoteeDetailsDOBController.clear();
      devoteeDetailsAadhaarController.clear();
      gender= "";
      imgLinkForDevotees.value = "";
      isEditable = false;
      multipleDevoteeDetailsVM.allDevoteeDetailsList.clear();
      multipleDevoteeDetailsVM.isLoading.value = true;
      await multipleDevoteeDetailsVM.getAllDevoteeDetails(devoteeMobileNo!);
    }
    else{
      toastMessage(context, 'Something wents wrong,please try again');
    }
  }

  postDevoteeInfo() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String devoteeMobileNo = preference.getString("mob")!;
    int devoteeId = preference.getInt("devoteeId")!;
    print(devoteeId);
    if (isEditable == false) {
      if (multipleDevoteeDetailsVM.allDevoteeDetailsList.length <
          visitDateAndTimeDetailsVM.noOfDevotees!) {
        if (devoteeDetailsNameController.text.isEmpty) {
          toastMessage(
              context, 'enterDevoteeName'.tr);
        }
        else if (devoteeDetailsDOBController.text.isEmpty) {
          toastMessage(
              context, 'pleaseSelectDate'.tr);
        }
        else if (gender == null || gender == "") {
          toastMessage(
              context, 'pleaseSelectGender'.tr);
        }
        else if (devoteeDetailsAadhaarController.text.isEmpty) {
          toastMessage(
              context, 'pleaseEnterAadhaar'.tr);
        }
        else if(devoteeDetailsAadhaarController!.text.startsWith("1") || devoteeDetailsAadhaarController!.text.startsWith("0") ||
            devoteeDetailsAadhaarController!.text.length<12 ){
          toastMessage(
              context, 'pleaseEnterValidAadhaar'.tr);
        }

        else if (imgLinkForDevotees.value.isEmpty) {
          toastMessage(
              context, 'pleaseUploadImage'.tr);
        }
        else {
          addDevoteeDetailsVM.isLoading.value = true;
          DateTime date = DateFormat('dd-MM-yyyy').parseStrict(devoteeDetailsDOBController.text);
          String devoteeDOB = DateFormat('yyyy-MM-dd').format(date);
          await addDevoteeDetailsVM.postDevoteeDetails(
              isEditable == false ? 0 : editableId!,
              devoteeId!,
              0,
              devoteeDetailsNameController.text,
              devoteeMobileNo!,
              "",
              500,
              gender!,
              DateTime.parse(devoteeDOB),
              devoteeDetailsAadhaarController.text,
              "",
              imgLinkForDevotees.value,
              0,
              DateTime.now(),
              false,
              "",
              "",
              "",
              context);

          if (addDevoteeDetailsVM.statusCode == "200") {
            devoteeDetailsNameController.clear();
            devoteeDetailsDOBController.clear();
            devoteeDetailsAadhaarController.clear();
            gender = "";
            imgLinkForDevotees.value = "";
            toastMessage(context, "detailsAdded".tr);
            multipleDevoteeDetailsVM.allDevoteeDetailsList.clear();
            multipleDevoteeDetailsVM.isLoading.value = true;
            await multipleDevoteeDetailsVM.getAllDevoteeDetails(devoteeMobileNo!);
          }
          else if(addDevoteeDetailsVM.statusMessage! == 'e-Pass is applicable for the age more than 10 years'
          ||addDevoteeDetailsVM.statusMessage! == "400"){
            toastMessage(context, 'dAgeLimitSnackBar'.tr);
          }
          else if(addDevoteeDetailsVM.statusMessage! == 'Aadhar no already added.'
              ||addDevoteeDetailsVM.statusMessage! == "409"){
            toastMessage(context, 'dAadhaarAlreadyExistMsg'.tr);
          }
          else {

            toastMessage(context, 'Something wents wrong');
          }
        }
      }
      else {
        toastMessage(context, "limitEnd".tr);
      }
    }
    else if (isEditable == true){
      if (devoteeDetailsNameController.text.isEmpty) {
        toastMessage(
            context, 'enterDevoteeName'.tr);
      }
      else if (devoteeDetailsDOBController.text.isEmpty) {
        toastMessage(
            context, 'pleaseSelectDate'.tr);
      }
      else if (gender == null ||  gender == "") {
        toastMessage(
            context, 'pleaseSelectGender'.tr);
      }
      else if (devoteeDetailsAadhaarController.text.isEmpty) {
        toastMessage(
            context, 'pleaseEnterAadhaar'.tr);
      }
      else if(devoteeDetailsAadhaarController!.text.startsWith("1") || devoteeDetailsAadhaarController!.text.startsWith("0") ||
          devoteeDetailsAadhaarController!.text.length<12 ){
        toastMessage(
            context, 'pleaseEnterValidAadhaar'.tr);
      }

      else if (imgLinkForDevotees.value.isEmpty) {
        toastMessage(
            context, 'pleaseUploadImage'.tr);
      }
      else {
        addDevoteeDetailsVM.isLoading.value = true;
        DateTime date = DateFormat('dd-MM-yyyy').parseStrict(devoteeDetailsDOBController.text);
        String devoteeDOB = DateFormat('yyyy-MM-dd').format(date);
        await addDevoteeDetailsVM.postDevoteeDetails(
            editableId!,
            devoteeId!,
            0,
            devoteeDetailsNameController.text,
            devoteeMobileNo!,
            "",
            500,
            gender!,
            DateTime.parse(devoteeDOB),
            devoteeDetailsAadhaarController.text,
            "",
            imgLinkForDevotees.value,
            0,
            DateTime.now(),
            false,
            "",
            "",
            "",
            context);

        if (addDevoteeDetailsVM.statusCode == "200") {
          devoteeDetailsNameController.clear();
          devoteeDetailsDOBController.clear();
          devoteeDetailsAadhaarController.clear();
          gender = "";
          imgLinkForDevotees.value = "";
          toastMessage(context, "updateDetailToast".tr);
          multipleDevoteeDetailsVM.allDevoteeDetailsList.clear();
          multipleDevoteeDetailsVM.isLoading.value = true;
          await multipleDevoteeDetailsVM.getAllDevoteeDetails(devoteeMobileNo!);
          isEditable = false;
        }
        else {
          toastMessage(context, addDevoteeDetailsVM.statusMessage!);
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    visitDateTimeApiCalling();
    addDevoteeDetailsVM.isLoading.value = false;
    deleteDevoteeRecordVm.isLoading.value = false;
    cancelSplePassBookingVM.isLoading.value = false;
    uploadPhotoLoader.value = false;
    imgLinkForDevotees.value = "";
    freePassDetailsVM.isLoading.value = false;
    super.initState();
  }

  String male = 'Male';
  String female = 'Female';
  String? gender;
  ///Calender of choosing date of birth
  DateTime? pickedDobDate;
  void dobCalender() async {
    pickedDobDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1848),
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
    if (pickedDobDate != null) {
      setState(() {
        devoteeDetailsDOBController?.text = DateFormat('dd-MM-yyyy').format(pickedDobDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async{
        Get.offAllNamed("/dashBoard");
        return false;
      },
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: devoteeDetailsAppBar("devoteeLogin".tr,context),
          body: Obx(()=>
             ModalProgressHUD(
              inAsyncCall: visitDateAndTimeDetailsVM.isLoading.value == true
               || uploadPhotoLoader.value == true
               || addDevoteeDetailsVM.isLoading.value == true
               || multipleDevoteeDetailsVM.isLoading.value == true
               || deleteDevoteeRecordVm.isLoading.value == true
               || freePassDetailsVM.isLoading.value == true,
              progressIndicator: progressIndicator(),

              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height/1.13,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height/90,),
                            Row(
                              children: [
                                Text(
                            "visitDate".tr,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height /62,
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              color: Colors.black54)),
                                Text(
                                    visitDateAndTimeDetailsVM.visitDate ?? "",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height /62,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        color: Colors.black)),
                                const Spacer(),
                                Text(
                                    "timeSlot".tr,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height /62,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        color: Colors.black54)),
                                Text(
                                    visitDateAndTimeDetailsVM.timeSlot ?? "",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height /62,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        color: Colors.black)),

                          ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/80,),
                            Row(
                              children: [
                                Text(
                                    "devoteeNo".tr,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height /62,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        color: Colors.black54)),
                                Text(
                                    visitDateAndTimeDetailsVM.noOfDevotees.toString() ?? "",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height /62,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        color: Colors.black)),
                                const Spacer(),
                                Text(
                                    "amountTotal".tr,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height /62,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        color: Colors.black54)),
                                Text(
                                    "₹ ${visitDateAndTimeDetailsVM.totalAmount.toString() ?? ''}",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height /62,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        color: Colors.black)),

                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/100,),
                            const Divider(
                              color: Colors.deepOrangeAccent,
                              thickness: 2,
                            ),

                            Row(
                              children: [
                                const Spacer(),
                                Text(
                                    "${multipleDevoteeDetailsVM.allDevoteeDetailsList.length ?? 0 }/${visitDateAndTimeDetailsVM.noOfDevotees ?? ""}",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height /60,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        color: Colors.deepOrangeAccent)),

                              ],
                            ),

                            commonRichText("devoteeName".tr,"" , context),
                            SizedBox(height: MediaQuery.of(context).size.height/120,),
                            SizedBox(
                              height: MediaQuery.of(context).size.height/20,
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: devoteeDetailsNameController,
                                style:  TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                  fontSize: MediaQuery.of(context).size.height/60,),

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
                                  hintText: "hintDevoteeName".tr,
                                  hintStyle: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                    fontSize: MediaQuery.of(context).size.height/60,
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words, // Capitalize the first letter of each word
                                // You can add more properties like validators, controllers, and onChanged as needed
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/60,),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex:1,
                                    child: commonRichText("selectDOB".tr,"" , context)),
                                SizedBox(width: MediaQuery.of(context).size.width/12,),
                                Expanded(
                                    flex: 1,
                                    child: commonRichText("selectGender".tr,"" , context)),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/120,),
                           Row(
                             children: [
                               Expanded(
                                 flex: 1,
                                 child:
                                     SizedBox(
                                       height: MediaQuery.of(context).size.height/19,
                                       child: TextFormField(
                                         readOnly: true,
                                         cursorColor: const Color(0xFFF3822C),
                                         style:   TextStyle(
                                           fontFamily: "OpenSans",
                                           fontWeight: FontWeight.w600,
                                           color: Colors.black54,
                                           fontSize: MediaQuery.of(context).size.height/60,),
                                         keyboardType: TextInputType.none,
                                         onTap: dobCalender,
                                         controller: devoteeDetailsDOBController,
                                         textAlignVertical: TextAlignVertical.center,
                                         decoration: InputDecoration(
                                             hintText: 'DD/MM/YYYY',
                                             hintStyle:  TextStyle(
                                               fontFamily: "OpenSans",
                                               fontWeight: FontWeight.w500,
                                               color: Colors.black54,
                                               fontSize: MediaQuery.of(context).size.height/62,
                                             ),
                                             contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                             filled: true,
                                             fillColor: const Color(0xFFF2F2F2),
                                             enabledBorder: OutlineInputBorder(
                                               borderSide: BorderSide.none,
                                               borderRadius: BorderRadius.circular(10)),
                                             focusedBorder: OutlineInputBorder(
                                               borderSide: BorderSide.none,
                                               borderRadius: BorderRadius.circular(10)),
                                             isDense: true,
                                             border: InputBorder.none,
                                             suffixIcon: const Icon(
                                               Icons.calendar_month,
                                               size: 20,
                                               color: Colors.black,
                                             )),
                                       ),
                                     ),

                               ),
                               Expanded(
                                 flex: 1,
                                 child:Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
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
                                         fontSize: MediaQuery.of(context).size.height/65,
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
                                         fontSize: MediaQuery.of(context).size.height/65,
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                            SizedBox(height: MediaQuery.of(context).size.height/60,),
                            commonRichText("aadhaarNo".tr,"" , context),
                            SizedBox(height: MediaQuery.of(context).size.height/120,),
                            SizedBox(
                              height: MediaQuery.of(context).size.height/20,
                              child: TextFormField(
                                controller: devoteeDetailsAadhaarController,
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
                                  hintText: "enterAadhaarNo".tr,
                                  hintStyle: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                    fontSize: MediaQuery.of(context).size.height/60,
                                  ),
                                ),
                                keyboardType: TextInputType.number,),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/50,),
                            imgLinkForDevotees.value == ""? GestureDetector(
                              onTap: (){
                                allDevoteeUpdateImage();
                              },
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      allDevoteeUpdateImage();
                                    },
                                      child: Icon(Icons.camera_alt,size: MediaQuery.of(context).size.height/36)),
                                  SizedBox(width: MediaQuery.of(context).size.width/40),
                                  commonRichText("uploadPhoto".tr,"" , context),

                                ],
                              ),
                            ) :
                            Container(
                              height:MediaQuery.of(context).size.height/30,
                              width: MediaQuery.of(context).size.width/2.3,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey, // Adjust shadow color and opacity
                                      spreadRadius: 1, // Adjust the spread radius
                                      blurRadius: 5, // Adjust the blur radius
                                      offset: Offset(0, 3), // Adjust the offset
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5)),
                              child:Row(
                                children: [
                             Icon(Icons.image_rounded,size: MediaQuery.of(context).size.height/50,color: Colors.orange,),
                                  Expanded(
                                    flex: 3,
                                    child: Text(imgLinkForDevotees.value ?? "",
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                        fontSize: MediaQuery.of(context).size.height/70,
                                      ),),
                                  ),
                                  imgLinkForDevotees.value == ""? const Text(""): Padding(
                                    padding:  const EdgeInsets.only(right: 5.0),
                                    child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            imgLinkForDevotees.value = "";
                                          });
                                        },
                                        child: Icon(Icons.cancel_outlined,
                                          size: MediaQuery.of(context).size.height/40,
                                          color: Colors.redAccent,)),
                                  )

                                ],
                              ),
                            ),



                            Row(
                              children: [
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      devoteeDetailsNameController.clear();
                                      devoteeDetailsDOBController.clear();
                                      devoteeDetailsAadhaarController.clear();
                                      gender= "";
                                      imgLinkForDevotees.value = "";
                                      isEditable = false;

                                    });
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
                                              "clearDetails".tr,
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.height /65,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "OpenSans",
                                                  color: Colors.black),
                                            )),
                                      )),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width/30,),
                                GestureDetector(
                                  onTap: () {
                                    postDevoteeInfo();
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
                                            child: Text(isEditable == true ?"updateInfo".tr:
                                              "addDetails".tr,
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.height /65,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "OpenSans",
                                                  color: Colors.white)))))),
                                SizedBox(width: MediaQuery.of(context).size.width/45),


                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/90),
                            NotificationListener<OverscrollIndicatorNotification>(
                              onNotification: (overScroll) {
                                overScroll.disallowIndicator();
                                return true;
                              },
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height/3.2,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemCount: multipleDevoteeDetailsVM.allDevoteeDetailsList.length,
                                  itemBuilder: (BuildContext context, int index) {

                                   return Column(
                                     children: [
                                       SizedBox(height: MediaQuery.of(context).size.height/80),
                                       Padding(
                                         padding:  EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width/80),
                                         child: Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 6,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    // Adjust shadow color and opacity
                                                    spreadRadius: 2,
                                                    // Adjust the spread radius
                                                    blurRadius: 5,
                                                    // Adjust the blur radius
                                                    offset: const Offset(
                                                        0, 3), // Adjust the offset
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.circular(5)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 40,
                                                vertical: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height / 100,
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex:10,
                                                        child: Text(multipleDevoteeDetailsVM.allDevoteeDetailsList[index].devoteeName ?? "",
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xFF3B3B3B),
                                                              fontFamily: "NotoSans",
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height / 59,
                                                              fontWeight: FontWeight
                                                                  .bold),),
                                                      ),
                                                      const Spacer(),
                                                      index == 0 ?Text("primaryDevotee".tr,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(context).size.height /60,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: "OpenSans",
                                                            color: Colors.orange),):GestureDetector(
                                                        onTap:(){
                                                          setState(() {
                                                            editableDevoteeId=multipleDevoteeDetailsVM.allDevoteeDetailsList[index].devoteeId;
                                                            editableId = multipleDevoteeDetailsVM.allDevoteeDetailsList[index].id;
                                                            deleteDevotee();
                                                          });
                                                          print(multipleDevoteeDetailsVM.allDevoteeDetailsList[index].devoteeName);

                                                        },
                                                        child: Icon(Icons.delete, color: Colors.redAccent,
                                                          size: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height / 30),
                                                      ),
                                                      SizedBox(width: MediaQuery.of(context).size.width/70,),
                                                      index == 0 ?const Text(""):
                                                      GestureDetector(
                                                        onTap:(){

                                                          setState(() {
                                                            isEditable = true;
                                                            editableDevoteeId=multipleDevoteeDetailsVM.allDevoteeDetailsList[index].devoteeId;
                                                            editableId = multipleDevoteeDetailsVM.allDevoteeDetailsList[index].id;
                                                            String dob =  DateFormat('dd-MM-yyyy').format(DateTime.parse(multipleDevoteeDetailsVM.allDevoteeDetailsList[index].dateOfBirth.toString()));
                                                            devoteeDetailsNameController  = TextEditingController(text: multipleDevoteeDetailsVM.allDevoteeDetailsList[index].devoteeName ?? "");
                                                            devoteeDetailsDOBController  = TextEditingController(text:dob );
                                                            devoteeDetailsAadhaarController  = TextEditingController(text: multipleDevoteeDetailsVM.allDevoteeDetailsList[index].aadharNo ?? "");
                                                            gender = multipleDevoteeDetailsVM.allDevoteeDetailsList[index].gender ?? "";
                                                            imgLinkForDevotees.value = multipleDevoteeDetailsVM.allDevoteeDetailsList[index].imagePath ?? "";


                                                          });
                                                          print(multipleDevoteeDetailsVM.allDevoteeDetailsList[index].devoteeName);

                                                        },
                                                        child: Icon(Icons.edit, color: Colors.blue,
                                                          size: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height / 30),
                                                      ),

                                                    ],
                                                  ),
                                                  Text(
                                                      multipleDevoteeDetailsVM.allDevoteeDetailsList[index].mobileNo ?? "",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height / 62,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "OpenSans",
                                                          color: Colors.black54)),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          "${DateFormat('dd/MM/yyyy').format(DateTime.parse(multipleDevoteeDetailsVM.allDevoteeDetailsList[index].dateOfBirth.toString()??"")) },   ",
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(context).size.height / 62,
                                                              fontWeight: FontWeight.w600,
                                                              fontFamily: "OpenSans",
                                                              color: Colors.black54)),
                                                      Text(
                                                          "${multipleDevoteeDetailsVM.allDevoteeDetailsList[index].age ?? ""} years,    ",
                                                          style: TextStyle(
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height / 62,
                                                              fontWeight: FontWeight.w600,
                                                              fontFamily: "OpenSans",
                                                              color: Colors.black54)),
                                                      Text( multipleDevoteeDetailsVM.allDevoteeDetailsList[index].gender ?? "",
                                                          style: TextStyle(
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height / 62,
                                                              fontWeight: FontWeight.w600,
                                                              fontFamily: "OpenSans",
                                                              color: Colors.black54)),
                                                    ],
                                                  ),
                                                  Text(
                                                      multipleDevoteeDetailsVM.allDevoteeDetailsList[index].aadharNo ?? "",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(context).size.height / 62,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "OpenSans",
                                                          color: Colors.black54)),
                                                  GestureDetector(
                                                    onTap:(){
                                                      Get.toNamed(
                                                          '/imageViewer',
                                                          arguments:multipleDevoteeDetailsVM.allDevoteeDetailsList[index].imagePath ?? "" );
                                                   },
                                                    child: Text(
                                                      "viewPhoto".tr,
                                                      style: TextStyle(
                                                          decorationColor: const Color(
                                                              0xFF505EBC),
                                                          decorationThickness: 1,
                                                          shadows: const [
                                                            Shadow(color: Color(0xFF505EBC),
                                                                offset: Offset(0, -4))
                                                          ],
                                                          decoration: TextDecoration
                                                              .underline,
                                                          fontSize: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height / 62,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "OpenSans",
                                                          color: Colors.transparent),
                                                    ),
                                                  ),


                                                ],
                                              ),
                                            ),
                                          ),
                                       ),
                                       SizedBox(height: MediaQuery.of(context).size.height/80)
                                     ],
                                   );

                                  }
                                    ),
                              ),
                            ),
                             const Spacer(),


                          (visitDateAndTimeDetailsVM.noOfDevotees == multipleDevoteeDetailsVM.allDevoteeDetailsList.length)?
                            GestureDetector(
                                onTap:() async {
                                if(visitDateAndTimeDetailsVM.noOfDevotees == multipleDevoteeDetailsVM.allDevoteeDetailsList.length)
                                   {
                                     if(visitDateAndTimeDetailsVM.totalAmount == 0){
                                       freePassDetailsVM.isLoading.value = true;
                                       await freePassDetailsVM.freePassDetails(int.parse(multipleDevoteeDetailsVM.devoteeId!));
                                       if(FreePassDetailsRepo.statusCode == "200"){
                                         SharedPreferences preferences = await SharedPreferences.getInstance();
                                         var selectedLang = ''.obs;
                                         String language =  preferences.getString('language') ?? 'English';
                                         if(language == "Marathi"){
                                           selectedLang.value = "mr";
                                           print(selectedLang);
                                         }
                                         else if(language == "English"){
                                           selectedLang.value = "en";
                                           print(selectedLang);
                                         }

                                         String encryptionKey = '8080808080808080';
                                         final key = encrypt.Key.fromUtf8(encryptionKey);
                                         final iv = encrypt.IV.fromUtf8(encryptionKey);
                                         final encrypter =
                                         encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
                                         var encryptedInvoiceId = encrypter.encrypt(multipleDevoteeDetailsVM.devoteeId!, iv: iv);
                                         var encodedDecryptedUrl = Uri.encodeComponent(encryptedInvoiceId.base64).replaceAll('%20', '+');
                                         print(encodedDecryptedUrl);
                                         Get.offAllNamed("/paymentGatewayPassView",arguments:"$encodedDecryptedUrl&lan=${selectedLang.value}");
                                         preferences.remove('isPassGenerated') ;
                                       }
                                       else if(FreePassDetailsRepo.statusCode == "404"){
                                         Get.back();
                                         capacityFullDialogue(context);

                                       }
                                       else if(FreePassDetailsRepo.statusCode == "409"){
                                         Get.back();
                                         blockDayDialogue(context);

                                       }
                                       else{
                                         toastMessage(context, "Please try again");
                                       }



                                     }
                                    else{
                                      print("amount${visitDateAndTimeDetailsVM.totalAmount}");
                                       Get.offAllNamed("/splDonationEPassPaymentDetails");
                                     }

                                   }
                                   else{
                                  toastMessage(context, "Please add all devotee details first");
                                  }
                                },
                                child: commonButton(context,"preview".tr)):
                              const SizedBox.shrink()


                          ],
                        ),
                    ),
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
