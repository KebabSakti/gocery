import 'dart:async';

import 'package:get/get.dart';

typedef OnTick = void Function(int tick);

class TimerCountdownController extends GetxController {
  Timer? _timer;
  int? duration;

  TimerCountdownController();

  void start({int startDuration = 61, required OnTick onTick}) {
    duration = startDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      duration = startDuration - t.tick;

      onTick(duration!);

      if (duration == 0) {
        stop();
      }
    });
  }

  void stop({int startDuration = 61}) {
    _timer?.cancel();

    duration = startDuration;
  }

  @override
  void onClose() {
    stop();

    super.onClose();
  }
}
