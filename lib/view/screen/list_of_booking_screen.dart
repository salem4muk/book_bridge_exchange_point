import 'package:book_bridge_exchange_point/controllers/donation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:material_dialogs/dialogs.dart';

import '../../constans/color.dart';
import '../../helper/loading_overlay_helper.dart';
import '../../models/waited_reservation.dart';
import '../widget/custom_button.dart';
import '../widget/custom_menu.dart';
import '../widget/custom_reservation_list_view_item_of_beneift.dart';
import '../widget/custom_text_form_field.dart';

class ListOfBookingInPointScreen extends StatefulWidget {
  final List<dynamic> waitedReservations;

  const ListOfBookingInPointScreen({Key? key, required this.waitedReservations})
      : super(key: key);

  @override
  State<ListOfBookingInPointScreen> createState() =>
      _ListOfBookingInPointScreenState();
}

class _ListOfBookingInPointScreenState
    extends State<ListOfBookingInPointScreen> {
  final DonationController donationController = Get.put(DonationController());
  TextEditingController codeController = TextEditingController();
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
                "الحجوزات",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: textColor),
              ),
            ),
            body: widget.waitedReservations.isEmpty
                ? const Center(child: Text('لا توجد حجوزات متاحة'))
                : ListView.builder(
                    itemCount: widget.waitedReservations.length,
                    itemBuilder: (context, index) {
                      final reservation = widget.waitedReservations[index];
                      return CustomReservationListViewItemOfBenefit(
                          level: reservation.level,
                          semester: reservation.semester,
                          date: reservation.createdAt,
                          id: reservation.id,
                          onTapConfirm: () {
                            setState(() {
                              Dialogs.materialDialog(
                                msg: 'هل تريد تأكيد أستلام التبرع؟',
                                title: 'أستلام تبرع',
                                context: context,
                                actions: [
                                  CustomButton(
                                      color: form,
                                      textColor: primary,
                                      text: "إلغاء",
                                      width: 150.w,
                                      height: 40.h,
                                      onTap: () {
                                        Navigator.of(context).pop(false);
                                      }),
                                  CustomButton(
                                      color: primary,
                                      textColor: form,
                                      text: "تأكيد",
                                      width: 150.w,
                                      height: 40.h,
                                      onTap: () {
                                        Navigator.of(context).pop(false);
                                        setState(() {
                                          Dialogs.materialDialog(
                                            msg:
                                                'لتاكيد الحجز يرجى ادخال كود الخاص بالحجز',
                                            title: 'كود الحجز',
                                            context: context,
                                            actions: [
                                              Stack(
                                                children: [
                                                  Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: Form(
                                                      key: key,
                                                      child: Column(
                                                        children: [
                                                          CustomTextFormField(
                                                            controller:
                                                                codeController,
                                                            validater: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'يرجى إدخال كود الحجز';
                                                              }
                                                              bool validCode =
                                                                  RegExp(r'^(123456789)\d{7}$')
                                                                      .hasMatch(
                                                                          value);
                                                              if (!validCode) {
                                                                return 'يرجى إدخال كود حجز صحيح';
                                                              }
                                                              return null;
                                                            },
                                                            hint: "كود الحجز",
                                                            suffixIcon: Icons
                                                                .numbers_sharp,
                                                          ),
                                                          SizedBox(
                                                              height: 15.h),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              CustomButton(
                                                                  color: form,
                                                                  textColor:
                                                                      primary,
                                                                  text: "إلغاء",
                                                                  width: 100.w,
                                                                  height: 40.h,
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false);
                                                                  }),
                                                              CustomButton(
                                                                  color:
                                                                      primary,
                                                                  textColor:
                                                                      form,
                                                                  text: "تأكيد",
                                                                  width: 100.w,
                                                                  height: 40.h,
                                                                  onTap: () {
                                                                    if (key
                                                                        .currentState!
                                                                        .validate()) {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              false);
                                                                      donationController.confirmDelivery(
                                                                          reservation
                                                                              .bookDonationsId
                                                                              .toString(),
                                                                          codeController
                                                                              .text);
                                                                    }
                                                                  })
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                      }),
                                ],
                              );
                            });
                          },
                          onTapReject: () {
                            setState(() {
                              Dialogs.materialDialog(
                                msg: 'هل تريد تأكيد رفض أستلام الحجز؟',
                                title: 'رفض حجز',
                                context: context,
                                actions: [
                                  CustomButton(
                                      color: form,
                                      textColor: primary,
                                      text: "إلغاء",
                                      width: 150.w,
                                      height: 40.h,
                                      onTap: () {
                                        Navigator.of(context).pop(false);
                                      }),
                                  CustomButton(
                                      color: primary,
                                      textColor: form,
                                      text: "تأكيد",
                                      width: 150.w,
                                      height: 40.h,
                                      onTap: () {
                                        Navigator.of(context).pop(false);
                                        donationController
                                            .rejectFromBeneficiary(
                                                reservation.bookDonationsId);
                                      }),
                                ],
                              );
                            });
                          });
                    },
                  ),
          ),
        ),
        Obx(() {
          if (donationController.isLoadingDelete.value) {
            return const LoadingOverlayHelper();
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
