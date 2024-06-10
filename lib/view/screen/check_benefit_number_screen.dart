import 'package:book_bridge_exchange_point/controllers/donation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../constans/color.dart';
import '../widget/custom_button.dart';
import '../widget/custom_menu.dart';
import '../widget/custom_text_form_field.dart';
import 'list_of_booking_screen.dart';
import 'list_of_donation_screen.dart';

class CheckBenefitNumberScreen extends StatefulWidget {
  const CheckBenefitNumberScreen({super.key});

  @override
  State<CheckBenefitNumberScreen> createState() => _CheckBenefitNumberScreenState();
}

class _CheckBenefitNumberScreenState extends State<CheckBenefitNumberScreen> {
  final DonationController donationController = Get.put(DonationController());

  bool _isLoading = false;
  TextEditingController phoneNumberController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Directionality(
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
                title: Text(
                  "ببحث عن حجز",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: textColor),
                ),
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 30).w,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                              key: key,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 10).h,
                                    child: SizedBox(
                                      width: 300.w,
                                      child: Text(
                                        "رقم الجوال للمستفيد",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.headline1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomTextFormField(
                                    controller: phoneNumberController,
                                    validater: (value) {
                                      if (value!.isEmpty) {
                                        return 'ارجاء إدخال رقم الجوال';
                                      }
                                      // Phone number validation using regular expression
                                      bool validPhoneNumber =
                                      RegExp(r'^(73|78|77|70|71)\d{7}$')
                                          .hasMatch(value);
                                      if (!validPhoneNumber) {
                                        return 'ارجاء إدخال رقم جوال صحيح';
                                      }
                                      return null;
                                    },
                                    hint: "رقم الهاتف",
                                    suffixIcon: IconlyBroken.call,
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 40.h,
                          ),
                          CustomButton(
                            text: "تحقق",
                            color: primary,
                            textColor: form,
                            width: double.infinity,
                            height: 60.h,
                            onTap: () {
                              if (key.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                donationController
                                    .getWaitedReservationsByPhoneNumber(
                                    phoneNumberController.text)
                                    .then((_) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  var waitedReservations = donationController.waitedReservations.toList();
                                  Get.to(() => ListOfBookingInPointScreen(
                                    waitedReservations: waitedReservations,
                                  ));

                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isLoading) _buildLoadingOverlay(),
                ],
              )),
        ),
      ],
    );
  }
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
