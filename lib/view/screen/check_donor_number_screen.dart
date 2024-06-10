// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../constans/color.dart';
import '../../controllers/donation_controller.dart';
import '../widget/custom_button.dart';
import '../widget/custom_menu.dart';
import '../widget/custom_text_form_field.dart';
import 'list_of_booking_screen.dart';
import 'list_of_donation_screen.dart';

class CheckDonorNumberScreen extends StatefulWidget {
  const CheckDonorNumberScreen({super.key});

  @override
  State<CheckDonorNumberScreen> createState() => _CheckDonorNumberScreenState();
}

class _CheckDonorNumberScreenState extends State<CheckDonorNumberScreen> {
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
                  ),
                );
              }),
              centerTitle: true,
              title: Text(
                "ببحث عن تبرع",
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30)
                        .w,
                    child: Column(
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
                                    "رقم الجوال للمتبرع",
                                    textAlign: TextAlign.center,
                                    style:
                                    Theme.of(context).textTheme.headline1,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              CustomTextFormField(
                                controller: phoneNumberController,
                                validater: (value) {
                                  if (value!.isEmpty) {
                                    return 'يرجى إدخال رقم الجوال';
                                  }
                                  bool validPhoneNumber =
                                  RegExp(r'^(73|78|77|70|71)\d{7}$')
                                      .hasMatch(value);
                                  if (!validPhoneNumber) {
                                    return 'يرجى إدخال رقم جوال صحيح';
                                  }
                                  return null;
                                },
                                hint: "رقم الهاتف",
                                suffixIcon: IconlyBroken.call,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.h),
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
                              donationController.waitedDonations.clear();
                              donationController
                                  .getWaitedDonationsByPhoneNumber(
                                  phoneNumberController.text)
                                  .then((_) {
                                setState(() {
                                  _isLoading = false;
                                });
                                var waitedDonations = donationController.waitedDonations.toList();
                                if(waitedDonations.isNotEmpty) {
                                  Get.to(() =>
                                      ListOfDonationInPointScreen(
                                        waitedDonations: waitedDonations,
                                      ));
                                }
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
            ),
          ),
        ),
      ],
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
