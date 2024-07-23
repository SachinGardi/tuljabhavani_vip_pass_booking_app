import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tulajapur/splash_design/splash_screen_design.dart';
import 'package:tulajapur/utility/change_language.dart';
import 'package:tulajapur/view/about_temple/about_temple_view.dart';
import 'package:tulajapur/view/change_password/password_design.dart';
import 'package:tulajapur/view/contact_us/contact_us_view.dart';
import 'package:tulajapur/view/dashboard/common_widgets/pfdviewer.dart';
import 'package:tulajapur/view/dashboard/common_widgets/webViewDisplay.dart';
import 'package:tulajapur/view/dashboard/dashboard_view.dart';
import 'package:tulajapur/view/forgot_password/forgot_password_view.dart';
import 'package:tulajapur/view/forgot_password/new_password_view.dart';
import 'package:tulajapur/view/language/language_view.dart';
import 'package:tulajapur/view/login_page/login_view.dart';
import 'package:tulajapur/view/non_referral_pass/devotee_login/devotee_registration.dart';
import 'package:tulajapur/view/non_referral_pass/devotee_login/spl_donation_epass_login.dart';
import 'package:tulajapur/view/non_referral_pass/devotee_profile/camera_design.dart';
import 'package:tulajapur/view/non_referral_pass/devotee_profile/devotee_profile.dart';
import 'package:tulajapur/view/non_referral_pass/devotee_profile/devotee_update_profile.dart';
import 'package:tulajapur/view/non_referral_pass/notification/notification_view.dart';
import 'package:tulajapur/view/non_referral_pass/spl_epass_payment_gateway_preview/e_pass_view.dart';
import 'package:tulajapur/view/non_referral_pass/transaction_history/e_pass_view.dart';
import 'package:tulajapur/view/non_referral_pass/spl_donation_epass_booking/e-pass_booking.dart';
import 'package:tulajapur/view/non_referral_pass/spl_donation_epass_details/camera_design.dart';
import 'package:tulajapur/view/non_referral_pass/spl_donation_epass_details/devotee_details_design.dart';
import 'package:tulajapur/view/non_referral_pass/spl_donation_epass_details/image_viewer.dart';
import 'package:tulajapur/view/non_referral_pass/spl_donation_epass_paymentdetail/spl_donation_epass_payement_deatils.dart';
import 'package:tulajapur/view/non_referral_pass/spl_epass_payment_gateway_preview/payment_fail.dart';
import 'package:tulajapur/view/non_referral_pass/spl_epass_payment_gateway_preview/payment_gateway_view.dart';
import 'package:tulajapur/view/non_referral_pass/spl_epass_payment_gateway_preview/payment_success.dart';
import 'package:tulajapur/view/non_referral_pass/transaction_history/transaction_history.dart';
import 'package:tulajapur/view/validator_module/scan_pass/scanner_view.dart';
import 'package:tulajapur/view/validator_module/scan_pass/scanpass_view.dart';
import 'package:tulajapur/view/vip_pass_detail/vip_pass_details.dart';
import 'firebase_notification_service/firebase_noti_service.dart';
import 'internet_service/NetworkBinding.dart';

String? langSelection;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();/// InitializationSettings  for Android


///Language
Future<String> getLanguage() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('language') ?? 'English';
}
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  FirebaseServiceData().initNotifications();
  ///LandscapeMode Off
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  getLanguage().then((value) => {
    langSelection = value,
    runApp(
        GetMaterialApp(
          initialBinding: NetworkBinding(),
          debugShowCheckedModeBanner: false,
          translations: ChangeAppLanguage(),
          locale: (langSelection == 'English')
              ? const Locale('en', "US")
              : (langSelection == 'Marathi')
              ? const Locale('mr', "IN")
              : const Locale('en', "US"),
          initialRoute:"/",
            getPages: [
              GetPage(name: "/", page:()=> const SplashScreen(),transition: Transition.rightToLeft),
              GetPage(name: "/dashBoard", page:()=> const DashBoard(),transition: Transition.rightToLeft),
              GetPage(name: "/chooseLanguage", page: ()=> const ChooseLanguage(),transition: Transition.rightToLeft),
              GetPage(name: "/loginView", page: ()=> const LoginPage(),transition: Transition.rightToLeft),
              GetPage(name: "/contactUs", page: ()=> const ContactUs(),transition: Transition.rightToLeft),
              GetPage(name: "/aboutTemple", page: ()=> const AboutTemple(),transition: Transition.rightToLeft),
              GetPage(name: "/forgotPassword", page: ()=> const ForgotPassword(),transition: Transition.rightToLeft),
              GetPage(name: "/newPassword", page: ()=> const NewPassword(),transition: Transition.rightToLeft),
              GetPage(name: "/changePassword", page: ()=> const ChangePassword(),transition: Transition.rightToLeft),
              GetPage(name: "/scanPass", page: ()=> const ScanPass(),transition: Transition.rightToLeft),
              GetPage(name: "/scannerView", page: ()=> const ScannerView(),transition: Transition.rightToLeft),
              GetPage(name: "/vipPassDetail", page: ()=> const VipPassDetail(),transition: Transition.rightToLeft),
              GetPage(name: "/webViewDisplay", page: ()=>const WebViewDisplay(),transition: Transition.rightToLeft),
              GetPage(name: "/devoteeRegistration", page: ()=> const DevoteeRegistration(),transition: Transition.rightToLeft),
              GetPage(name: "/devoteeUpdateProfile", page: ()=> const DevoteeUpdateProfile(),transition: Transition.rightToLeft),
              GetPage(name: "/darshanPassLogin", page: ()=> const DarshanPassLogin(),transition: Transition.rightToLeft),
              GetPage(name: "/devoteeProfile", page: ()=> const DevoteeProfile(),transition: Transition.rightToLeft),
              GetPage(name: "/devoteeProfileCameraPage", page: ()=> const DevoteeProfileCameraPage(),transition: Transition.rightToLeft),
              GetPage(name: "/nonReferralPassBooking", page: ()=> const NonReferralPassBooking(),transition: Transition.rightToLeft),
              GetPage(name: "/splePassDetailsView", page: ()=> const SplePassDetailsView(),transition: Transition.rightToLeft),
              GetPage(name: "/allDevoteeCameraPage", page: ()=> const AllDevoteeCameraPage(),transition: Transition.rightToLeft),
              GetPage(name: "/imageViewer", page: ()=> const ImageViewer(),transition: Transition.rightToLeft),
              GetPage(name: "/splDonationEPassPaymentDetails", page: ()=> const SplDonationEPassPaymentDetails(),transition: Transition.rightToLeft),
              GetPage(name: "/transactionHistory", page:()=> const TransactionHistory(),transition: Transition.rightToLeft),
              GetPage(name: "/splePassPaymentGatewayView", page:()=> const SplePassPaymentGatewayView(),transition: Transition.rightToLeft),
              GetPage(name: "/splePassPaymentSuccessView", page:()=> const SplePassPaymentSuccessView(),transition: Transition.rightToLeft),
              GetPage(name: "/splePassPaymentFail", page:()=> const SplePassPaymentFail(),transition: Transition.rightToLeft),
              GetPage(name: "/splDarshanPassView", page:()=> const SplDarshanPassView(),transition: Transition.rightToLeft),
              GetPage(name: "/paymentGatewayPassView", page:()=> const PaymentGatewayPassView(),transition: Transition.rightToLeft),
              GetPage(name: "/devoteeNotificationScreen", page:()=> const DevoteeNotificationScreen(),transition: Transition.rightToLeft),
              GetPage(name: "/pdfViewer", page:()=> const PdfViewer(),transition: Transition.rightToLeft),


          ],
        )
    )
  });
}