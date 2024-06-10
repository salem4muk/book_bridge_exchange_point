import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constans/color.dart';

class AppTheme {
  static final appTheme = ThemeData(
       fontFamily: 'Cairo',
      primaryColor: primary,
      textTheme: TextTheme(
          // This font we will ues later 'H1'
          headline1: TextStyle(
            color: mainText,
            fontFamily: 'Cairo',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),

          // This font we will ues later 'H2'
          headline2: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),

          // This font we ues later 'H3'
          headline3: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),

          // This font we ues later 'P1'
          bodyText1: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),

          // This font we ues later 'P2'
          bodyText2: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),

          // This font we ues later 'S'
          subtitle1: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          )));
}
