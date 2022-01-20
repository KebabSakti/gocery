import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/feature/app/presentation/getx/controller/app_page_controller.dart';
import 'package:gocery/feature/app/presentation/page/app_page.dart';
import 'package:gocery/feature/auth/presentation/getx/dependency/auth_dependency.dart';
import 'package:gocery/feature/auth/presentation/page/forgot_password_page.dart';
import 'package:gocery/feature/auth/presentation/page/login_page.dart';
import 'package:gocery/feature/auth/presentation/page/otp_page.dart';
import 'package:gocery/feature/auth/presentation/page/phone_page.dart';
import 'package:gocery/feature/auth/presentation/page/register_page.dart';
import 'package:gocery/feature/chat/presentation/page/chat_detail_page.dart';
import 'package:gocery/feature/checkout/presentation/getx/controller/checkout_page_controller.dart';
import 'package:gocery/feature/checkout/presentation/getx/controller/delivery_address_page_controller.dart';
import 'package:gocery/feature/checkout/presentation/page/checkout_page.dart';
import 'package:gocery/feature/checkout/presentation/page/delivery_address_page.dart';
import 'package:gocery/feature/checkout/presentation/page/order_complete_page.dart';
import 'package:gocery/feature/intro/presentation/page/intro_page.dart';
import 'package:gocery/feature/landing/presentation/page/landing_page.dart';
import 'package:gocery/feature/order/presentation/getx/controller/order_detail_page_controller.dart';
import 'package:gocery/feature/order/presentation/page/order_detail_page.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_detail_page_controller.dart';
import 'package:gocery/feature/product/presentation/page/product_detail_page.dart';
import 'package:gocery/feature/product/presentation/page/produt_page.dart';
import 'package:gocery/feature/search/presentation/page/search_page.dart';
import 'package:gocery/feature/tracking/presentation/getx/controller/tracking_page_controller.dart';
import 'package:gocery/feature/tracking/presentation/page/tracking_page.dart';
import 'package:gocery/feature/voucher/presentation/page/voucher_page.dart';

class AppRoute {
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
      name: kAppPage,
      page: () => const AppPage(),
      binding: BindingsBuilder(() {
        Get.put(AppPageController());
      }),
    ),
    GetPage(
      name: kSearchPage,
      page: () => const SearchPage(),
    ),
    GetPage(
      name: kProductDetailPage,
      page: () => const ProductDetailPage(),
      binding: BindingsBuilder(() {
        Get.put(ProductDetailPageController());
      }),
    ),
    GetPage(
      name: kProductPage,
      page: () => const ProductPage(),
    ),
    GetPage(
      name: kCheckoutPage,
      page: () => const CheckoutPage(),
      binding: BindingsBuilder(() {
        Get.put(CheckoutPageController());
      }),
    ),
    GetPage(
      name: kOrderCompletePage,
      page: () => const OrderCompletePage(),
    ),
    GetPage(
      name: kDeliveryAddressPage,
      page: () => const DeliveryAddressPage(),
      binding: BindingsBuilder(() {
        Get.put(DeliveryAddressPageController());
      }),
    ),
    GetPage(
      name: kVoucherPage,
      page: () => const VoucherPage(),
    ),
    GetPage(
      name: kOrderDetailPage,
      page: () => const OrderDetailPage(),
      binding: BindingsBuilder(() {
        Get.put(OrderDetailPageController());
      }),
    ),
    GetPage(
      name: kChatDetailPage,
      page: () => const ChatDetailPage(),
    ),
    GetPage(
      name: kTrackingPage,
      page: () => const TrackingPage(),
      binding: BindingsBuilder(() {
        Get.put(TrackingPageController());
      }),
    ),
  ];
}
