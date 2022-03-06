import 'package:gocery/core/service/error/business_exception.dart';
import 'package:gocery/core/service/error/network_exception.dart';

class MapExceptionMessage {
  static String exception(Exception exception) {
    if (exception is UserDisabled) {
      return 'Akun anda tidak dapat digunakan, harap hubungi cs kami untuk info lebih lanjut';
    }

    if (exception is InvalidOtpCode) {
      return 'Kode OTP yang anda masukkan tidak valid';
    }

    if (exception is InvalidOtpCode) {
      return 'Kode OTP yang anda masukkan tidak valid';
    }

    if (exception is InvalidPhoneNumber) {
      return 'Nomor hp tidak valid';
    }

    if (exception is Unauthenticated) {
      return 'Harap login untuk melanjutkan';
    }

    if (exception is NoInternet) {
      return 'Cek kembali koneksi internet anda';
    }

    if (exception is ServerError) {
      return 'Server sedang mengalami gangguan, cobalah beberapa saat lagi';
    }

    if (exception is MaxOrderLimit) {
      return 'Produk melebihi limit order';
    }

    if (exception is OtpCodeToShort) {
      return 'Kode OTP memerlukan 6 digit angka';
    }

    return 'Terjadi kesalahan, harap coba beberapa saat lagi';
  }
}
