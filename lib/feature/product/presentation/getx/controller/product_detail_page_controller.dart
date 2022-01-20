import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductDetailPageController extends GetxController {
  final PanelController addToCartPanel = PanelController();

  Future<bool> onBackButtonPressed() async {
    if (addToCartPanel.isPanelOpen) {
      addToCartPanel.close();
    } else {
      return true;
    }

    return false;
  }
}
