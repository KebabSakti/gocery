import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/app/presentation/getx/controller/add_to_cart_panel_controller.dart';
import 'package:gocery/feature/cart/presentation/getx/controller/cart_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AppPageController extends GetxController {
  AppPageController() {
    cartController = Get.put(CartController());
    addToCartPanelController =
        Get.put(AddToCartPanelController(), tag: 'AppPage');
  }

  late final CartController cartController;
  late final AddToCartPanelController addToCartPanelController;

  Timer? _timer;

  final PageController pageController = PageController();
  final PanelController addToCartPanel = PanelController();

  final activePage = 0.obs;

  Future<bool> onBackButtonPressed() async {
    if (addToCartPanelController.panelController.isPanelOpen) {
      addToCartPanelController.panelController.close();
    } else {
      if (_timer == null) {
        MToast.show('Tekan sekali lagi untuk keluar');

        _startTimer();
      } else {
        if (_timer!.isActive) {
          return true;
        }
      }
    }

    return false;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (t.tick > 1) {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void initListener() {
    ever(activePage, (int index) => pageController.jumpToPage(index));
  }

  void init() async {
    await Future.delayed(const Duration(milliseconds: 100));

    activePage(Get.arguments);
  }

  @override
  void onInit() {
    initListener();

    init();

    super.onInit();
  }

  @override
  void onClose() {
    _stopTimer();

    super.onClose();
  }
}
