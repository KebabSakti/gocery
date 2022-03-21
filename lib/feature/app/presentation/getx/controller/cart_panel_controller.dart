import 'package:get/get.dart';
import 'package:gocery/feature/cart/presentation/getx/controller/cart_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CartPanelController extends GetxController {
  final CartController cartController = Get.find<CartController>();

  final panelController = PanelController();

  @override
  void onInit() {
    ever(cartController.qtyTotal, (int total) {
      if (total > 0) {
        panelController.open();
      } else {
        panelController.close();
      }
    });

    super.onInit();
  }
}
