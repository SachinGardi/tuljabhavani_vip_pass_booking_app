import 'package:get/get_navigation/src/root/internacionalization.dart';

class ChangeAppLanguage extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    /// English.tr
    'en_US': {
      ///Dashboard Keys
      "dashboardTitle": "Shri Tuljabhavani Mandir",
      "dashboardSubtitle": "Sansthan",
      "templeName":"Shri Tuljabhavani Temple, Tuljapur",
      "shareBtn":"Share",
      "songName":" सर्व मंगल मांगल्ये शिवे सर्वार्थ साधिके।\nशरण्ये त्र्यम्बके गौरी नारायणी नमोस्तुते।।",
      "help":"Help",

      ///Non-Referral e-Pass
      "passName": "Special\nDonation\ne-Pass",
      "passName1": "Special Donation e-Pass",
      "selectPass": "Select e-Pass",
      "capacityExceedMsg": "capacity for selected pass is exceeded",
      "confirmation": "Confirmation",
      "confirmationMessage": "You cannot modify once submitted, do you want to proceed?",
      "lessCapacityMsg": "Capacity is less than entered no. of devotee",
      "myProfile": "My Profile",
      "includingPrimary": " (Including primary devotee)",
      "maxDevotee":"Max 6 devotees allowed per booking.",
      "enterQuantity":"Enter No. of Devotees",
      "passAmount":"Pass Amount : ",
      "totalAvailable":"Total Available : ",
      "totalBookingAmount":"Total Amount :      ",
      "timeSlotError":"Capacity is not available against this time slot",
      "selectEPass":"select e-Pass",
      "enterVisitingError":"Enter no. of devotees visiting",
      "enterDevoteeName":"Please enter devotee name",
      "toastPassBooked":"e-Pass is already booked,please review your transaction history to download the e-Pass.If you have already visited,you can book the e-Pass again the following day.",
      "exitApp":"Are you sure you want to exit app",
      "doubleBack":"Press back button again to exit",
      "deviName":"Shri Tuljabhavani",
      "devoteeLogin":"Devotee Login",
      "validatorLogin":"Validator Login",
      "noTimeSlotAvailable":"No timeSlot available",
      "anotherUserNo":"Mobile number is registered with another user.",


      ///Devotee Details
      "devoteeDetail":"Devotee Details",
      "cancelBooking":"Cancel Booking",
      "toastCancelBooking":"Booking cancelled successfully.",
      "wentWrong":"Something went wrong",
      "cancelBookingMsg":"Are you sure you want to cancel booking ?",
      "visitDate":"Visit Date :  ",
      "timeSlot":"Time Slot :  ",
      "devoteeNo":"No. of Devotees :  ",
      "amountTotal":"Total Amount :  ",
      "updateDetailToast":"Details updated successfully",
      "devoteeName":"Devotee Name",
      "hintDevoteeName":"Enter Devotee Name",
      "selectDOB":"Select Date of Birth",
      "selectGender":"Select Gender",
      "aadhaarNo":"Aadhaar No.",
      "enterAadhaarNo":"Enter Aadhar Number",
      "uploadPhoto":"Upload Photo",
      "clearDetails":"Clear",
      "addDetails":"Add",
      "preview":"Preview ",
      "primary":"Primary",
      "viewPhoto":"View Photo",
      "male":"Male",
      "female":"Female",
      "profilePhoto":"Profile Photo",
      "limitEnd":"Limit end",
      "uploadedImage":"Uploaded Image",
      "pleaseSelectDate":"Please select date of birth",
      "pleaseSelectGender":"Please select your gender",
      "detailsAdded":"Details added successfully",
      "pleaseEnterAadhaar":"Please enter aadhaar number",
      "pleaseEnterValidAadhaar":"Please enter valid aadhaar number",
      "pleaseUploadImage":"Please upload devotee image",
      "welcomeTo":"Welcome To",
      "register":"Register",
      "updateProfileImage":"Please update your profile image",
      "updateProfileTitle":"Update Profile",
      "aadhaarNumber":"Aadhaar Number",
      "devoteeLoginTitle":"Devotee Login",
      "updateInfo":"Update",
      "otpSentSuccess":"OTP sent successfully.",
      "tenYearsLimit":"Devotee registration is applicable for the age more than 10 years.",
      "devoteeRegistered":"Devotee registered successfully.",
      "validatorName":"Validator Name",
      "passScanDate":"Pass Scan Date",



      ///Payment Details Page
      "paymentPreview":"Payment Preview",
      "primaryDevotee":"Primary Devotee",
      "mobileNo":"Mobile No.",
      "paymentVisitDate":"Visit Date",
      "paymentVisitTime":"Visit Time",
      "paymentDevotees":"No. of Devotees",
      "paymentSrNo":"Sr.No",
      "paymentEPass":"e-Pass",
      "paymentQty":"Qty",
      "paymentAmount":"Amount",
      "paymentTotalAmount":"Total Amount",
      "paymentProceed":"Proceed to Payment",
      "selectPayment":"Select a payment method",
      "selectPaymentNote":"You can make a payment with VISA/master/maestro card (issued by a bank) and also through net banking/UPI.",
      "paymentGateway":"Sbi Bank Payment Gateway",
      "makePayment":"Make Payment",
      "toastSelectPayment":"Please select payment gateway",
      "paymentSuccess":"Your e-pass has been generated successfully.",
      "downloadPass":"Download e-Pass",
      "timeOut":"Time Out",
      "serverError":"Payment server is down please try after sometime",



      ///TransactionHistory
      "transactionHistory" : "Transaction History",
      "transactionEPassView" : "e-Pass",

      ///Registration keys
      "registration": "Registration",
      "dateOfBirth": "Date Of Birth",




      ///Choose language Keys
      "english": "English",
      "marathi": "Marathi",
      "chooseLanguage": "Choose Language",
      "continue":"Continue",

      ///HomePage Drawer Keys
      "templeTitle": "Shri Tuljabhavani\nMandir Sansthan",
      "profile": "Profile",
      "aboutTemple": "About Temple",
      "languageSetting": "Setting",
      'templeTitlenew': "Shri Tuljabhavani\nMandir Sansthan",

      ///HomePage Keys
      "templeTitleMap": "Shri Tuljabhavani Temple Trust",
      "templeHomeTitle": "Home",
      "templeSubtitle": "Tuljapur",
      "darshanText": "Online Darshan",
      "donationText": "Online Donation",
      "srikhand": "Sinhasan Pooja",
      "Abhishek": "Abhishek Pooja",
      "freeDarshan": "Free Darshan Pass",
      "denagiDarshan": "Denagi Darshan Pass",
      "ePassMessage": "Click here to book an online referral e-Pass",
      "ePassMessage1": "For Shri Tuljabhavani Mata Darshan",
      "bookPass": "Book Now",
      "bookReferralPass":"BOOK\nREFERRAL\ne-Pass",
      "pleaseEnterOtp":"Please Enter OTP",


      ///Bottom NavigationBar Keys
      "home": "Home",
      "login": "Login",
      "devoteePass": "Book Pass",
      "contact": "Contact",

      ///Login Page Keys
      "loginTitle": "VALIDATOR  LOGIN",
      "trusteeText": "Trustee",
      "validator": "Validator",
      "userNameHint": "Username",
      "passwordHint": "Password",
      "forgotPassword": "Forgot Password?",
      "loginBtnText": "Login",
      "skip": "Skip",
      "back":"Back",



      ///Pass Booking Keys
      "passBookingAppBarTitle":"Pass Booking",
      "devoteeNameHint":"Devotee Name",
      "mobileNoHint":"Mobile No",
      "emailIdHint":"Email Id",
      "totalDevotees":"Total Devotees Visiting",
      "numOfDevoteeHint":"No Of Devotees",
      "submit":"Proceed",
      "cancel":"Cancel",
      "totalAmount":"Total Amount",
      "referenceHint":"Select Reference",
      "ePassValidation":"Maximum 6 devotees are allowed for booking",
      "note":"Note : ",
      "passBookingNote":" No e-Pass required for child devotees below 10 years.",
      "canNotModifyMsg":"You can not modify after submit do you want to proceed ?",
      "beforeProceedingMsg":"Before proceeding further please call and provide necessary details for authentication",
      "allocatePassNote":"Allocate the e-Passes to total devotees visiting",
      "allListControllerEmptyMsg":"No.of Devotees count is required",


      ///Change Password Keys
      "changePasswordAppBarTitle":"Change Password",
      "currentPasswordHint":"Current Password",
      "newPasswordHint":"New Password",
      "confirmNewPasswordHint":"Confirm New Password",
      "resetBtnText":"Submit",


      ///Scann ePass Keys
      "scanPassBtnText":"Scan Pass",
      "changePassBtnText":"Change Password",
      "logOutBtnText":"Logout",
      "scanAppBar":"Scan",
      "scanBtn":"Validate",
      "or":"Or",
      "codeNo":"Enter Barcode No.",
      "invalidPass":"Invalid e-Pass ",
      "alreadyVisited": "Devotee has already visited",
      "Yes":"Yes",
      "No":"No",

      ///Reports Keys
      "reportsAppBarTitle":"Reports",
      "selectType":"Select Type",
      "generateBtnText":"Generate",
      "fromDate":"From Date",
      "fromDatee":"From\nDate :",
      "toDate":"To Date",
      "toDatee":"To\nDate :",

      ///MapView Page Keys
      "generateEPass" : "Generate e-Pass",
      "totalRefer" : "Total Refer",
      "totalDonation" : "Total Donation",
      "today'sQuota" : "Todays Quota",
      "ePass" : "e-Pass",
      "myQuota" : "My Quota",
      "totalCenterText":"Total",
      "passGenerated" : "Pass Generated",
      "expired" : "Expired",
      "visited" : "Visited",
      "linkGenerated" : "Link Generated",
      "devoteeReferred" : "Devotees Referred",
      "donationRec" : "Donation Received",
      "carryForward" : "Carry Forward Quota",
      "viewHistory" : "View History",
      "requestSearch" : "Name/Mobile No.",
      "selectReason" : "Select Reason",
      "viewAll" : "View All",
      "request" : "Request : ",
      "noDataFound" : "No Data Found!",
      "acceptRequest" : "Devotee request accepted successfully",
      "rejectRequest" : "Devotee request rejected successfully",
      "quotaHistory" : "Quota History",
      "viewCharts" : "View pie chart",
      "clear" : "Clear All",
      "oK" : "OK",
      "weekly" : "   Weekly   ",
      "toDateMessage" : "Please select from date!",
      "fromDateMessage" : "Please select to date!",
      "commentReason" : "Comment Reason",
      "rejectTitle" : "Are you sure you want to reject the request?",
      "pleaseComment" : "Please mention reason to reject",
      "accept" : "Accept",
      "acceptAll" : "Accept All",
      "reject" : "Reject",
      "acceptTitle" : "Are you sure you want to accept the request?",
      "alert" : "Alert",
      "selectAll" : "Select All ",
      "requestTitle" : "Requests",
      "selectSelectToast" : "Please select atleast one request",
      "progressIndicatorMsg" : "Please wait",
      "charts" : "Charts",
      "validStatus" : "Valid   ",
      "validStatusBar" : "Valid",
      "pendingStatus" : "Pending",
      "rejectedStatus" : "Rejected",
      "visitedStatus" : "Visited",
      "expiredStatus" : "Expired",
      "selectFromDate" : "Please select from date",
      "selectToDate" : "Please select to date",
      "delete" : "Delete",
      "notificationDelete" : "Notifications deleted Successfully.",
      "notificationClear" : "Notifications cleared Successfully.",
      "remark" : "Remark",
      "bookingHistoryRemark" : "Remark : ",
      "remarkReason" : "Please enter remark.",
      "validDate" : "Please enter valid date",
      "validMonth" : "Please enter valid month",
      "emptyQuotaToast" : "The quota is not assigned yet.",



      ///Map Design Drawer Keys
      "dashboard" : "Dashboard",
      "bookEPass" : "Book e-Pass",
      "bookingHistory" : "Booking History",
      "report" : "Report",
      "changePasswordDrawerText":"Change Password",

      ///Trustee Profile Keys
      "pAppBarTitleText":"Profile",
      "pMobileNo":"Mobile Number",
      "pDesignation":"Designation",
      "pEmailId":"Email ID",
      "doj":"Joining Date",
      "releaseDate":"Release Date",


      ///Devotee Pass Keys
      "dMobileNumberHint":"Enter Mobile No",
      "dOtpHint":"Enter OTP",
      "dSendOtpBtnText":"Send OTP",
      "dResendOtpBtnText":"Resend OTP",
      "dResendOtpIn":"Resend OTP in 00:",
      "dInSec":"sec.",
      "dVerifyBtnText":"Verify",
      "dInstruction":"Instructions:",

      ///Contact Us Keys
      "cAppBarTitle":"Contact Us",

      ///About Temple Keys
      "aboutTempleAppBarTitle":"About Temple",
      "aboutUs":"About",

      ///Forgot Password Keys
      "fFormTitle":"FORGOT PASSWORD",
      "fMobileNOHint":"Enter Mobile No.",
      "fSendOtpBtnText":"Send OTP",
      "fOtpHint":"Enter OTP",
      "fResendOtpBtnText":"Resend OTP",
      "fVerify":"Verify",
      "fSkip":"Skip",
      "otp":"OTP has been sent successfully",
      "emptyOTP":"Invalid OTP",
      "otpFieldEmpty":"OTP is required",


      ///New Password Keys
      "nPasswordTitle":"SET PASSWORD",
      "nNewPasswordHint":"Enter New Password",
      "nConfirmNewPassHint":"Confirm Password",
      "nResendOtpBtn":"Resend OTP",
      "nSubmitBtn":"Submit",
      "nSkip":"Skip",
      "emptyNewPassword":"New password is required",
      "emptyConfirmPassword":"Confirm password is required",
      "notMatching":"New password & confirm password are not matching, Please try again",
      "passwordMatching":"Password has been reset successfully",


      ///Booking History Keys
      "bookingAppBarTitle":"Booking History",
      "devotee":"Devotee e-Pass:",
      "linkExpired":"Link has been Expired",
      "devoteeCount":"Total Devotee\nCount",
      "close":"Close",
      "CopyLink":"Copy Link",
      "searchByNameMob":"Search by Name or Mobile",
      "selectTimee":"Select Time",
      "selectDatee":"Select Date",
      "selectStatus":"Select Status",
      "visitTimeSlot":"Visit Time Slot",
      "linkCopied":"Link Copied",
      "filter":"Filter",
      "searchText":"Search By e-Pass name/Booking ID/Transaction ID",
      "referredBy":"Referred By : ",

      ///Online Darshan ePass all Keys
      "dDarshanAppBarTitle":"Devotee Details",
      "dDevoteeLoginAppBarTitle":"Book Referral e-Pass",
      "dPaymentPreviewAppBarTitle":"Payment Preview",
      "dName":"Primary Devotee",
      "dEmailId":"Email ID",
      "dMobileNo":"Mobile Number",
      "dReferBy":"Reference",
      "ddReferBy":"Reference : ",
      "dNoOfDevotees":"Devotees",
      "dTotalAmount":"Total Amount",
      "darshanVisitDate":"Visit Date",
      "darshanVisitTime":"Visit Time",
      "dVisitDate":"Select Visit Date",
      "dTimeSlot":"Select Time Slot",
      "dNameFieldHint":"Enter Devotee Name",
      "dEmailFieldHint":"Enter Devotee Email",
      "dEnterMobilFieldHint":"Enter Devotee Mobile",
      "dGender":"Select Gender",
      "dMale":"Male",
      "dFemale":"Female",
      "dOther":"Other",
      "dDateOfBirth":"Select Devotee Date of Birth",
      "dAdharNo":"Enter Devotee Aadhaar Number",
      "dAddress":"Enter Devotee Address",
      "dUploadPhoto":"Upload Devotee Photo",
      "dAddBtn":"Add",
      "dNextBtn":"Save",
      "dPrevious":"Previous",
      "dFullNameHint":"Enter Full Name",
      "dMobileHint":"Enter Mobile No",
      "dDevotee":"Devotee",
      "dSessionExpired":"Session Expired!",
      "dUpdateBtn":"Update",
      "dClearBtn":"Clear",
      "dDeletePopupTitle":"Are you sure to remove the record ?",
      "dNoBtn":"NO",
      "dYesBtn":"YES",
      "dLimitEndText":"Limit End",
      "dCameraBtn":"Camera",
      "dGalleryBtn":"Gallery",
      "dDevoteeNotAdded":"Devotee not added you want to continue ?",
      "viewPhoto":"View Photo",
      "invalidEmailMsg":"Please enter valid email id!",
      "logoutPopup":"Do you want to exit?",
      "cancelBookingPopup":"Do you want to cancel booking ?",
      "uploadDocBtn":"Reference Letter / Id Card",
      "cancelBookingBtn":"Cancel Booking",
      "addPrimaryDevoteeDetail":"Please add the primary devotee details!",
      "filesBtn":"Files",
      "viewDocument":"View Document",
      "genderYears":"Years",
      "primaryLabel":"Primary Devotee",
      "secondaryLiable":"Devotee",
      "referenceInputHintText":"Enter Post/Designation/Relative/Reference",
      "photo":"Photo",
      "document":"Document",
      "captureImage":"Capture Photo",


      ///Table Header
      "tableSrNo":"Sr.No.",
      "tableAmount":"e-Pass",
      "tableTotalPass":"Devotee Count",
      "tableTotalAmount":"Amount",
      "tableTotal":"Total Amount (₹) : ",
      "tablePayNowBtn":"Pay Now",
      "tablePrevoisBtn":"previousBtn",


    ///Quota Table Header
      "sn":"SN",
      "date":"Date",
      "ePassHeader":"e-Pass",
      "quota":"Quota",
      "used":"Used",
      "carry":"Carry",


      ///VIP Pass Detail Page Keys
      "vipAppBarTitle":"e-Pass Details",
      "passTempleTitle":"Shri Tuljabhavani Mandir Sansthan",
      "passTempleSubtitle":"Tuljapur",
      "passSecondSubtitle":"DENAGI (DONATION) DARSHAN PASS",
      "vipPassMobile":"Mobile No",
      "vipPassMobileChange":"Mobile No.",
      "vipPassAdharChange":"Aadhaar No.",
      "vipPassReferChange":"Referred By",
      "vipPassGender":"Gender",
      "vipPassDob":"DOB",
      "vipPassAge":"Age",
      "vipPassAddress":"Address",
      "vipPassAdhar":"Adhar No",
      "vipPassRefer":"Refer By",
      "vipPassVisitDate":"Visit Date",
      "vipPassVisitTime":"Visit Time",
      "vipPassDonation":"Donation",
      "vipPassConfirmBtn":"Confirm",

      ///Notification page Keys
      "notificationAppBarTitle":"Notification",


      ///Note instruction info
      "note":"Note :",
      "yourPassText":" Your Password -",
      "lengthInfo":"Must be 8-42 characters long",
      "containNumberInfo":"Must contain at least one Number(0-9)",
      "upperCaseInfo":"Must contain at least one uppercase (A-Z)",
      "lowerCaseInfo":"and one lowercase (a-z) character",
      "mustContain":"Must contain at least one Special character",
      "characters":"(@,#,&, \$)",


      ///change password validation messages
      "passLength":"Your password must be between 8 to 42 characters",
      "passLowerCase":"Your password must contain at least 1 small character",
      "passUpperCase":"Your password must contain at least 1 capital character",
      "passNumber":"Your password must contain at least 1 number",
      "passSpecial":"Your password must contain at least 1 special character",


      ///All SnackBarValidation Msg

      ///Login SnackBar
      "emptyUserNameSnackBar":" Username is required",
      "emptyPasswordSnackBar":"Password is required",
      "emptyPasswordUserName":"Username & password are required",
      "numberValidator":"Please enter 10 digit mobile number",
      "invalidUserNameSnackBar":"Invalid username or password",
      "invalidMobileNumberfp":"Please enter valid mobile number",
      "numberisnotregister":"Mobile number is not registered",
      "invalidUserName":"Please enter valid username",
      "invalidPassword":"Please enter valid password",

      "loginSuccessSnackBar":"Login successfully",

      ///Change Password SnackBar
      "oldPasswordValidation":"New password must not be same as old password",
      "emptyCurrentPasswordSnackBar":"Please Enter Current Password!",
      "passwordNotSameSnackBar":"New password and confirm password does not match",
      "emptyNewPasswordSnackBar":"Please Enter New Password!",
      "oldNewShouldNotMatch":"Old password and new password should not be same",
      "invalidCurrentPasswordSnackBar":"Please Enter Valid Current Password",
      "successMsgSnackBar":"Password changed successfully",
      "invalidPatternOfPasswordSnackBar":"Password required at least 1 uppercase,1 number,1 special character and minimum 8 Characters...!'}",

      ///Devotee Pass SnackBar

      "dEmptyMobileSnackBar":"Please Enter Mobile No",
      "dInvalidationLengthMobile":"Please enter valid 10 digit mobile number.",
      "dEmptyOtpSnackBar":"Please Enter OTP",
      "dValidOtpSnackBar":"Invalid OTP",
      "dInvalidMobileSnackBar":"Please Enter Valid Mobile No",
      "dOtpLimitExceedSnackBar":"OTP sending limit exceeded for minute please try again later",


      ///Forgot Password SnackBar
      "otpVerification":"OTP verified successfully",
      "fInvalidOtpSnackBar":"Please enter valid OTP",

      ///New Password SnackBar
      "nPasswordNotMatchSnackBar":"Re-Entered password are not match",
      "nPasswordSuccessMsg":"Password Updated Successfully",


      ///profile Snackbar
      "updatedProfile":"Profile photo updated",

      ///Logout Keys
      "logoutAlert": "Do you want to logout?",
      "Logout": "Logout",
      "LogoutToast": "Logout successfully",



      ///Devotee Form Snackbar
      "dEmptyNameSnackBar":"Please Enter Devotee Name",
      "EmptyMobileSnackBar":"Please enter Devotee mobile",
      "inValidMobileNumber":"Please enter valid mobile",
      "dEmptyDateOfBirthSnackBar":"Please Select Devotee Date Of Birth!",
      "dEmptyAdharNoSnackBar":"Please Enter Devotee Aadhaar number",
      "dInvalidAdarNumSnackBar":"Please Enter valid Aadhaar number",
      "dInvalidAdharWithStartZeroSnackBar":"Please Enter valid Aadhaar number",
      "dInvalidAdharWithStartOneSnackBar":"Please Enter valid Aadhaar number",
      "dAadhaarAlreadyExistMsg":"Aadhaar number already exists",
      "dEmptyAddress":"Please Enter Address!",
      "dEmptyImageSnakBar":"Please upload devotee photo",
      "dRecordDeleteSnackBar":"Record deleted successfully.",
      "dRecordAddedSuccessSnackBar":"Devotee details added successfully",
      "dRecordUpdatedSuccessSnackBar":"Devotee details updated successfully",
      "dRecordLimitExceedSnackBar":"Record addition limit exceeded!",
      "dAgeLimitSnackBar":"e-Pass is applicable for the age more than 10 years",
      "dCancelBookingSuccessfully":"Your booking is cancelled successfully",
      "addAllDevoteeSnackBar":"Please add all devotees",
      "mobileAlreadyRegisteredMsg":"Mobile number is already registered.",
      "isQuotaAvailableMsg":"Sorry..!! Slots full for the selected reference, please select another date/reference by clicking on cancel booking.",
      "imageSizeMsg":"Image size should be less than 5 MB",
      "docSizeMsg":"Document size should be less than 10 MB",


  ///PassBooking View
      "passBooking": "Pass Booking",
      "devoteeName": "Devotee Name",
      "mobileNo": "Mobile No.",
      "emailId": "Email Id",
      "totalDevotee": "Total Devotees Visiting",
      "selectDate": "Select Visit Date",
      "selectTime": "Select Time Slot",
      "noDevotee": "No. of Devotees",
      "toastName": "Devotee name is required",
      "toastValidName": "Please enter valid name",
      "toastMobile": "Mobile no is required",
      "toastValidMobile": "Invalid mobile no.",
      "toastEmail": "Email id is required",
      "toastValidEmail": "Invalid email id",
      "toastValidVisitor": "Please enter valid count for total devotees",
      "toastVisitor": "Total devotees visiting count is required",
      "toastDate": "Please select visit date",
      "toastTime": "Please select time slot",
      "toastReference":"Please select reference",
      "toastSelectDevotee": "Please select devotee",
      "toastDevoteeVisiting": "Enter one or zero devotee visiting",
      "toastTotalDevotee": "Total devotees count and e-Pass count is not matching",
      "toastPassSuccess": "e-Pass reference has been created successfully",
      "toastRecordExist": "Record already exist with same mobile no.",
      "toastNoQuota": "Quota not available",
      "update": "Update",
      "protocol": "Protocol",
      "pleaseConfirm": "Please confirm..",
      "pleaseConfirmMsg": "Are you sure you want to go back",
      "pastTimeSlotSnackBarMsg":"Please select a valid time slot",
      "quotaNotAvailableMsg":"Special Darshan e-Pass Quota for selected Reference is exceeded",
      "noTimeSlotAvailableMsg":"No timeslots available for selected date, select another date.",
      "visitDatePassed":"Visit date has passed, please select a new date by canceling the booking.",

      ///Referral e-pass status page keys
      "repassAppBarTitle":"Referral e-Pass Status",
      "rName":"Name",
      "rTransactionId":"Transaction Id",
      "rMobile":"Mobile No",
      "rNoOfDevotee":"No. of Devotees",
      "rVisitDate":"Visit Date",
      "rTimeSlot":"Time Slot",
      "rStatusPending":"Pending",
      "rStatusPendingMsg":"Thank you for your patience.",
      'requestPending':"Pending",
      'referralStatusMsg':"Your request for e-Pass is pending,once approved by selected reference your e-Pass will be generated.",
      'refreshButton':"Check Status",
      'requestRejected':"Rejected",
      "expiredTitle":"Expired",
      'rejectReason':"Sorry for the inconvenience Your request has been rejected by the reference, the amount will be refunded within 72 to 96 working hours.",
      "expiredReason":"Sorry, your scheduled visit date has passed, so your e-pass is expired. Please book again",
      "viewPass":"View Pass",
      "reasonText":"Reason",
      "bookAgainBtn":"Book Again",
      "passGeneratedText":"Pass generated",
      "passGenDes":"Your pass has been generated, click on the View Pass button to view the pass.",

      ///language updated
      "changeLanguage": "Change Language",
      "selectLanguage": "Select Language",
      "OK":"OK",


      ///Validator
      "emptyBarcodeText":"Please scan or enter barcode number",
      "wrongVisiteDate":"Scheduled visit date is wrong, Please check and confirm",
      "cameraPermission":"Camera permission denied",
      "setting":"Setting",
      "storagePermission":"Storage permission denied",
      "hello": "Hello",
      "e-PassName":"e-Pass Name",
      "allow":"Allow",
      "deny":"Deny",
      "transactionID":"Transaction ID",
      "transactionDate":"Transaction Date",
      "toastPassConfirm":"Pass confirmed successfully",



      ///Payment preview keys
      "cancelPaymentMsg":"Are you sure you want to cancel payment?",
      "cancelPaymentTitle":"Cancel Payment",

      ///Payment Success Translation
      "paymentStatus": "Payment Status",
      "paymentSuccessful": "Payment Successful...!",
      "transactionId":"Transaction Id",
      "paymentRequestMsg":"Your request has been sent successfully, Once get approved by the selected reference your e-Pass will be generated.",
      "viewStatus":"Check e-Pass",
      "paymentAppBar":"Payment",
      "bookingId":"Booking ID",
      "bookingDate":"Booking Date",
      "bankRefNo":"Bank Ref No.",
      "amountInRupee":"Amount(₹)",
      "transactionDate":"Transaction Date",

      ///Payment Failure Translation
      "paymentFailed": "Payment Failed..!",
      "paymentFailedNote": "The payment was unsuccessful.Please try again later or use another payment method.",
      "tryagain":"Retry",


      "fullCapacity" : "Sorry..!! Capacity is full for the selected Timeslot, please select another Date/Timeslot by clicking on Cancel Booking!!\nDo you want to proceed?",
      "blockDay":"The selected day is blocked for e-Pass booking currently,please select another date by cancelling this booking?\nDo you want to proceed?"


    },

    ///Marathi.tr
    'mr_IN': {

      ///Quota Table Header
      "sn":"अ. क्रं.",
      "date":"दिनांक",
      "ePassHeader":"ई-पास",
      "quota":"कोटा",
      "used":"वापरले",
      "carry":"कॅरी",
      "help":"मदत",


      ///Registration keys
      "registration": "नोंदणी",
      "dateOfBirth": "जन्म तारीख",


      ///Non-Referral e-Pass
      "passName": "विशेष\nदेणगी\nई-पास",
      "passName1": "विशेष देणगी ई-पास",
      "selectPass": "ई-पास निवडा",
      "capacityExceedMsg": "निवडलेल्या पासची क्षमता ओलांडली आहे",
      "confirmation": "पुष्टीकरण",
      "confirmationMessage": "एकदा सबमिट केल्यानंतर तुम्ही सुधारणा करू शकत नाही, तुम्हाला पुढे जायचे आहे का?",
      "lessCapacityMsg": "प्रविष्ट केलेल्या भक्त संख्येपेक्षा क्षमता कमी आहे.",
      "myProfile":"माझे प्रोफाइल",
      "includingPrimary":" (प्राथमिक भक्तासहित)",
      "maxDevotee":"प्रति बुकिंग कमाल 6 भक्तांना परवानगी आहे.",
      "enterQuantity":"भक्तांची संख्या प्रविष्ट करा",
      "passAmount":"पासची रक्कम : ",
      "totalAvailable":"एकूण क्षमता : ",
      "totalBookingAmount":"एकूण रक्कम :      ",
      "timeSlotError":"या वेळेच्या स्लॉटमध्ये क्षमता उपलब्ध नाही",
      "selectEPass":"ई-पास निवडा",
      "enterVisitingError":"भेट देणाऱ्या भक्तांची संख्या प्रविष्ट करा",
      "enterDevoteeName":"कृपया भक्ताचे नाव प्रविष्ट करा",
      "toastPassBooked":"ई-पास आधीच बुक केलेला आहे, कृपया ई-पास डाउनलोड करण्यासाठी तुमच्या व्यवहार इतिहासाचे पुनरावलोकन करा. तुम्ही आधीच भेट दिली असल्यास, तुम्ही दुसऱ्या दिवशी पुन्हा ई-पास बुक करू शकता.",
      "exitApp":"तुम्हाला खात्री आहे की तुम्ही ॲपमधून बाहेर पडू इच्छिता",
      "doubleBack":"बाहेर पडण्यासाठी पुन्हा बॅक बटण दाबा",
      "deviName":"श्री तुळजाभवानी",
      "devoteeLogin":"भक्त लॉगिन",
      "validatorLogin":"व्हॅलिडेटर लॉगिन",
      "noTimeSlotAvailable":"टाइमस्लॉट उपलब्ध नाही",
      "anotherUserNo":"मोबाईल नंबर दुसऱ्या वापरकर्त्याकडे नोंदणीकृत आहे.",



      ///Devotee Details
      "devoteeDetail":"भक्त तपशील",
      "cancelBooking":"बुकिंग रद्द करा",
      "toastCancelBooking":"बुकिंग यशस्वीरित्या रद्द झाले.",
      "wentWrong":"काहीतरी चूक झाली",
      "cancelBookingMsg":"तुमची खात्री आहे की तुम्ही बुकिंग रद्द करू इच्छिता ?",
      "visitDate":"दर्शनाची तारीख :  ",
      "timeSlot":"टाइमस्लॉट :  ",
      "devoteeNo":"भक्तांची संख्या :  ",
      "amountTotal":"एकूण रक्कम :  ",
      "updateDetailToast":"तपशील यशस्वीरित्या अपडेट केले",
      "devoteeName":"भक्ताचे नाव",
      "hintDevoteeName":"भक्ताचे प्रविष्ट करा",
      "selectDOB":"जन्मतारीख निवडा",
      "selectGender":"लिंग निवडा",
      "aadhaarNo":"आधार क्र.",
      "enterAadhaarNo":"आधार क्रमांक प्रविष्ट करा",
      "uploadPhoto":"फोटो अपलोड करा",
      "clearDetails":"क्लिअर",
      "addDetails":"जोडा",
      "preview":"पूर्वावलोकन ",
      "primary":"प्राथमिक",
      "viewPhoto":"फोटो पहा",
      "male":"पुरुष",
      "female":"स्त्री",
      "profilePhoto":"प्रोफाइल फोटो",
      "detailsAddedToast":"प्रोफाइल फोटो",
      "limitEnd":"मर्यादा समाप्त",
      "detailsAdded":"तपशील यशस्वीरित्या जोडले",
      "uploadedImage":"अपलोड केलेली प्रतिमा",
      "pleaseSelectDate":"कृपया जन्मतारीख निवडा",
      "pleaseSelectGender":"कृपया तुमचे लिंग निवडा",
      "pleaseEnterAadhaar":"कृपया आधार क्रमांक प्रविष्ट करा",
      "pleaseEnterValidAadhaar":"कृपया वैध आधार क्रमांक प्रविष्ट करा",
      "pleaseUploadImage":"कृपया भक्त प्रतिमा अपलोड करा",
      "welcomeTo":"आपले स्वागत आहे",
      "register":"नोंदणी करा",
      "updateProfileImage":"कृपया तुमची प्रोफाइल इमेज अपडेट करा",
      "updateProfileTitle":"प्रोफाइल अपडेट करा",
      "aadhaarNumber":"आधार क्रमांक",
      "devoteeLoginTitle":"भक्त लॉगिन",
      "updateInfo":"अद्यतन",
      "otpSentSuccess":"ओटीपी यशस्वीरित्या पाठवला.",
      "tenYearsLimit":"10 वर्षांपेक्षा जास्त वय असलेल्यांसाठी भक्त नोंदणी लागू आहे.",
      "devoteeRegistered":"भक्तांनी यशस्वीपणे नोंदणी केली.",
      "validatorName":"व्हॅलीडेटरचे नाव",
      "passScanDate":"पास स्कॅन दिनांक व वेळ",


      ///Payment Details Page
      "paymentPreview":"पेमेंट पूर्वावलोकन",
      "primaryDevotee":"प्राथमिक भक्त",
      "mobileNo":"मोबाईल क्र.",
      "paymentVisitDate":"दर्शनाची तारीख",
      "paymentVisitTime":"दर्शनाची वेळ",
      "paymentDevotees":"भक्तांची संख्या",
      "paymentSrNo":"अनु.क्र",
      "paymentEPass":"ई-पास",
      "paymentQty":"संख्या",
      "paymentAmount":"रक्कम",
      "paymentTotalAmount":"एकूण रक्कम",
      "paymentProceed":"पेमेंट करण्यासाठी पुढे जा",
      "selectPayment":"पेमेंट पद्धत निवडा",
      "selectPaymentNote":"तुम्ही VISA/master/maestro कार्ड (बँकेद्वारे जारी केलेले) आणि नेट बँकिंग/UPI द्वारे पेमेंट करू शकता.",
      "paymentGateway":"एसबीआय बँक पेमेंट गेटवे",
      "makePayment":"पेमेंट करा",
      "toastSelectPayment":"कृपया पेमेंट गेटवे निवडा",
      "paymentSuccess":"तुमचा ई-पास यशस्वीरित्या जनरेट झाला आहे.",
      "downloadPass":"ई-पास डाउनलोड करा",
      "timeOut":"वेळ संपला",




    ///Transaction History
      "transactionHistory" : "व्यवहार इतिहास",
      "transactionEPassView" : "ई-पास",


      ///choose language Keys
      "english": "इंग्रजी",
      "marathi": "मराठी",
      "chooseLanguage": "भाषा निवडा",
      "continue":"पुढे चला",
      "OK":"ठीक",


      ///language updated
      "changeLanguage": "भाषा बदला",
      "selectLanguage": "भाषा निवडा",


      ///HomePage Drawer Keys
      "templeTitle": "श्री तुळजाभवानी\nमंदिर संस्थान",
      "profile": "प्रोफाइल",
      "aboutTemple": "मंदिरा विषयी",
      "languageSetting": "सेटिंग",
      "templeName":"श्री. तुळजाभवानी मंदिर, तुळजापूर",
      "shareBtn":"शेअर",
      "templeTitlenew": "श्री तुळजाभवानी\n  मंदिर संस्थान",
      "songName":" सर्व मंगल मांगल्ये शिवे सर्वार्थ साधिके।\nशरण्ये त्र्यम्बके गौरी नारायणी नमोस्तुते।।",



      ///HomePage Keys
      "templeTitleMap": "श्री तुळजाभवानी मंदिर संस्थान",
      "templeHomeTitle": "मुख्यपृष्ठ",
      "templeSubtitle": "तुळजापूर",
      "darshanText": "ऑनलाईन दर्शन",
      "donationText": "ऑनलाईन देणगी",
      "srikhand": "सिंहासन पूजा",
      "Abhishek": "अभिषेक पूजा",
      "freeDarshan": "मोफत दर्शन पास",
      "denagiDarshan": "देणगी दर्शन पास",
      "ePassMessage": "श्री तुळजाभवानी माता दर्शनासाठी ऑनलाईन शिफारस",
      "ePassMessage1": "ई-पास बुक करण्यासाठी येथे क्लिक करा",
      "bookPass": "बुक पास",
      "bookReferralPass":"बुक\nरेफरल\nई-पास",
      "pleaseEnterOtp":"कृपया ओटीपी प्रविष्ट करा",



      ///Bottom NavigationBar Keys
      "home": "मुख्यपृष्ठ",
      "login": "लॉगिन",
      "devoteePass": "बुक पास",
      "contact": "संपर्क",

      ///Login Page Keys
      "loginTitle": "व्हॅलिडेटर लॉगिन",
      "trusteeText": "ट्रस्टी",
      "validator": "व्हॅलिडेटर",
      "userNameHint": "युजर नेम",
      "passwordHint": "पासवर्ड",
      "forgotPassword": "पासवर्ड विसरलात ?",
      "loginBtnText": "लॉगिन",
      "skip": "वगळा",
      "back":"बॅक",


      ///Pass Booking Keys
      "passBookingAppBarTitle":"पास बुकिंग",
      "devoteeNameHint":"भक्ताचे नाव",
      "mobileNoHint":"मोबाइल नंबर",
      "emailIdHint":"ईमेल आयडी",
      "totalDevotees":"भेट देणारे एकूण भाविक",
      "numOfDevoteeHint":"भक्तांची संख्या",
      "submit":"पुढे जा",
      "cancel":"रद्द करा",
      "totalAmount":"एकूण रक्कम",
      "referenceHint":"रेफरन्स निवडा",
      "ePassValidation":"च्या एका बुकिंगसाठी कमाल 6 भक्तांना परवानगी आहे",
      "note":"टीप: ",
      "passBookingNote":"१० वर्षांखालील बाल भक्तांसाठी ई-पास आवश्यक नाही.",
      "canNotModifyMsg":"सबमिट केल्यानंतर तुम्ही बदल करू शकत नाही तुम्हाला पुढे जायचे आहे का?",
      "beforeProceedingMsg":"पुढे जाण्यापूर्वी कृपया कॉल करा आणि प्रमाणीकरणासाठी आवश्यक तपशील प्रदान करा",
      "allocatePassNote":"दर्शन देणाऱ्या एकूण भक्तांसाठी ई-पासची विभागणी करा",
      "allListControllerEmptyMsg":"भक्तांची संख्या आवश्यक आहे",


      ///Change Password Keys
      "changePasswordAppBarTitle":"पासवर्ड बदला",
      "currentPasswordHint":"वर्तमान पासवर्ड",
      "newPasswordHint":"नवीन पासवर्ड",
      "confirmNewPasswordHint":"कन्फर्म पासवर्ड",
      "resetBtnText":"सबमिट",

      ///Scann ePass Keys
      "scanPassBtnText":"स्कॅन पास",
      "changePassBtnText":"पासवर्ड बदला",
      "logOutBtnText":"लॉगआउट",
      "scanAppBar":"स्कॅन",
      "scanBtn":"प्रमाणित करा",
      "or":"किंवा",
      "codeNo":"बारकोड नंबर प्रविष्ट करा",
      "invalidPass":"अवैध ई-पास ",
      "alreadyVisited": "भक्ताने आधीच भेट दिली आहे",
      "Yes":"होय",
      "No":"नाही",


      ///Reports Keys
      "reportsAppBarTitle":"अहवाल",
      "selectType":"प्रकार निवडा",
      "generateBtnText":"जनरेट",
      "fromDate":"तारखेपासून",
      "fromDatee":"\nतारखेपासून",
      "toDate":"तारखेपर्यंत",
      "toDatee":"तारखेपर्यंत",


      ///MapView Page Keys
      "generateEPass" : "ई-पास तयार करा",
      "totalRefer" : "एकूण रेफरल",
      "totalDonation" : "एकूण देणगी",
      "today'sQuota" : "आजचा कोटा",
      "ePass" : "ई-पास",
      "myQuota" : "माझा कोटा",
      "totalCenterText":"एकूण",
      "passGenerated" : "पास व्युत्पन्न",
      "expired" : "कालबाह्य",
      "visited" : "भेट दिली",
      "linkGenerated" : "लिंक व्युत्पन्न",
      "devoteeReferred" : "एकूण शिफारस",
      "donationRec" : "प्राप्त देणगी",
      "carryForward" : "कॅरी फॉरवर्ड कोटा",
      "viewHistory" : "हिस्टरी",
      "requestSearch" : "नाव/मोबाईल नं.",
      "selectReason" : "कारण निवडा",
      "viewAll" : "सर्व विनंत्या पहा",
      "request" : "विनंती : ",
      "noDataFound" : "माहिती आढळली नाही!",
      "acceptRequest" : "भक्तांची विनंती यशस्वीरीत्या स्वीकारली",
      "rejectRequest" : "भक्ताची विनंती यशस्वीरित्या नाकारली",
      "quotaHistory" : "कोटा हिस्टरी",
      "viewCharts" : "चार्ट पहा",
      "clear" : "क्लिअर ऑल",
      "oK" : "ठीक आहे",
      "weekly" : "    साप्ताहिक    ",
      "toDateMessage" : "कृपया तुम्हाला पाहिजे तिथून तारीख निवडा!",
      "fromDateMessage" : "कृपया तुम्हाला पाहिजे तिथपर्यंत तारीख निवडा!",
      "commentReason" : "कृपया कारण नमूद करा",
      "rejectTitle" : "तुमची खात्री आहे की तुम्ही विनंती नाकारू इच्छिता?",
      "pleaseComment" : "कृपया नाकारण्याचे कारण नमूद करा",
      "acceptAll" : "अक्सेप्ट ऑल",
      "accept" : "अक्सेप्ट",
      "reject" : "रीजेक्ट",
      "acceptTitle" : "तुम्ही विनंती स्वीकारू इच्छिता ?",
      "alert" : "अलर्ट",
      "selectAll" : "सर्व निवडा ",
      "requestTitle" : "विनंती",
      "selectSelectToast" : "कृपया किमान एक विनंती निवडा",
      "progressIndicatorMsg" : "कृपया थांबा",
      "charts" : "चार्ट्स",
      "validStatus" : "वैध       ",
      "validStatusBar" : "वैध",
      "pendingStatus" : "प्रलंबित",
      "rejectedStatus" : "नाकारले",
      "visitedStatus" : "भेट दिली",
      "expiredStatus" : "कालबाह्य",
      "selectFromDate" : "कृपया प्रारंभिक तारीख निवडा",
      "selectToDate" : "कृपया समाप्ती तारीख निवडा",
      "delete" : "डिलीट",
      "notificationDelete" : "नोटीफिकेशन यशस्वीरित्या हटवले गेले आहे.",
      "notificationClear" : "नोटीफिकेशन यशस्वीरित्या हटवले गेले आहे.",
      "remark" : "शेरा",
      "bookingHistoryRemark" : "शेरा : ",
      "remarkReason" : "कृपया टिप्पणी प्रविष्ट करा.",
      "validDate" : "कृपया वैध तारीख प्रविष्ट करा",
      "validMonth" : "कृपया वैध महिना प्रविष्ट करा",
      "emptyQuotaToast" : "कोटा अद्याप नियुक्त केलेला नाही.",


      ///Map Design Drawer Keys
      "dashboard" : "डॅशबोर्ड",
      "bookEPass" : "ई-पास बुक करा",
      "bookingHistory" : "बुकिंग हिस्टरी",
      "report" : "अहवाल",
      "changePasswordDrawerText":"पासवर्ड बदला",

      ///Trustee Profile Keys
      "pAppBarTitleText":"प्रोफाइल",
      "pMobileNo":"मोबाईल नंबर",
      "pDesignation":"पदनाम",
      "pEmailId":"ईमेल आयडी",
      "doj":"रुजू होण्याची तारीख",
      "releaseDate":"रिलीज डेट",

      ///Devotee Pass Keys
      "dMobileNumberHint":"मोबाईल नंबर प्रविष्ट करा",
      "dOtpHint":"कृपया ओटीपी प्रविष्ट करा",
      "dSendOtpBtnText":"ओटीपी पाठवा",
      "dResendOtpBtnText":"ओटीपी पुन्हा पाठवा",
      "dResendOtpIn":"ओटीपी पुन्हा पाठवा 00:",
      "dInSec":"सेकंद.",
      "dVerifyBtnText":"ओटीपी सत्यापित करा",
      "dInstruction":"सूचना:",

      ///Contact Us Keys
      "cAppBarTitle":"आमच्याशी संपर्क साधा",

      ///About Temple Keys
      "aboutTempleAppBarTitle":"मंदिराविषयी",
      "aboutUs":"मंदिराविषयी",

      ///Forgot Password Keys
      "fFormTitle":"पासवर्ड विसरलात",
      "fMobileNOHint":"मोबाईल नंबर प्रविष्ट करा",
      "fSendOtpBtnText":"ओटीपी पाठवा",
      "fOtpHint":"ओटीपी प्रविष्ट करा",
      "fResendOtpBtnText":"ओटीपी पुन्हा पाठवा",
      "fVerify":"ओटीपी सत्यापित करा",
      "fSkip":"वगळा",
      "otp":"ओटीपी यशस्वीरित्या पाठवला गेला आहे",
      "emptyOTP":"अवैध ओटीपी",
      "otpFieldEmpty":"ओटीपी आवश्यक आहे",
      ///Logout Keys
      "logoutAlert": "तुम्हाला लॉगआऊट करायचे आहे का?",
      "LogoutToast": "यशस्वीपणे लॉगआउट केले.",



      ///New Password Keys
      "nPasswordTitle":"पासवर्ड सेट करा",
      "nNewPasswordHint":"नवीन पासवर्ड प्रविष्ट करा",
      "nConfirmNewPassHint":"पासवर्डची पुष्टी करा",
      "nResendOtpBtn":"ओटीपी पुन्हा पाठवा",
      "nSubmitBtn":"जतन करा",
      "nSkip":"वगळा",
      "emptyNewPassword":"नवीन पासवर्ड आवश्यक आहे",
      "emptyConfirmPassword":"कृपया कन्फर्म पासवर्डची पुष्टी करा",
      "notMatching":"नवीन पासवर्ड आणि कन्फर्म पासवर्ड जुळत नाही.",
      "passwordMatching":"पासवर्ड यशस्वीरित्या रीसेट केला गेला आहे",



      ///Booking History Keys
      "bookingAppBarTitle":"बुकिंग इतिहास",
      "devotee":"भक्त ई-पास:",
      "linkExpired":"लिंक कालबाह्य झाली आहे",
      "devoteeCount":"एकूण भक्तांची\nसंख्या",
      "close":"बंद",
      "CopyLink":"कॉपी लिंक",
      "searchByNameMob":"नाव किंवा मोबाईल द्वारे शोधा",
      "selectTimee":"वेळ निवडा",
      "selectDatee":"तारीख निवडा",
      "selectStatus":"स्थिती निवडा",
      "visitTimeSlot":"भेट देण्याची वेळ",
      "linkCopied":"लिंक कॉपी केली",
      "searchText":"ई-पास नाव/बुकिंग आयडी/ट्रान्झॅक्शन आयडी द्वारे शोधा",
      "referredBy":"यांच्या संदर्भाने : ",
      "filter":"फिल्टर",

      ///Online Darshan ePass all Keys
      "dDarshanAppBarTitle":"भक्त तपशील",
      "dDevoteeLoginAppBarTitle":"बुक रेफरल ई-पास",
      "dPaymentPreviewAppBarTitle":"पेमेंट प्रीव्यू",
      "dName":"प्राथमिक भक्त",
      "dEmailId":"ईमेल आयडी",
      "dMobileNo":"मोबाइल क्रमांक",
      "dReferBy":"रेफरन्स",
      "ddReferBy":"रेफरन्स : ",
      "dNoOfDevotees":"भक्तगण",
      "dTotalAmount":"एकूण रक्कम",
      "darshanVisitDate":"दर्शन दिनांक",
      "darshanVisitTime":"दर्शनाची वेळ",
      "dVisitDate":"भेट देण्याची तारीख निवडा",
      "dTimeSlot":"वेळ स्लॉट निवडा",
      "dNameFieldHint":"भक्ताचे नाव प्रविष्ट करा",
      "dEmailFieldHint":"भक्ताचा ईमेल आयडी प्रविष्ट करा",
      "dEnterMobilFieldHint":"भक्ताचा मोबाइल प्रविष्ट करा",
      "dGender":"लिंग निवडा",
      "dMale":"पुरुष",
      "dFemale":"महिला",
      "dOther":"इतर",
      "dDateOfBirth":"भक्ताची जन्मतारीख निवडा",
      "dAdharNo":"भक्ताचा आधार क्रमांक प्रविष्ट करा",
      "dAddress":"पत्ता प्रविष्ट करा",
      "dUploadPhoto":"भक्ताचा फोटो अपलोड करा",
      "dAddBtn":"जोडा",
      "dNextBtn":"जतन करा",
      "dPrevious":"मागे या",
      "dDevotee":"भक्त",
      "dFullNameHint":"पूर्ण नाव प्रविष्ट करा",
      "dMobileHint":"मोबाइल प्रविष्ट करा",
      "dSessionExpired":"सत्राची मुदत संपली!",
      "dUpdateBtn":"अपडेट",
      "dClearBtn":"रद्द करा",
      "dDeletePopupTitle":"तुम्हाला रेकॉर्ड हटवायचा आहे का?",
      "dNoBtn":"नाही",
      "dYesBtn":"होय",
      "dLimitEndText":"मर्यादा समाप्त",
      "dCameraBtn":"कॅमेरा",
      "dGalleryBtn":"गॅलरी",
      "dDevoteeNotAdded":"भक्त जोडले नाही आपण सुरू ठेवू इच्छिता ?",
      "viewPhoto":"फोटो पहा",
      "invalidEmailMsg":"कृपया वैध ईमेल आयडी प्रविष्ट करा!",
      "logoutPopup":"आपण बाहेर पडू इच्छिता?",
      "cancelBookingPopup":"तुम्ही बुकिंग रद्द करू इच्छिता?",
      "uploadDocBtn":"रेफरन्स पत्र / ओळखपत्र",
      "cancelBookingBtn":"बुकिंग रद्द करा",
      "addPrimaryDevoteeDetail":"कृपया प्राथमिक भक्त तपशील जोडा!",
      "filesBtn":"फाइल्स",
      "viewDocument":"दस्तऐवज पहा",
      "genderYears":"वर्षे",
      "primaryLabel":"प्राथमिक भक्त",
      "secondaryLiable":"भक्त",
      "referenceInputHintText":"पोस्ट/पदनाम/नातेवाईक/रेफरन्स प्रविष्ट करा",
      "photo":"फोटो",
      "document":"दस्तऐवज",
      "captureImage":"फोटो कॅप्चर करा",




      ///Table Header
      "tableSrNo":"अनुक्रमांक",
      "tableAmount":"ई-पास",
      "tableTotalPass":"भक्तांची संख्या",
      "tableTotalAmount":"रक्कम",
      "tableTotal":"एकूण रक्कम (₹) : ",
      "tablePayNowBtn":"पेमेंट करा",


      ///VIP Pass Detail Page Keys
      "vipAppBarTitle":"ई-पास तपशील",
      "passTempleTitle":"श्री. तुळजाभवानी मंदिर संस्थान",
      "passTempleSubtitle":"तुळजापूर",
      "passSecondSubtitle":"देनगी (दान) दर्शन पास",
      "vipPassMobile":"मोबाईल क्र",
      "vipPassGender":"लिंग",
      "vipPassDob":"जन्मतारीख",
      "vipPassAge":"वय",
      "vipPassAddress":"पत्ता",
      "vipPassAdhar":"आधार क्र",
      "vipPassRefer":"रेफरल बाय",
      "vipPassVisitDate":"दर्शनाची दिनांक",
      "vipPassVisitTime":"दर्शनाची वेळ",
      "vipPassDonation":"देणगी",
      "vipPassConfirmBtn":"पुष्टी करा",
      "vipPassMobileChange":"मोबाईल क्र.",
      "vipPassAdharChange":"आधार क्र.",
      "vipPassReferChange":"रेफरल बाय",

      ///Notification page Keys
      "notificationAppBarTitle":"नोटिफिकेशन",



      ///Note instruction info
      "note":"टीप :",
      "yourPassText":" तुमचा पासवर्ड -",
      "lengthInfo":"8-42 वर्ण लांब असणे आवश्यक आहे",
      "containNumberInfo":"किमान एक संख्या (0-9) असणे आवश्यक आहे",
      "upperCaseInfo":"किमान एक अप्परकेस (A-Z) आणि एक लोवरकेस (a-z)",
      "lowerCaseInfo":"वर्ण असणे आवश्यक आहे",
      "mustContain":"किमान एक विशेष वर्ण (@,#,&, \$) असणे आवश्यक आहे",
      "characters":"",


      ///change password validation messages
      "passLength":"तुमचा पासवर्ड 8 ते 42 वर्णांच्या दरम्यान असावा",
      "passLowerCase":"तुमच्या पासवर्डमध्ये किमान 1 लहान वर्ण असणे आवश्यक आहे",
      "passUpperCase":"तुमच्या पासवर्डमध्ये कमीत कमी 1 कॅपिटल वर्ण असणे आवश्यक आहे",
      "passNumber":"तुमच्या पासवर्डमध्ये किमान 1 नंबर असणे आवश्यक आहे",
      "passSpecial":"तुमच्या पासवर्डमध्ये किमान 1 विशेष वर्ण असणे आवश्यक आहे",





      ///All SnackBarValidation Msg
      ///Login SnackBar
      "emptyUserNameSnackBar":"वापरकर्ता आवश्यक आहे",
      "emptyPasswordSnackBar":"पासवर्ड आवश्यक आहे",
      "emptyPasswordUserName":"वापरकर्ता नाव व पासवर्ड आवश्यक आहे",
      "numberValidator":"कृपया 10 अंकी मोबाईल नंबर टाका",
      "invalidUserNameSnackBar":"वापरकर्त्याचे नाव अथवा पासवर्ड चुकीचा ",
      "invalidMobileNumberfp":"कृपया वैध मोबाइल क्रमांक प्रविष्ट करा",
      "numberisnotregister":"मोबाइल क्रमांक नोंदणीकृत नाही",
      "invalidUserName":"कृपया वैध वापरकर्तानाव प्रविष्ट करा",
      "invalidPassword":"कृपया वैध पासवर्ड प्रविष्ट करा",


      "loginSuccessSnackBar":"लॉगिन यशस्वी",

      ///Change Password SnackBar
      "oldPasswordValidation":"नवीन पासवर्ड आणि जुना पासवर्ड सारखा नसावा",
      "emptyCurrentPasswordSnackBar":"कृपया वर्तमान पासवर्ड प्रविष्ट करा!",
      "passwordNotSameSnackBar":"नवीन पासवर्ड आणि कन्फर्म पासवर्ड जुळत नाही",
      "emptyNewPasswordSnackBar":"कृपया नवीन पासवर्ड प्रविष्ट करा!",
      "oldNewShouldNotMatch":"जुना पासवर्ड आणि नवीन पासवर्ड एकसारखे नसावेत",
      "invalidCurrentPasswordSnackBar":"कृपया वैध वर्तमान पासवर्ड प्रविष्ट करा!",
      "successMsgSnackBar":"पासवर्ड यशस्वीरित्या बदलला...",
      "invalidPatternOfPasswordSnackBar":"पासवर्ड किमान 1 अप्परकेस आवश्यक आहे 1 संख्या, 1 विशेष वर्ण आणि किमान 8 वर्ण...!'}",


      ///Devotee Pass SnackBar
      "dEmptyMobileSnackBar":"कृपया मोबाईल क्रमांक प्रविष्ट करा",
      "dInvalidationLengthMobile":"कृपया वैध 10 अंकी मोबाइल नंबर प्रविष्ट करा.",
      "dEmptyOtpSnackBar":"कृपया ओटीपी प्रविष्ट करा",
      "dValidOtpSnackBar":"अवैध ओटीपी",
      "dInvalidMobileSnackBar":"कृपया वैध मोबाईल क्रमांक प्रविष्ट करा",
      "dOtpLimitExceedSnackBar":"ओटीपी पाठवण्याची मर्यादा ओलांडली आहे ,एका मिनिटानंतर नंतर पुन्हा प्रयत्न करा",


      ///Forgot Password SnackBar
      "otpVerification":"ओटीपी यशस्वीरित्या सत्यापित झाला",
      "fInvalidOtpSnackBar":"कृपया वैध ओटीपी प्रविष्ट करा",


      ///New Password SnackBar
      "nPasswordNotMatchSnackBar":"पुन्हा प्रविष्ट केलेला पासवर्ड जुळत नाही",
      "nPasswordSuccessMsg":"पासवर्ड यशस्वीरित्या अपडेट केला",

      ///profile Snackbar
      "updatedProfile":"प्रोफाइल फोटो अपडेट",


      ///Devotee Form Snackbar
      "dEmptyNameSnackBar":"कृपया भक्ताचे नाव प्रविष्ट करा",
      "EmptyMobileSnackBar":"कृपया भक्ताचा मोबाईल प्रविष्ट करा",
      "inValidMobileNumber":"कृपया वैध मोबाइल प्रविष्ट करा",
      "dEmptyDateOfBirthSnackBar":"कृपया भक्ताची जन्म तारीख निवडा!",
      "dEmptyAdharNoSnackBar":"कृपया भक्ताचा आधार क्रमांक प्रविष्ट करा!",
      "dInvalidAdarNumSnackBar":"कृपया वैध आधार क्रमांक प्रविष्ट करा",
      "dInvalidAdharWithStartZeroSnackBar":"कृपया वैध आधार क्रमांक प्रविष्ट करा",
      "dInvalidAdharWithStartOneSnackBar":"कृपया वैध आधार क्रमांक प्रविष्ट करा",
      "dAadhaarAlreadyExistMsg":"आधार क्रमांक दुसर्‍या भक्तासाठी नोंदला आहे",
      "dEmptyAddress":"कृपया पत्ता प्रविष्ट करा!",
      "dEmptyImageSnakBar":"कृपया भक्ताचा फोटो अपलोड करा",
      "dRecordDeleteSnackBar":"रेकॉर्ड यशस्वीरित्या हटवले.",
      "dRecordAddedSuccessSnackBar":"भक्त तपशील यशस्वीरित्या जोडले गेले आहेत",
      "dRecordUpdatedSuccessSnackBar":"भक्त तपशील यशस्वीरित्या अद्ययावत केले गेले आहेत",
      "dRecordLimitExceedSnackBar":"रेकॉर्ड जोडण्याची मर्यादा ओलांडली!",
      "dAgeLimitSnackBar":"ई-पास 10 वर्षांपेक्षा जास्त वयासाठी लागू आहे",
      "dCancelBookingSuccessfully":"तुमचे बुकिंग यशस्वीरित्या रद्द झाले आहे",
      "addAllDevoteeSnackBar":"कृपया सर्व भक्तांचे तपशील जोडा",
      "mobileAlreadyRegisteredMsg":"मोबाईल क्रमांक आधीच नोंदणीकृत आहे.",
      "isQuotaAvailableMsg":"माफ करा..!! निवडलेल्या रेफरन्ससाठी स्लॉट भरले आहेत, कृपया बुकिंग रद्द करा वर क्लिक करून दुसरी तारीख/रेफरन्स निवडा.",
      "imageSizeMsg":"फोटोचा आकार ५ MB पेक्षा कमी असावा",
      "docSizeMsg":"दस्तऐवजाचा आकार १० MB पेक्षा कमी असावा",


      ///PassBooking View
      "passBooking": "पास बुकिंग",
      "devoteeName": "भक्ताचे नाव",
      "mobileNo": "मोबाईल क्र.",
      "emailId": "ई - मेल आयडी",
      "totalDevotee": "दर्शनाला येणारे एकूण भक्त",
      "selectDate": "दर्शनाची तारीख निवडा",
      "selectTime": "टाइम स्लॉट निवडा",
      "noDevotee": "भक्तांची संख्या",
      "toastName": "भक्ताचे नाव आवश्यक आहे",
      "toastValidName": "कृपया वैध नाव प्रविष्ट करा",
      "toastMobile": "मोबाईल नंबर आवश्यक आहे",
      "toastValidMobile": "अवैध मोबाईल नंबर",
      "toastEmail": "ईमेल आवश्यक आहे",
      "toastValidEmail": "अवैध ईमेल",
      "toastValidVisitor": "कृपया एकूण भक्तांसाठी वैध संख्या प्रविष्ट करा",
      "toastVisitor": "दर्शनाला येणार्‍या एकूण भक्तांची संख्या आवश्यक आहे",
      "toastDate": "कृपया दर्शनाची तारीख निवड",
      "toastTime": "कृपया टाइम स्लॉट निवडा",
      "toastReference":"कृपया रेफरन्स निवडा",
      "toastSelectDevotee": "कृपया टाइम स्लॉट निवडा",
      "toastDevoteeVisiting": "एक किंवा शून्य भक्त व्हिजिटिंग प्रविष्ट करा",
      "toastTotalDevotee": "एकूण भक्तांची संख्या आणि ई-पास संख्या जुळत नाही",
      "toastPassSuccess": "ई-पास रेफरन्स यशस्वीरित्या तयार करण्यात आला आहे",
      "toastRecordExist": "त्याच मोबाईल क्रमांकासह रेकॉर्ड आधीपासूनच अस्तित्वात आहे.",
      "toastNoQuota": "कोटा उपलब्ध नाही",
      "update": "अपडेट करा",
      "protocol": "प्रोटोकॉल",
      "pleaseConfirm": "कृपया निश्चित करा..",
      "pleaseConfirmMsg": "तुम्हाला नक्की परत जायचे आहे",
      "pastTimeSlotSnackBarMsg":"कृपया वैध टाइम स्लॉट निवडा",
      "quotaNotAvailableMsg":"निवडलेल्या रेफरन्ससाठी विशेष दर्शन ई-पास कोटा ओलांडला आहे",
      "noTimeSlotAvailableMsg":"निवडलेल्या तारखेसाठी टाइमस्लॉट उपलब्ध नाहीत, दुसरी तारीख निवडा.",
      "visitDatePassed":"दर्शनाची तारीख निघून गेली आहे, कृपया बुकिंग रद्द करून नवीन तारीख निवडा.",


      ///Referral e-pass status page keys
      "repassAppBarTitle":"रेफरल ई-पास स्थिती",
      "rName":"नाव",
      "rTransactionId":"व्यवहार आयडी",
      "rMobile":"मोबाईल क्र",
      "rNoOfDevotee":"भक्तांची संख्या",
      "rVisitDate":"दर्शनाची तारीख",
      "rTimeSlot":"टाइम स्लॉट",
      "rStatusPending":"प्रलंबित",
      "rStatusPendingMsg":"प्रतिक्षेबद्दल धन्यवाद.",
      'requestPending':"प्रलंबित",
      'referralStatusMsg':"तुमची ई-पासची विनंती प्रलंबित आहे, निवडलेल्या रेफरन्सने मंजूर केल्यावर तुमचा ई-पास तयार केला जाईल.",
      'refreshButton':"स्थिती तपासा",
      'requestRejected':"नाकारले",
      "expiredTitle":"कालबाह्य",
      'rejectReason':"गैरसोयीबद्दल क्षमस्व, तुमची विनंती रेफरन्सद्वारे नाकारली गेली आहे, रक्कम 72 ते 96 कामकाजाच्या तासांमध्ये परत केली जाईल.",
      "expiredReason":"क्षमस्व, तुमची दर्शनाची नियोजित तारीख निघून गेली आहे त्यामुळे ई-पास कालबाह्य झाला आहे. कृपया पुन्हा पास बुक करा",
      "viewPass":"पास पहा",
      "reasonText":"कारण",
      "bookAgainBtn":"पुन्हा बुक करा",
      "passGeneratedText":"पास जनरेटेड",
      "passGenDes":"तुमचा पास जनरेट झालेला आहे, पास बघण्यासाठी \"पास पहा\" बटनावर क्लिक करा.",


      ///Validator
      "wrongVisiteDate":"दर्शनाची तारीख चुकीची आहे, कृपया तपासा आणि पुष्टी करा",
      "cameraPermission":"कॅमेरा परवानगी नाकारली",
      "setting":"सेटिंग",
      "storagePermission":"स्टोरेज परवानगी नाकारली",
      "hello": "नमस्कार",
      "e-PassName":"ई-पास नाव",
      "allow":"परवानगी द्या",
      "deny":"नकार द्या",
      "transactionID":"व्यवहार आयडी",
      "transactionDate":"व्यवहाराची तारीख",
      "toastPassConfirm":"पास यशस्वीरीत्या निश्चित झाला",


      ///Payment preview keys
      "cancelPaymentMsg":"तुम्हाला पेमेंट नक्की रद्द करायचे आहे का?",
      "cancelPaymentTitle":"पेमेंट रद्द करा",


      ///Payment Success Translation
      "paymentStatus": "पेमेंट स्टेटस",
      "paymentSuccessful": "पेमेंट यशस्वी...!",
      "transactionId":"ट्रान्सआकशन आयडी",
      "paymentRequestMsg":"तुमची विनंती यशस्वीरीत्या पाठवण्यात आली आहे, निवडलेल्या रेफरन्सद्वारे मंजूर झाल्यानंतर तुमचा ई-पास तयार केला जाईल.",
      "viewStatus":"ई-पास तपासा",
      "paymentAppBar":"पेमेंट",
      "bookingId":"बुकिंग आयडी",
      "bookingDate":"बुकिंग तारीख",
      "bankRefNo":"बँक संदर्भ क्र.",
      "amountInRupee":"रक्कम (₹)",
      "transactionDate":"व्यवहाराची तारीख",
      "serverError":"पेमेंट सर्व्हर डाउन आहे कृपया काही वेळाने प्रयत्न करा",

      ///Payment Failure Translation
      "paymentFailed": "पेमेंट अयशस्वी..!",
      "paymentFailedNote": "पेमेंट अयशस्वी झाले. कृपया नंतर पुन्हा प्रयत्न करा किंवा दुसरी पेमेंट पद्धत वापरा.",
      "tryagain":"पुन्हा प्रयत्न करा",
      "emptyBarcodeText":"कृपया बारकोड स्कॅन करा किंवा बारकोड नंबर प्रविष्ट करा.",
      "fullCapacity" : "माफ करा..!! निवडलेल्या टाइमस्लॉटसाठी क्षमता पूर्ण आहे, कृपया बुकिंग रद्द करा वर क्लिक करून दुसरा तारीख/टाइमस्लॉट निवडा!!\nतुम्हाला पुढे जायचे आहे का?",
      "blockDay":"निवडलेला दिवस सध्या ई-पास बुकिंगसाठी ब्लॉक केला आहे, कृपया हे बुकिंग रद्द करून दुसरी तारीख निवडा?\nतुम्हाला पुढे जायचे आहे का?"
    }
  };
}
