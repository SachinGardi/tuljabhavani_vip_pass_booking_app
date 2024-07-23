import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../repository/payment_preview_repo/payment_devotee_info.dart';

String? paymentResponse;

class DevoteePaymentInfoVM extends GetxController {
  var isLoading = true.obs;
  String? statusCode;
  String? statusMessage;

  paymentInfoVM(
    BuildContext context,
    String? devoteeId,
    String? amount,
    DateTime? date,
    String? timeSlot,
    String? ePassId,
    String? passAmount,
  ) async {
    await DevoteePaymentInfo.postPaymentData(
      "0",
      "0",
      DateTime.now(),
      DateTime.now(),
      false,
      devoteeId,
      amount,
      date,
      timeSlot,
      ePassId,
      passAmount,
      context,
    );

    paymentResponse = DevoteePaymentInfo.paymentResponse;
    statusCode = DevoteePaymentInfo.statusCode;
    statusMessage= DevoteePaymentInfo.statusMessage;
    print("paymentResponse$paymentResponse");
  }
}
