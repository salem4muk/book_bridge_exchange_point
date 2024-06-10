// ignore_for_file: deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'routes.dart' as app_routes; // Use alias to differentiate

import 'app_bindings.dart';
import 'constans/color.dart';
import 'theme/theme.dart';
import 'view/screen/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ));
  await GetStorage.init();
  runApp(const BookBridgePoint());
}

class BookBridgePoint extends StatefulWidget {
  const BookBridgePoint({super.key});

  @override
  State<BookBridgePoint> createState() => _BookBridgePointState();
}

class _BookBridgePointState extends State<BookBridgePoint> {
  @override
  void initState() {
    initialization();
    super.initState();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme,
          initialRoute: '/splash',
          getPages: app_routes.AppRoutes.routes,
          initialBinding: AppBindings(), // Use initial binding here
        );
      },
    );
  }
}
