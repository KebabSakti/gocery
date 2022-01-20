import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CheckoutPageController extends GetxController {
  final PanelController deliveryTimePanel = PanelController();
  final PanelController paymentChannelPanel = PanelController();

  void toDeliveryAddressPage() async {
    await Permission.location.request();

    if (await Permission.location.request().isGranted) {
      await Get.toNamed(kDeliveryAddressPage);
    }
  }

  Future<bool> onBackButtonPressed() async {
    if (deliveryTimePanel.isPanelOpen) {
      deliveryTimePanel.close();
    }

    if (paymentChannelPanel.isPanelOpen) {
      paymentChannelPanel.close();
    }

    if (paymentChannelPanel.isPanelClosed && deliveryTimePanel.isPanelClosed) {
      return true;
    }

    return false;
  }
}
