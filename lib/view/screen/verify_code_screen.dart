// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';

import '../../constans/color.dart';
import '../widget/custom_button.dart';
import '../widget/custom_menu.dart';
import '../widget/verify_code.dart';
import 'done_screen.dart';


class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
          child: Scaffold(
              drawer: const CustomMenu(),
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  systemNavigationBarColor: form, // <-- SEE HERE
                ),
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
                title: Text(
                  "حجوزات",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: textColor),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //         const ListOfDonationInPointScreen()));
                      },
                      icon: const Icon(
                        IconlyBroken.arrow_left_2,
                        color: primary,
                        size: 29,
                      )),
                ],
              ),
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(children: [
                        Image.asset(
                          "assets/Img/virifyCode.png",
                          width: 300.w,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.8, bottom: 30, left: 0.8, right: 0.8),
                          child: Text(
                            "ادخل رمز التحقق",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: textColor),
                          ),
                        ),
                        CustomVerifyCode(),
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomButton(
                          text: "تأكيد",
                          color: primary,
                          textColor: form,
                          width: double.infinity,
                          height: 60.h,
                          onTap: () {
                            setState(() {
                              _isLoading = true;
                            });
                            Future.delayed(const Duration(seconds: 2));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DoneScreen()));
                            setState(() {
                              _isLoading = true;
                            });
                          },
                        ),
                      ]),
                    ),
                  ),
                  if (_isLoading) _buildLoadingOverlay(),
                ],
              ))),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: const Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
