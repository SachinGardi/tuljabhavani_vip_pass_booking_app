import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  bool fill = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 19,
      width: MediaQuery.of(context).size.width / 9,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(1, 1), // Adjust the offset
            ),
          ],
        ),
      child: TextField(
        style: TextStyle(
            color: Colors.black,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height / 50),
        //autofocus: autoFocus,
        textAlign: TextAlign.center,
        inputFormatters: [
        FilteringTextInputFormatter.allow(
                   RegExp(r'[0-9]')),
        ],
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Colors.black,
        cursorWidth: 1,

        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 1),
          filled: true,
          focusColor: Colors.black,
          fillColor: const Color(0xFFF2F2F2),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          counterText: '',
          hintStyle: const TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
            fill = true;
          }
          if (value.isEmpty ) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
