import 'package:flutter/material.dart';

Widget profileDetail(BuildContext context,
    String key, String value,Color valueColor
    ) => Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/15,
          right: MediaQuery.of(context).size.width/15),

      child: SizedBox(
        height: MediaQuery.of(context).size.height /27,
        width: MediaQuery.of(context).size.width/2.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  key,
                  style:  TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: MediaQuery.of(context).size.height/60,
                      color: Colors.black),
                ),
               const Spacer(),

                 Text(
                  ':    ',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width /28,fontWeight: FontWeight.bold),
                ),

              ],
            )

          ],
        ),
      ),
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w800,
                fontSize: MediaQuery.of(context).size.height/65,
                color: Colors.black),
            maxLines: 2,
            softWrap: true,
          ),
        ],
      ),
    ),
  ],
);



