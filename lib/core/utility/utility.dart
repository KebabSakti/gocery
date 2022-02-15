import 'dart:math';

import 'package:gocery/core/service/error/auth_exception.dart';
import 'package:gocery/core/service/error/network_exception.dart';
import 'package:intl/intl.dart';
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

    if (seconds > 60) {
      m = Duration(seconds: seconds).inMinutes.toString().padLeft(2, '0');
      s = Duration(seconds: seconds).inSeconds.toString().padLeft(2, '0');
    } else {
      s = Duration(seconds: seconds).inSeconds.toString().padLeft(2, '0');
    }

    return '$m:$s';
  }

  static String currency(
    String value, {
    String locale = 'id_ID',
    String name = 'Rp ',
    int digit = 0,
  }) {
    NumberFormat numberFormat = NumberFormat.currency(
      locale: locale,
      name: name,
      decimalDigits: digit,
    );

    return numberFormat.format(double.parse(value));
  }

  static String errorMessage(dynamic e) {
    if (e is UserDisabled) {
      return 'Akun anda tidak dapat digunakan, harap hubungi cs kami untuk info lebih lanjut';
    }

    if (e is InvalidOtpCode) {
      return 'Kode OTP yang anda masukkan tidak valid';
    }

    if (e is InvalidPhoneNumber) {
      return 'Nomor hp tidak valid';
    }

    if (e is Unauthenticated) {
      return 'Harap login untuk melanjutkan';
    }

    if (e is NoInternet) {
      return 'Cek kembali koneksi internet anda';
    }

    if (e is ServerError) {
      return 'Server sedang mengalami gangguan, cobalah beberapa saat lagi';
    }

    return 'Terjadi kesalahan, harap coba beberapa saat lagi';
  }
}
