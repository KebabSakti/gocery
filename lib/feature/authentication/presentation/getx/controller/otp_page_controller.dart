import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/param/auth_phone_login_param.dart';
import 'package:gocery/core/service/error/business_exception.dart';
import 'package:gocery/core/service/error/map_exception_message.dart';
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
        throw OtpCodeToShort();
      }

      MDialog.loading();

      await _authenticationUsecase.otpLogin(
        param: AuthPhoneLoginParam(
          verificationId: _argument.verificationId,
          otpCode: otpCode,
        ),
      );

      Get.offAllNamed(kAppPage);
    } on Exception catch (e) {
      MDialog.close();

      MToast.show(MapExceptionMessage.exception(e));
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

        if (e is FirebaseAuthException) {
          MToast.show(MapExceptionMessage.exception(InvalidPhoneNumber()));
        } else {
          MToast.show(MapExceptionMessage.exception(Exception()));
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
