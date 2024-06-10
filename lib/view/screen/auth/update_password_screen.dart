import 'package:book_bridge_exchange_point/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../constans/color.dart';
import '../../../helper/loading_overlay_helper.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_form_field.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final AuthController authController = Get.find<AuthController>();

  bool obscure = true;
  bool obscureNew = true;
  bool obscureConfirmation = true;
  final key = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: const CustomAppBar(title: "تغيير كلمة المرور"),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ).w,
                  child: Form(
                    key: key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "تغيير كلمة المرور",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10).h,
                          child: Text(
                            "قم بأدخال كلمة مرور جديدة",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        CustomTextFormField(
                          controller: _oldPasswordController,
                          validater: (value) {
                            if (value!.isEmpty) {
                              return 'ارجاء إدخال كلمة المرور الحالية';
                            }
                            if (value.length < 8 || value.length > 30) {
                              return "كلمة المرور الحالية يجب ان تكون اكبر من 8 واصغر من 30";
                            }
                            return null;
                          },
                          obscureText: obscure,
                          hint: "كلمة المرور الحالية ",
                          suffixIcon: IconlyBroken.lock,
                          prefixIcon: obscure == false
                              ? IconlyBroken.show
                              : IconlyBroken.hide,
                          onTapPrefixIcon: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                        ),
                        CustomTextFormField(
                          controller: _newPasswordController,
                          validater: (value) {
                            if (value!.isEmpty) {
                              return 'ارجاء إدخال كلمة المرور الجديدة';
                            }
                            if (value.length < 8 || value.length > 30) {
                              return "كلمة المرور الجديدة يجب ان تكون اكبر من 8 واصغر من 30";
                            }
                            return null;
                          },
                          obscureText: obscureNew,
                          hint: "كلمة المرور الجديدة",
                          suffixIcon: IconlyBroken.lock,
                          prefixIcon: obscureNew == false
                              ? IconlyBroken.show
                              : IconlyBroken.hide,
                          onTapPrefixIcon: () {
                            setState(() {
                              obscureNew = !obscureNew;
                            });
                          },
                        ),
                        CustomTextFormField(
                          validater: (value) {
                            if (value!.isEmpty) {
                              return 'الرجاء إدخال تأكيد كلمة المرور الجديدة';
                            }
                            if (value != _newPasswordController.text) {
                              return 'كلمة المرور الجديدة غير متطابقة';
                            }
                            return null;
                          },
                          obscureText: obscureConfirmation,
                          hint: "تأكيد كلمة المرور الجديدة",
                          suffixIcon: IconlyBroken.lock,
                          prefixIcon: obscureConfirmation == false
                              ? IconlyBroken.show
                              : IconlyBroken.hide,
                          onTapPrefixIcon: () {
                            setState(() {
                              obscureConfirmation = !obscureConfirmation;
                            });
                          },
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        CustomButton(
                          text: "حفظ",
                          color: primary,
                          textColor: form,
                          width: double.infinity,
                          height: 60.h,
                          onTap: () {
                            if (key.currentState!.validate()) {
                              _newPasswordController.clear();
                              _oldPasswordController.clear();
                              authController.updatePassword(
                                _oldPasswordController.text,
                                _newPasswordController.text,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          if (authController.isLoading.value) {
            return const LoadingOverlayHelper();
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
