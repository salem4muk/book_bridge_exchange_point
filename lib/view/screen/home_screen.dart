// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../constans/color.dart';
import '../widget/custom_button.dart';
import '../widget/custom_menu.dart';
import 'check_benefit_number_screen.dart';
import 'check_donor_number_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _sentences = [
    "لا بلد بعد فلسطين ولا عاصمة بعد القدس",
    "فلسطين قظية الشرفاء",
    "فلسطييييييييييييييييييييييين",
    "القددددددددددددددددددس",
  ];
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _sentences.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const CustomMenu(),
        appBar: AppBar(
          backgroundColor: form,
          // hide back button
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: mainText,
                  size: 25,
                ));
          }),
          centerTitle: true,
          title: Image(
            image: const AssetImage("assets/Img/logo.png"),
            width: 30.w,
          ),
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35.h,
                width: double.infinity,
                color: outline,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _sentences[_currentIndex],
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    CountryFlag.fromCountryCode(
                      'PS',
                      height: 20.h,
                      width: 25.w,
                      borderRadius: 4.r,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200.h,
              ),
              CustomButton(
                  color: primary,
                  textColor: Colors.white,
                  text: "أستلام التبرع",
                  width: 250.w,
                  height: 45.h,
                  onTap: () {
                    Get.to(() => const CheckDonorNumberScreen());
                  }),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                  color: primary,
                  textColor: Colors.white,
                  text: "تسليم حزمة الكتب",
                  width: 250.w,
                  height: 45.h,
                  onTap: () {
                    Get.to(() => const CheckBenefitNumberScreen());
                  }),
            ],
          ),
        ),)
      ,
    );
  }
}
