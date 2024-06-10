import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constans/color.dart';
import '../widget/custom_button.dart';
import '../widget/custom_menu.dart';
import 'home_screen.dart';

class FailScreen extends StatefulWidget {
  const FailScreen({super.key});

  @override
  State<FailScreen> createState() => _FailScreenState();
}

class _FailScreenState extends State<FailScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
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
          title: Image(
            image: const AssetImage("assets/Img/logo.png"),
            width: 30.w,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/Img/fail.png",
                width: 220.w,
              ),
              Text(
                "فشلت العملية",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: textColor),
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomButton(
                text: "أنهاء",
                color: primary,
                textColor: form,
                width: double.infinity,
                height: 60.h,
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
