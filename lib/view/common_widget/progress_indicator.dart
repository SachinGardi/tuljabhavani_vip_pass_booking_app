import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget progressIndicator() => Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
        height: 100,
        width: 100,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              ),
              Text(
                "progressIndicatorMsg".tr,
                style: const TextStyle(color: Colors.white, fontSize:10, decoration: TextDecoration.none),
              ),
            ]),
      ),
    );
