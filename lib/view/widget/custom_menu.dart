// ignore_for_file: camel_case_types, avoid_unnecessary_containers, unused_import

import 'package:book_bridge_exchange_point/view/screen/auth/update_password_screen.dart';
import 'package:book_bridge_exchange_point/view/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../constans/color.dart';
import '../../controllers/auth_controller.dart';
import '../screen/list_of_booking_screen.dart';
import '../screen/list_of_donation_screen.dart';

class CustomMenu extends StatefulWidget {
  const CustomMenu({super.key});

  @override
  State<CustomMenu> createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  final AuthController authController = Get.find<AuthController>();
  Map<String, dynamic>? userInfo;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    userInfo = await authController.getPointInformation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        children: [
          _buildCloseButton(context),
          SizedBox(height: 25.h),
          _buildLogoAndUserInfo(context),
          SizedBox(height: 50.h),
          _buildMenuNav(context),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: () {
          Scaffold.of(context).closeDrawer();
        },
        icon: const Icon(
          Icons.close,
          size: 30,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildLogoAndUserInfo(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage("assets/Img/Ok-amico.png"),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userInfo?['email'] ?? "",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: textColor),
            ),
            Text(
              userInfo?['userName'] ?? "",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: secondaryText),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          _buildMenuItem(
            context,
            icon: const Icon(IconlyBroken.home, color: primary),
            text: "الرئيسية",
            onTap: () {
              Navigator.of(context).pop();
              Get.offAll(() => const HomeScreen());
            },
          ),
          _buildMenuItem(
            context,
            icon: const Icon(IconlyBroken.password, color: primary),
            text: "تغيير كلمة المرور",
            onTap: () {
              Navigator.of(context).pop();
              Get.offAll(() => const UpdatePasswordScreen());
            },
          ),
          _buildMenuItem(
            context,
            icon: const Icon(IconlyBroken.logout, color: primary),
            text: "تسجيل الخروج",
            onTap: () {
              authController.logout();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required Icon icon, required String text, required VoidCallback onTap}) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: lineColor,
            width: 1.0.w,
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 20.w),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: textColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
