import 'package:flutter/material.dart';

Widget commonButton(BuildContext context,String name)=>
    Center(
        child:Padding(
          padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/100 ),
          child: Container(
           height: MediaQuery.of(context).size.height/21,
            width:  MediaQuery.of(context).size.width/1.9,
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
            child: Center(child: Text(name,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height/55,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w600,
                color: const Color(0xFFF5FEFD)),)),
          ),
        )
    );

Widget dashBlinkButton(BuildContext context,String name)=>
    Center(
        child:Padding(
          padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/100),
          child: Container(
            height: MediaQuery.of(context).size.height/30,
            width:  MediaQuery.of(context).size.width/2.5,
            decoration:  BoxDecoration(
                gradient:  const LinearGradient(
                    colors: [Color(0xFFFEB349),Color(0xFFFEB349), Color(0xFFE74E0E)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                borderRadius: BorderRadius.circular(24)),
            child: Center(child: Text(name,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height/55,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFF5FEFD)),)),
          ),
        )
    );