import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/feature/app/presentation/getx/controller/app_page_controller.dart';
import 'package:gocery/feature/app/presentation/page/app_page.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/forgot_password_page_controller.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/login_page_controller.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/otp_page_controller.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/phone_page_controller.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/register_page_controller.dart';
import 'package:gocery/feature/authentication/presentation/page/forgot_password_page.dart';
import 'package:gocery/feature/authentication/presentation/page/login_page_alt.dart';
import 'package:gocery/feature/authentication/presentation/page/otp_page.dart';
import 'package:gocery/feature/authentication/presentation/page/phone_page.dart';
import 'package:gocery/feature/authentication/presentation/page/register_page.dart';
import 'package:gocery/feature/chat/presentation/page/chat_detail_page.dart';
import 'package:gocery/feature/checkout/presentation/getx/controller/checkout_page_controller.dart';
import 'package:gocery/feature/checkout/presentation/getx/controller/delivery_address_page_controller.dart';
import 'package:gocery/feature/checkout/presentation/page/checkout_page.dart';
import 'package:gocery/feature/checkout/presentation/page/delivery_address_page.dart';
import 'package:gocery/feature/checkout/presentation/page/order_complete_page.dart';
import 'package:gocery/feature/intro/presentation/getx/intro_page_controller.dart';
import 'package:gocery/feature/intro/presentation/page/intro_page.dart';
import 'package:gocery/feature/landing/presentation/getx/landing_page_controller.dart';
import 'package:gocery/feature/landing/presentation/page/landing_page.dart';
import 'package:gocery/feature/order/presentation/getx/controller/order_detail_page_controller.dart';
import 'package:gocery/feature/order/presentation/page/order_detail_page.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_detail_page_controller.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_page_controller.dart';
import 'package:gocery/feature/product/presentation/page/product_detail_page.dart';
import 'package:gocery/feature/product/presentation/page/produt_page.dart';
import 'package:gocery/feature/search/presentation/page/search_page.dart';
import 'package:gocery/feature/tracking/presentation/getx/controller/tracking_page_controller.dart';
import 'package:gocery/feature/tracking/presentation/page/tracking_page.dart';
import 'package:gocery/feature/voucher/presentation/page/voucher_page.dart';

class AppRoute {
  static final routes = [
    GetPage(
      name: kIntroPage,
      page: () => const IntroPage(),
      binding: BindingsBuilder.put(() => IntroPageController()),
    ),
    GetPage(
      name: kLandingPage,
      page: () => const LandingPage(),
      binding: BindingsBuilder.put(() => LandingPageController()),
    ),
    GetPage(
      name: kLoginPage,
      page: () => const LoginPageAlt(),
      binding: BindingsBuilder.put(() => LoginPageController()),
    ),
    GetPage(
      name: kForgotPasswordPage,
      page: () => const ForgotPasswordPage(),
      binding: BindingsBuilder.put(() => ForgotPasswordPageController()),
    ),
    GetPage(
      name: kOtpPage,
      page: () => const OtpPage(),
      binding: BindingsBuilder.put(() => OtpPageController()),
    ),
    GetPage(
      name: kRegisterPage,
      page: () => const RegisterPage(),
      binding: BindingsBuilder.put(() => RegisterPageController()),
    ),
    GetPage(
      name: kPhonePage,
      page: () => const PhonePage(),
      binding: BindingsBuilder.put(() => PhonePageController()),
    ),
    GetPage(
      name: kAppPage,
      page: () => const AppPage(),
      binding: BindingsBuilder.put(() => AppPageController()),
    ),
    GetPage(
      name: kSearchPage,
      page: () => const SearchPage(),
    ),
    GetPage(
      name: kProductDetailPage,
      page: () => const ProductDetailPage(),
      binding: BindingsBuilder.put(() => ProductDetailPageController()),
    ),
    GetPage(
      name: kProductPage,
      page: () => ProductPage(controller: Get.find<ProductPageController>()),
      binding: BindingsBuilder(() {
        Get.create(() => ProductPageController());
      }),
    ),
    GetPage(
      name: kCheckoutPage,
      page: () => const CheckoutPage(),
      binding: BindingsBuilder.put(() => CheckoutPageController()),
    ),
    GetPage(
      name: kOrderCompletePage,
      page: () => const OrderCompletePage(),
    ),
    GetPage(
      name: kDeliveryAddressPage,
      page: () => const DeliveryAddressPage(),
      binding: BindingsBuilder.put(() => DeliveryAddressPageController()),
    ),
    GetPage(
      name: kVoucherPage,
      page: () => const VoucherPage(),
    ),
    GetPage(
      name: kOrderDetailPage,
      page: () => const OrderDetailPage(),
      binding: BindingsBuilder.put(() => OrderDetailPageController()),
    ),
    GetPage(
      name: kChatDetailPage,
      page: () => const ChatDetailPage(),
    ),
    GetPage(
      name: kTrackingPage,
      page: () => const TrackingPage(),
      binding: BindingsBuilder.put(() => TrackingPageController()),
    ),
  ];
}
