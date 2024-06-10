// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../constans/color.dart';

class CustomVerifyCode extends StatelessWidget {
  CustomVerifyCode({super.key,this.validator,this.controller});
  static String? value;
  String? Function(String?)? validator;
  TextEditingController? controller;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      color: outline,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      validator: validator,
      length: 5,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: primary),
        ),
        // obscureText: true,

      ),
      onCompleted:(value){
        CustomVerifyCode.value = value!;
      },
    );
  }
}
