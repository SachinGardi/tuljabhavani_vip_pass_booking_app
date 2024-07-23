import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:another_flushbar/flushbar.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> toastMessage(
        BuildContext context, String message,
        {color = Colors.black}) =>
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(left:MediaQuery.of(context).size.width/7,
          right: MediaQuery.of(context).size.width/7,
          bottom: MediaQuery.of(context).size.height/40),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          duration: Duration(milliseconds:message.length <20?2000:2500),
          content: Center(
            child: Text(
        message,
        style:  TextStyle(
               fontFamily: "OpenSans",
              fontSize: MediaQuery.of(context).size.height/55,
              color: Colors.white),
      ),
          ),
      backgroundColor: Colors.black,
    ));


ScaffoldFeatureController<SnackBar, SnackBarClosedReason> validatorToastMessage(
    BuildContext context, String message,
    {color = Colors.black}) =>
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(left:MediaQuery.of(context).size.width/7,
              right: MediaQuery.of(context).size.width/7,
              bottom: MediaQuery.of(context).size.height/40),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          duration:const Duration(seconds:2),
          content: Center(
            child: Text(
              message,
              style:  TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: MediaQuery.of(context).size.height/55,
                  color: Colors.white),
            ),
          ),
          backgroundColor: Colors.black,
        ));


ScaffoldFeatureController<SnackBar, SnackBarClosedReason> permissionToaster(
    BuildContext context,
   ) =>
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: Row(
            children: [
              const Text("Ask Permission"),
              const Spacer(),
              IconButton(onPressed: (){
                openAppSettings();
              },icon: const Icon(Icons.settings))
            ],
          ),
        ));




Flushbar<void>? _currentFlushbar;

Flushbar<void> paymentSnackBar(BuildContext context, String message,
    {Color color = Colors.black}) {
  _currentFlushbar?.dismiss();
  _currentFlushbar = Flushbar<void>(
    duration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 100),

    flushbarStyle: FlushbarStyle.FLOATING,
    messageText: Text(
      message,
      style:
           TextStyle(
              fontFamily: "OpenSans",
              fontSize: MediaQuery.of(context).size.height/55,
              color: Colors.white),

      textAlign: TextAlign.center,
    ),
    margin: EdgeInsets.only(
      left: MediaQuery.of(context).size.width /15,
      right: MediaQuery.of(context).size.width /15,
      bottom: MediaQuery.of(context).size.height /20,
    ),
    borderRadius: BorderRadius.circular(30),
    backgroundColor: Colors.black

  )..show(context);

  return _currentFlushbar!;
}