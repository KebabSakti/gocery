import 'package:get/get.dart';
import 'package:gocery/core/config/app_route.dart';

class IntroPageController extends GetxController {
  Future init() async {
    await Future.delayed(const Duration(seconds: 5));

    Get.offAllNamed(AppRoute.kLandingPage);
  }

  @override
  void onInit() async {
    await init();

    super.onInit();
  }
}
