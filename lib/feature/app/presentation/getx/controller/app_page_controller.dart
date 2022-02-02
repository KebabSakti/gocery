import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AppPageController extends GetxController {
  Timer? _timer;

  final PageController pageController = PageController();
  final PanelController addToCartPanel = PanelController();

  final activePage = 0.obs;

  Future<bool> onBackButtonPressed() async {
    if (addToCartPanel.isPanelOpen) {
      addToCartPanel.close();
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

  @override
  void onInit() async {
    ever(activePage, (int index) => pageController.jumpToPage(index));

    await Future.delayed(const Duration(milliseconds: 100));

    activePage(Get.arguments);

    super.onInit();
  }

  @override
  void onClose() {
    _stopTimer();

    super.onClose();
  }
}
