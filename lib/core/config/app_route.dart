import 'package:get/get.dart';
import 'package:gocery/feature/auth/presentation/getx/dependency/auth_dependency.dart';
import 'package:gocery/feature/auth/presentation/page/forgot_password_page.dart';
import 'package:gocery/feature/auth/presentation/page/login_page.dart';
import 'package:gocery/feature/auth/presentation/page/otp_page.dart';
import 'package:gocery/feature/auth/presentation/page/phone_page.dart';
import 'package:gocery/feature/auth/presentation/page/register_page.dart';
import 'package:gocery/feature/home/presentation/page/home_page.dart';
import 'package:gocery/feature/intro/presentation/page/intro_page.dart';
import 'package:gocery/feature/landing/presentation/page/landing_page.dart';
import 'package:gocery/feature/order/presentation/page/order_page.dart';

class AppRoute {
  static const kIntroPage = '/';
  static const kLandingPage = '/landing';
  static const kLoginPage = '/login';
  static const kForgotPasswordPage = '/forgot_password';
  static const kOtpPage = '/otp';
  static const kRegisterPage = '/register';
  static const kPhonePage = '/phone';
  static const kHomePage = '/home';
  static const kOrderPage = '/order';

  static final routes = [
    GetPage(name: kIntroPage, page: () => const IntroPage()),
    GetPage(name: kLandingPage, page: () => const LandingPage()),
    GetPage(
      name: kLoginPage,
      binding: AuthDependency(),
      page: () => const LoginPage(),
    ),
    GetPage(
      name: kForgotPasswordPage,
      binding: AuthDependency(),
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(
      name: kOtpPage,
      binding: AuthDependency(),
      page: () => const OtpPage(),
    ),
    GetPage(
      name: kRegisterPage,
      binding: AuthDependency(),
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: kPhonePage,
      binding: AuthDependency(),
      page: () => const PhonePage(),
    ),
    GetPage(
      name: kHomePage,
      page: () => const HomePage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: kOrderPage,
      page: () => const OrderPage(),
      transition: Transition.noTransition,
    ),
  ];
}
