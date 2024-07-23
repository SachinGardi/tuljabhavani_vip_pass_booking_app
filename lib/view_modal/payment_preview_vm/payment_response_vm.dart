import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../internet_service/snackbar.dart';
import '../../modal/paymentResponseModal.dart';
import '../../repository/payment_preview_repo/paymentResponseRepo.dart';


class PaymentResponseVM extends GetxController {

  String? paymentStatus;
  String? transactionStatus;
  String? transactionDate;
  String? bookingId;
  double? amount;
  List<PaymentResponseModal> paymentDetails = [];
  var isLoading = true.obs;

  getPaymentDetails(String id) async {
    var getData = await PaymentResponseRepo.
    getPaymentResponseData(id);
     print("getData$getData");
    if (getData != null) {
      paymentDetails = PaymentResponseRepo.paymentDetailsList;
      isLoading.value = false;
    }
    else if (getData == null) {
      Timer(const Duration(seconds: 1), () {
        isLoading.value = false;
        internetToastMessage();
      });
    }
    paymentDetails.forEach((element) {
      transactionStatus = element.transactionId;
      bookingId = element.merchantOrderNumber;
      amount =element.amount;
      print("Hello");
      print(element.transactionDate!);
      DateTime date = DateFormat('MM/dd/yyyy h:mm:ss a').parse(element.transactionDate!);
      transactionDate = DateFormat('dd-MM-yyyy').format(date);
      paymentStatus = element.transactionStatus;


      print(transactionDate);
    });

  }
}
