// ignore_for_file: avoid_unnecessary_containers, must_be_immutable, unused_import, file_names

// public button we can used by call in any screen
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
        required this.color,
        required this.textColor,
        required this.text,
        required this.width,
        required this.height,
        required this.onTap});

  String? text;
  Color? color;
  Color? textColor;
  double? height;
  double? width;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        child: Text(
          text!,
          style: TextStyle(
              color: textColor,
              fontFamily: 'Cairo',
              fontSize: 13.sp,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
