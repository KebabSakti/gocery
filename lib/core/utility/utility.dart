import 'dart:math';

import 'package:uuid/uuid.dart';

class Utility {
  static int randomNumber({int min = 0, int max = 10}) {
    final _random = Random();

    return min + _random.nextInt(max - min);
  }

  static Duration randomDuration(
      {int min = 0, int max = 10, String type = 'seconds'}) {
    switch (type) {
      case 'days':
        return Duration(days: randomNumber(min: min, max: max));

      case 'hours':
        return Duration(hours: randomNumber(min: min, max: max));

      case 'minutes':
        return Duration(minutes: randomNumber(min: min, max: max));

      case 'seconds':
        return Duration(seconds: randomNumber(min: min, max: max));

      case 'miliseconds':
        return Duration(milliseconds: randomNumber(min: min, max: max));

      case 'microseconds':
        return Duration(microseconds: randomNumber(min: min, max: max));

      default:
        return Duration(seconds: randomNumber(min: min, max: max));
    }
  }

  static String randomUid() {
    Uuid uuid = const Uuid();

    return uuid.v4();
  }

  static String showOtpCountdown(int seconds) {
    String m = '00';
    String s = '00';

    if (seconds > 59) {
      m = Duration(seconds: seconds).inMinutes.toString().padLeft(2, '0');
      s = Duration(seconds: seconds).inSeconds.toString().padLeft(2, '0');
    } else {
      s = Duration(seconds: seconds).inSeconds.toString().padLeft(2, '0');
    }

    return '$m:$s';
  }
}
