import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tulajapur/internet_service/snackbar.dart';



class GetXNetworkManager extends GetxController
{
  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  int connectionType = 0;

  //Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();

  //Stream to keep listening to network change state
  late StreamSubscription streamSubscription ;

  @override
  void onInit() {
    super.onInit();
    GetConnectionType();
    streamSubscription = _connectivity.onConnectivityChanged.listen(updateState);
  }
  Future<void>GetConnectionType() async{
    var connectivityResult;
    try{
      connectivityResult = await (_connectivity.checkConnectivity());
    }on PlatformException catch(e){
      print(e);
    }
    return updateState(connectivityResult);
  }

  updateState(ConnectivityResult result)
  {
    switch(result)
    {
      case ConnectivityResult.wifi:
        connectionType = 1;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType = 2;
        update();
        break;
      case ConnectivityResult.none:
        {
          connectionType = 0;
          internetToastMessage();

        }
        update();
        break;
      default: Get.snackbar('Network Error', 'Failed to get Network Status');
      break;

    }
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
   streamSubscription.cancel();
  }
}