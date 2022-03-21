import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:gocery/core/service/error/business_exception.dart';
import 'package:gocery/core/service/error/network_exception.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:intl/intl.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
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

  static String getCartItemTypes({required List<CartItemEntity> param}) {
    List<String> message = <String>[];

    for (CartItemEntity e in param) {
      String type = e.productModel!.type!;

      if (type == 'GAS' || type == 'OTHER') {
        if (!message.contains('GAS')) {
          message.add('GAS');
        }
      }

      if (type == 'GROCERY') {
        if (!message.contains('GROCERY')) {
          message.add('GROCERY');
        }
      }
    }

    // debugPrint('\x1B[32m$message\x1B[0m');

    return message.join(',');
  }

  static String placemarkToString({required List<Placemark> placemark}) {
    List<String> strings = [
      placemark[0].street ?? '',
      placemark[0].subLocality ?? '',
      placemark[0].locality ?? '',
      placemark[0].subAdministrativeArea ?? '',
      placemark[0].administrativeArea ?? '',
      placemark[0].postalCode ?? '',
      placemark[0].country ?? '',
    ];

    String formatted = strings.join(', ');

    return formatted;
  }

  static String phoneParser({required String phone}) {
    final phoneNumber = PhoneNumber.fromIsoCode('ID', phone);

    final parsed = phoneNumber.international;

    return parsed;
  }

  static bool validatePhone({required String phone}) {
    final phoneNumber = PhoneNumber.fromIsoCode('ID', phone);

    final bool result = phoneNumber.validate(type: PhoneNumberType.mobile);

    return result;
  }
}
