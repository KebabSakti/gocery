import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/authentication/data/model/authentication_phone_login_param.dart';
import 'package:gocery/feature/authentication/domain/usecase/authentication_usecase.dart';

class PhonePageController extends GetxController {
  final _authenticationUsecase = AuthenticationUsecase();

  String phone = '';

  void sendCodePressed() async {
    try {
      if (phone.isEmpty) {
        throw Failure('No hp tidak boleh kosong');
      }

      if (phone.length < 13) {
        throw Failure('No hp tidak valid');
      }

      MDialog.loading();

      await _authenticationUsecase.phoneLogin(
          param: AuthenticationPhoneLoginParam(phoneNumber: phone),
          verificationFailed: (Exception e) {
            MDialog.close();

            if (e is FirebaseAuthException) {
              switch (e.code) {
                case 'invalid-phone-number':
                  MToast.show('Nomor hp tidak valid');
                  break;

                default:
                  MToast.show(
                      'Terjadi kesalahan, harap coba beberapa saat lagi');
                  break;
              }
            } else {
              MToast.show('Terjadi kesalahan, harap coba beberapa saat lagi');
            }
          },
          completeCallback: () {
            MDialog.close();

            Get.offAllNamed(kAppPage);
          },
          codeSent: (String verificationId, int? resendToken) async {
            MDialog.close();

            Get.toNamed(kOtpPage,
                arguments: AuthenticationPhoneLoginParam(
                  phoneNumber: phone,
                  resendToken: resendToken,
                  verificationId: verificationId,
                ));
          });
    } on Failure catch (e) {
      MDialog.close();

      MToast.show(e.message);
    }
  }
}
