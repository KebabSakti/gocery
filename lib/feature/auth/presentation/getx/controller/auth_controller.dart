import 'dart:async';

import 'package:get/get.dart';
import 'package:gocery/feature/auth/data/model/auth_param.dart';

class AuthController extends GetxController {
  Timer? timer;
  PhoneLoginParam? phoneLoginParam;

  final RxInt otpTimeoutDuration = 60.obs;
  final RxBool timerStarted = false.obs;

  void startOtpTimer(int value) {
    if (!timerStarted()) {
      timerStarted(true);

      timer = Timer.periodic(const Duration(seconds: 1), (t) async {
        otpTimeoutDuration((value - t.tick));

        if (otpTimeoutDuration() == 0) {
          stopOtpTimer(0);
        }
      });
    }
  }

  void stopOtpTimer(int value) {
    timer?.cancel();

    otpTimeoutDuration(value);

    timerStarted(false);
  }

  @override
  void onClose() {
    stopOtpTimer(60);

    super.onClose();
  }
}
