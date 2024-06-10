

import 'package:get/get.dart';

import 'view/screen/auth/forgot_password_screen.dart';
import 'view/screen/auth/login_screen.dart';
import 'view/screen/auth/new_password_screen.dart';
import 'view/screen/auth/send_verification_code_screen.dart';
import 'view/screen/auth/verify_screen.dart';
import 'view/screen/home_screen.dart';
import 'view/screen/splash_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/splash', page: () => const SplashScreen()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/forgot_password', page: () => const ForgotPasswordScreen()),
    GetPage(name: '/new_password', page: () => const NewPasswordScreen(code: '', email: '',)),
    GetPage(name: '/send_verification_code', page: () => const SendVerificationCodeScreen()),
    GetPage(name: '/verify', page: () => const VerifyScreen(type: '', identifier: '',)),
    GetPage(name: '/home', page: () => const HomeScreen()),
  ];
}
