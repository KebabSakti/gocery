import 'package:get/get.dart';
import 'package:gocery/core/config/app_route.dart';

class AppBottomNavigationBarController extends GetxController {
  void setActive(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed(AppRoute.kHomePage);
        break;

      case 1:
        Get.offAllNamed(AppRoute.kOrderPage);
        break;

      default:
        Get.offAllNamed(AppRoute.kHomePage);
    }
  }
}
