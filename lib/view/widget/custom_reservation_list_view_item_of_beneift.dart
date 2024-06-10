// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:material_dialogs/dialogs.dart';

import '../../constans/color.dart';
import '../screen/done_screen.dart';
import '../screen/fail_screen.dart';
import '../screen/verify_code_screen.dart';
import 'custom_button.dart';

class CustomReservationListViewItemOfBenefit extends StatefulWidget {
  const CustomReservationListViewItemOfBenefit({
    super.key,
    required this.level,
    required this.semester,
    required this.date,
    required this.id, this.onTapConfirm, this.onTapReject,
  });

  final String? level, semester, date;
  final void Function()? onTapConfirm;
  final void Function()? onTapReject;
  final int id;

  @override
  State<CustomReservationListViewItemOfBenefit> createState() =>
      _CustomReservationListViewItemOfBenefitState();
}

class _CustomReservationListViewItemOfBenefitState
    extends State<CustomReservationListViewItemOfBenefit> {
  static bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Container(
              height: 140.h,
              width: 700.w,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: lineColor,
                    // specify your desired color
                    width: 1.0.w, // specify the width of the border
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(widget.level!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: textColor)),
                          const Text(" /"),
                          Text(widget.semester!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: textColor)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            IconlyBroken.calendar,
                            color: mainText,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(widget.date!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: primary)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.numbers_sharp,
                            color: mainText,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(widget.id.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: primary)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: widget.onTapConfirm,
                        child: Container(
                          width: 90.w,
                          height: 40.h,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primary),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                IconlyBold.buy,
                                color: Colors.white,
                              ),
                              Text("أستلام",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: widget.onTapReject,
                        child: Container(
                          width: 90.w,
                          height: 40.h,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: secondary),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                FontAwesomeIcons.cancel,
                                color: Colors.white,
                              ),
                              Text("رفض",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_isLoading) _buildLoadingOverlay(),
          ],
        ));
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
