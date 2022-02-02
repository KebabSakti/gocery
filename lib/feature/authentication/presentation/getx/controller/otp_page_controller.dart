import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/param/auth_phone_login_param.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/authentication/domain/usecase/authentication_usecase.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/login_page_controller.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/timer_countdown_controller.dart';

class OtpPageController extends GetxController {
  final _authenticationUsecase = AuthenticationUsecase();
  final _argument = Get.arguments as AuthPhoneLoginParam;
  final _timerCountdown = TimerCountdownController();
  final _loginPageController = Get.find<LoginPageController>();

  String otpCode = '';

  void sendPressed() async {
    try {
      if (otpCode.length < 6) {
        throw Failure('Kode OTP memerlukan 6 digit angka');
      }

      MDialog.loading();

      await _authenticationUsecase.otpLogin(
        param: AuthPhoneLoginParam(
          verificationId: _argument.verificationId,
          otpCode: otpCode,
        ),
      );

      Get.offAllNamed(kAppPage);
    } catch (e) {
      MDialog.close();

      if (e is Failure) {
        MToast.show(e.message);
      } else {
        MToast.show('Terjadi kesalahan, harap coba beberapa saat lagi');
      }
    }
  }

  void resendPressed() async {
    MDialog.loading();

    _countdownStart();

    await _authenticationUsecase.phoneLogin(
      param: AuthPhoneLoginParam(
        phoneNumber: _argument.phoneNumber,
        resendToken: _argument.resendToken,
      ),
      successCallback: () {
        MDialog.close();

        Get.offAllNamed(kAppPage);
      },
      verificationFailed: (Exception e) {
        MDialog.close();

        if (e is Failure) {
          MToast.show(e.message);
        } else {
          MToast.show('Terjadi kesalahan, harap coba beberapa saat lagi');
        }
      },
      codeSent: (verificationId, resendToken) {
        MDialog.close();

        Get.toNamed(kOtpPage,
            arguments: AuthPhoneLoginParam(
              phoneNumber: _argument.phoneNumber,
              resendToken: resendToken,
              verificationId: verificationId,
            ));
      },
    );
  }

  void _countdownStart() {
    if (_loginPageController.otpTimeoutDuration() == 0) {
      _timerCountdown.start(onTick: (int tick) {
        _loginPageController.otpTimeoutDuration(tick);
      });
    }
  }

  @override
  void onInit() {
    _countdownStart();

    super.onInit();
  }
}
