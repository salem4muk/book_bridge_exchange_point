import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:material_dialogs/dialogs.dart';

import '../../constans/color.dart';
import '../../controllers/donation_controller.dart';
import '../../helper/loading_overlay_helper.dart';
import '../../models/waited_donation.dart';
import '../widget/custom_button.dart';
import '../widget/custom_menu.dart';
import '../widget/custom_reservation_list_view_item_of_donation.dart';

class ListOfDonationInPointScreen extends StatefulWidget {
  final List<dynamic> waitedDonations;

  const ListOfDonationInPointScreen({super.key, required this.waitedDonations});

  @override
  State<ListOfDonationInPointScreen> createState() =>
      _ListOfDonationInPointScreenState();
}

class _ListOfDonationInPointScreenState
    extends State<ListOfDonationInPointScreen> {
  final DonationController donationController = Get.put(DonationController());

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
                "التبرعات",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: textColor),
              ),
            ),
            body: widget.waitedDonations.isEmpty
                ? const Center(child: Text('لا توجد تبرعات متاحة'))
                : ListView.builder(
                    itemCount: widget.waitedDonations.length,
                    itemBuilder: (context, index) {
                      final donation = widget.waitedDonations[index];
                      return CustomReservationListViewItemOfDonation(
                        level: donation.level,
                        semester: donation.semester,
                        date: donation.createdAt,
                        id: donation.id,
                        donorName: donation.donorName,
                        onTapConfirm: () {
                          setState(() {
                            Dialogs.materialDialog(
                              msg: 'هل تريد تأكيد استلام التبرع؟',
                              title: 'تأكيد تبرع',
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
                                          .confirmReceptionOfWaitedDonations(donation.id);
                                    }),
                              ],
                            );
                          });
                        },
                        onTapReject: () {
                          setState(() {
                            Dialogs.materialDialog(
                              msg: 'هل تريد تأكيد رفض التبرع؟',
                              title: 'رفض تبرع',
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
                                          .rejectByExchangePoint(donation.id);
                                    }),
                              ],
                            );
                          });
                        },
                      );
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
