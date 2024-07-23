import 'package:flutter/material.dart';

Widget wordDifference(String prefixName,String suffixName,BuildContext context)=>Row(
  children: [
    Text(prefixName,
  style: TextStyle(
      fontFamily: "OpenSans",
      fontSize: MediaQuery.of(context).size.height/62,
      color: Colors.black87,
      fontWeight: FontWeight.w500)),
    Text(suffixName,
      style: TextStyle(
      // fontFamily: "OpenSans",
      fontSize: MediaQuery.of(context).size.height/62,
      fontWeight: FontWeight.w600)),
  ],
);

Widget wordVerticalDifference(String prefixName,String suffixName,BuildContext context)=>Column(
  children: [
    Text(prefixName,
    style: TextStyle(
        fontFamily: "OpenSans",
        fontSize: MediaQuery.of(context).size.height/62,
        color: Colors.black87,
        fontWeight: FontWeight.w500)),

    Text(suffixName, style: TextStyle(
        // fontFamily: "OpenSans",
        fontSize: MediaQuery.of(context).size.height/62,
        fontWeight: FontWeight.w600)),

  ],
);