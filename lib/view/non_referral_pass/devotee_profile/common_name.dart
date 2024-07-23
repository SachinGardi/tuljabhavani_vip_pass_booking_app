import 'package:flutter/material.dart';

Widget commonName(String name, int amount,Color color,BuildContext context)=>
    Row(
      children: [
        Text(name,style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
          fontSize: MediaQuery.of(context).size.width/25
        )),
        Text("$amount",style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
            fontSize: MediaQuery.of(context).size.width/25
        ))
      ],
    );

Widget commonRichText(String name,String subName,BuildContext context) =>
    Padding(
      padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/90),
      child: RichText(
        text: TextSpan(
            text: name,
            style:TextStyle(
                color: const Color(0xFF3B3B3B),
                fontFamily: "NotoSans",
                fontSize: MediaQuery.of(context).size.height/56,
                fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(text: ' *',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    color: Colors.red, fontSize: MediaQuery.of(context).size.width/30),
              ),
              TextSpan(text: subName,
                style: TextStyle(
                    fontFamily: 'OpenSans', fontSize: MediaQuery.of(context).size.width/40),
              ),
            ]
        ),
      ),
    );



Widget commonGreenText(String name,int value,Color color,BuildContext context) =>
    RichText(
      text: TextSpan(
          text: name,
          style: TextStyle(
              color: Colors.black, fontSize: MediaQuery.of(context).size.width/28),
          children: <TextSpan>[
            TextSpan(text: '$value',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color, fontSize: MediaQuery.of(context).size.width/28),
            )
          ]
      ),
    );


Widget commonLogoText(String name,String logo,int value,Color color,BuildContext context) =>
    RichText(
      text: TextSpan(
          text: name,
          style: TextStyle(
              color: Colors.black, fontSize: MediaQuery.of(context).size.width/28),
          children: <TextSpan>[
            TextSpan(text: logo,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color, fontSize: MediaQuery.of(context).size.width/28),
            ),
            TextSpan(text: '$value',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color, fontSize: MediaQuery.of(context).size.width/28),
            )
          ]
      ),
    );


Widget commonTransactionText(String name,String value,BuildContext context) =>
    RichText(
      text: TextSpan(
          text: name,
          style: TextStyle(
              fontFamily: "OpenSans",
              color: const Color(0xffF17A28),
              fontWeight: FontWeight.w700,
              fontSize: MediaQuery.of(context).size.height/56),
          children: <TextSpan>[
            TextSpan(text: value,
              style: TextStyle(
                fontFamily: "OpenSans",
                  color: const Color(0xff22AD00),
                  fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.height/56),
            )
          ]
      ),
    );