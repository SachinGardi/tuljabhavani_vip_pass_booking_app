import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../modal/spl_donation_epass_modal/spl_donation_epass_payable_deatils_modal/spl_epass_payable_details_modal.dart';
import '../../../repository/spl_donation_epass_repo/spl_epass_payable_details_repo/spl_epass_payable_details_repo.dart';

class SplePassPayableDetailsVM extends GetxController{
  List<SplePassPayableDetailsModal> devoteePaymentDetailsList = [];
  var isLoading = true.obs;
  String? devoteeName;
  String? mobileNo;
  String? visitDate;
  String? visitTime;
  String? noOfDevotees;
  String? totalAmount;
  String? ePassName;
  String? passAmount;
  getDevoteePaymentDetailVm(int devoteeId)async{
    var data = await SplePassPayableDetailsRepo.getDevoteePayableDetail(devoteeId);
    print("data:$data");
    if(data != null){
      devoteePaymentDetailsList = data;
      isLoading.value = false;
    }
    devoteePaymentDetailsList.forEach((element) {
      devoteeName = element.devoteeName;
      mobileNo = element.mobileNo;
      visitDate = DateFormat("dd-MM-yyyy").format(DateTime.parse(element.visitDate.toString()));
      visitTime = element.visitTime;
      noOfDevotees = element.noOfDevotees.toString();
      totalAmount = element.total!.toStringAsFixed(0);

      element.totalPayMentDetails?.forEach((element) {
        ePassName = element.ePassName;
        passAmount = element.amount!.toStringAsFixed(0);
      });



    });

  }


}