import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/view/change_password/password_widgets.dart';
import '../../modal/trustee_modal/change_password_modal/change_password_modal.dart';
import '../../view_modal/trustee_vm/change_password_vm/changePasswordVm.dart';
import '../common_widget/common_appBar.dart';
import '../common_widget/common_button.dart';
import '../common_widget/progress_indicator.dart';
import '../common_widget/snack_bar.dart';



bool changePassUpdated = false;
final currentPasswordController = TextEditingController();
final newPasswordController = TextEditingController();
final confirmPasswordController = TextEditingController();
class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}
class _ChangePasswordState extends State<ChangePassword> {
   bool obscureText = true;
   bool obscureText1 = true;
   bool obscureText2 = true;
   void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      obscureText1 = !obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      obscureText2 = !obscureText2;
    });
  }

  @override
  void initState() {
    super.initState();
    currentPasswordController.text = '';
    newPasswordController.text = '';
    confirmPasswordController.text = '';
    changePassUpdated = false;
  }

  final changePasswordVm = Get.put(ChangePasswordVm());
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("changePasswordAppBarTitle".tr),
      body: ModalProgressHUD(
        inAsyncCall: changePassUpdated == true,
        progressIndicator: progressIndicator(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              currentPassword(context,_toggle,obscureText),
              newPassword(context,_toggle1,obscureText1),
              confirmPassword(context,_toggle2,obscureText2),
              Builder(
                builder: (context) {
                  return Center(
                    child: GestureDetector(
                        onTap: () async{
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          String userId =   pref.getString("loginUserId").toString();
                          if (currentPasswordController.text.isEmpty) {
                            toastMessage(
                                context, 'emptyCurrentPasswordSnackBar'.tr);
                          }
                          else if (newPasswordController.text.isEmpty) {
                            toastMessage(context, 'emptyNewPasswordSnackBar'.tr);
                          }
                          else if (confirmPasswordController.text.isEmpty) {
                            toastMessage(
                                context, 'emptyConfirmPassword'.tr);
                          }


                          else if ((newPasswordController.text ==
                                      confirmPasswordController.text)
                                  ) {

                            changePasswordVm.passwordChange(
                                ChangePasswordModal(),
                                currentPasswordController.text,
                                newPasswordController.text,
                                context,
                                int.parse(userId));
                          }
                          else if (newPasswordController.text != confirmPasswordController.text) {
                            toastMessage(context,
                                'passwordNotSameSnackBar'.tr);
                          }

                        },
                        child: commonButton(context, "resetBtnText".tr)),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height/40,),
              Padding(
                padding:  EdgeInsets.all(
                  MediaQuery.of(context).size.width/50
                ),
                child: Container(
                  padding:  EdgeInsets.only(
                      top: MediaQuery.of(context).size.height/70
                  ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    
                    width: 1,
                    color: Colors.deepOrange.withOpacity(0.6)
                  )
                ),
                  child: Column(
                    children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex:6,
                            child: Text('note'.tr,style:  TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                                fontSize: MediaQuery.of(context).size.width/30
                            ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Expanded(
                            flex: 25,
                            child: Text(
                              'yourPassText'.tr,
                              style:  TextStyle(
                                fontFamily: 'OpenSans',
                                  fontSize: MediaQuery.of(context).size.width/30
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/80,),

                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width/6,
                          bottom: MediaQuery.of(context).size.height/60
                        ),
                        // color: Colors.orange,
                        child:  Column(
                          children: [
                            Row(
                              children: [
                                 Icon(Icons.circle,
                                  size: MediaQuery.of(context).size.width/40,),
                                 SizedBox(width: MediaQuery.of(context).size.width/50,),
                                Text('lengthInfo'.tr,style:  TextStyle(
                                  fontFamily: 'OpenSans',
                                    fontSize: MediaQuery.of(context).size.width/30
                                ),)
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/80,),
                             Row(
                              children: [
                                 Icon(Icons.circle,
                                  size: MediaQuery.of(context).size.width/40,),
                                SizedBox(width: MediaQuery.of(context).size.width/50,),
                                Text('containNumberInfo'.tr,style:  TextStyle(
                                  fontFamily: 'OpenSans',
                                    fontSize: MediaQuery.of(context).size.width/30
                                ),)
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/80,),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                         Icon(Icons.circle,
                                          size: MediaQuery.of(context).size.width/40,),
                                        SizedBox(width: MediaQuery.of(context).size.width/50,),
                                        Text('upperCaseInfo'.tr,style:  TextStyle(
                                          fontFamily: 'OpenSans',
                                            fontSize: MediaQuery.of(context).size.width/30
                                        ),),
                                      ],
                                    ),
                                     SizedBox(height: MediaQuery.of(context).size.height/80,),
                                    Padding(
                                      padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/25),
                                      child: Text('lowerCaseInfo'.tr,style:  TextStyle(
                                        fontFamily: 'OpenSans',
                                          fontSize: MediaQuery.of(context).size.width/30
                                      ),),
                                    ),
                                  ],
                                )

                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/80,),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                         Icon(Icons.circle,
                                          size: MediaQuery.of(context).size.width/40,),
                                        SizedBox(width: MediaQuery.of(context).size.width/50,),
                                        Text('mustContain'.tr,style:  TextStyle(
                                          fontFamily: 'OpenSans',
                                            fontSize: MediaQuery.of(context).size.width/30
                                        ),),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height/80,),
                                    Padding(
                                      padding:EdgeInsets.only(left: MediaQuery.of(context).size.width/25),
                                      child: Text('characters'.tr,style:  TextStyle(
                                        fontFamily: 'OpenSans',
                                          fontSize: MediaQuery.of(context).size.width/30
                                      ),),
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
