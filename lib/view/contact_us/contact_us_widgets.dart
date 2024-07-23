import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


Widget information(BuildContext context ,IconData icon,String text)=>
    Padding(
        padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/18,right: MediaQuery.of(context).size.width/60),
        child:
        ListTile(
          titleAlignment: ListTileTitleAlignment.top,

          minVerticalPadding: MediaQuery.of(context).size.height/90,
          contentPadding: EdgeInsets.zero,
          leading: Container(
            margin: const EdgeInsets.only(top: 4),
            height: MediaQuery.of(context).size.height/30,
              width: MediaQuery.of(context).size.width/13,
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(7),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    offset: const Offset(0, 0),
                    blurRadius: 3,
                    blurStyle: BlurStyle.outer,


                  )
                ]
            ),
              child: Icon(icon,color: const Color(0xFFED6A1F),size:MediaQuery.of(context).size.height/42,)),
          title:Text(text,
            style: TextStyle(fontSize: MediaQuery.of(context).size.height/65,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.7)),),
        ),
      );
/// Email widget
Widget emailInformation(BuildContext context ,IconData icon,String email1,String email2)=>
    Padding(
      padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/18,right: MediaQuery.of(context).size.width/60),
      child:
      ListTile(
        titleAlignment: ListTileTitleAlignment.top,

        minVerticalPadding: MediaQuery.of(context).size.height/90,
        contentPadding: EdgeInsets.zero,
        leading: Container(
            margin: const EdgeInsets.only(top: 4),

            height: MediaQuery.of(context).size.height/30,
            width: MediaQuery.of(context).size.width/13,
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(7),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    offset: const Offset(0, 0),
                    blurRadius: 3,
                    blurStyle: BlurStyle.outer,


                  )
                ]
            ),
            child: Icon(icon,color: const Color(0xFFED6A1F),size:MediaQuery.of(context).size.height/42,)),
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                launch('mailto:$email1?');
              },
              child: Text(email1,
                style: TextStyle(fontSize: MediaQuery.of(context).size.height/65,
                  color: Colors.blue,)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/170,),
            GestureDetector(
              onTap: (){
                launch('mailto:$email2?');
              },
              child: Text(email2,
                style: TextStyle(fontSize: MediaQuery.of(context).size.height/65,

                    color: Colors.blue),),
            ),
          ],
        ),
      ),
    );

Widget clickableInformation(BuildContext context ,IconData icon,String text)=>
    Padding(
      padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/18,right: MediaQuery.of(context).size.width/60),
      child:
      ListTile(
        titleAlignment: ListTileTitleAlignment.top,

        minVerticalPadding: MediaQuery.of(context).size.height/90,
        contentPadding: EdgeInsets.zero,
        leading: Container(
            margin: const EdgeInsets.only(top: 4),

            height: MediaQuery.of(context).size.height/30,
            width: MediaQuery.of(context).size.width/13,
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(7),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    offset: const Offset(0, 0),
                    blurRadius: 3,
                    blurStyle: BlurStyle.outer,


                  )
                ]
            ),
            child: Icon(icon,color: const Color(0xFFED6A1F),size:MediaQuery.of(context).size.height/42,)),
        title: RichText(
          text: TextSpan(
            children: _buildTextSpans(text),

          ),
        ),
      ),
    );
List<TextSpan> _buildTextSpans(String text) {
  final List<TextSpan> textSpans = [];
  final RegExp urlRegExp = RegExp(r'(https?://\S+)');

  text.splitMapJoin(
    urlRegExp,
    onMatch: (Match match) {
      final String? url = match.group(0);
      textSpans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (await canLaunch(url!)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
        ),
      );
      return '';
    },
    onNonMatch: (String text) {
      textSpans.add(
        TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      );
      return '';
    },
  );

  return textSpans;
}
Widget callInformation(BuildContext context ,IconData icon,String contactPerson)=>
    Padding(
      padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/18,right: MediaQuery.of(context).size.width/60),
      child:
      ListTile(
        titleAlignment: ListTileTitleAlignment.top,

        minVerticalPadding: MediaQuery.of(context).size.height/90,
        contentPadding: EdgeInsets.zero,
        leading: Container(
            margin: const EdgeInsets.only(top: 4),

            height: MediaQuery.of(context).size.height/30,
            width: MediaQuery.of(context).size.width/13,
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(7),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    offset: const Offset(0, 0),
                    blurRadius: 3,
                    blurStyle: BlurStyle.outer,


                  )
                ]
            ),
            child: Icon(icon,color: const Color(0xFFED6A1F),size:MediaQuery.of(context).size.height/42,)),
        title:

        RichText(

          text: TextSpan(
            style: TextStyle(fontSize: MediaQuery.of(context).size.height/65,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.7)),
            children: buildPhoneSpans(contactPerson,context),

          ),
        ),
      ),
    );
List<TextSpan> buildPhoneSpans(String text,BuildContext context) {
  final List<TextSpan> textSpans = [];
  final RegExp urlRegExp = RegExp(r'\b\d{3}[-.\s]?\d{3}[-.\s]?\d{4}\b');
  text.splitMapJoin(
    urlRegExp,
    onMatch: (Match match) {
      final String? url = match.group(0);
      textSpans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
            color: Colors.blue,

          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              launch('tel:+91$url');
            },
        ),
      );
      return '';
    },
    onNonMatch: (String text) {
      textSpans.add(
        TextSpan(
          text: text,
            style: TextStyle(fontSize: MediaQuery.of(context).size.height/65,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.7)),
        ),
      );
      return '';
    },
  );

  return textSpans;
}



