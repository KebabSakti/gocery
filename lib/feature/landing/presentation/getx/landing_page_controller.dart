import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';

class LandingPageController extends GetxController {
  final activeSlide = 0.obs;

  void toLoginPage() {
    Get.offAllNamed(kLoginPage);
  }
}
