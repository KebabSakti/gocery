import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/param/auth_phone_login_param.dart';
import 'package:gocery/core/service/error/auth_exception.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/feature/authentication/domain/usecase/authentication_usecase.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/timer_countdown_controller.dart';

class LoginPageController extends GetxController {
  final _authenticationUsecase = AuthenticationUsecase();
  final _timerCountdown = TimerCountdownController();

  final formKey = GlobalKey<FormState>();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();

  final RxInt otpTimeoutDuration = 0.obs;

  String phoneField = '';

  void phoneLoginPressed() async {
    try {
      if (phoneField.isEmpty) {
        throw InvalidPhoneNumber();
      }

      if (phoneField.length < 13) {
        throw InvalidPhoneNumber();
      }

      MDialog.loading();

      await _authenticationUsecase.phoneLogin(
        param: AuthPhoneLoginParam(phoneNumber: phoneField),
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
                phoneNumber: phoneField,
                resendToken: resendToken,
                verificationId: verificationId,
              ));
        },
      );
    } on Failure catch (e) {
      MDialog.close();

      MToast.show(Utility.errorMessage(e));
    }
  }

  void facebookLoginPressed() async {
    try {
      MDialog.loading(dismiss: false);

      await _authenticationUsecase.facebookLogin();

      _toHome();
    } catch (e) {
      MDialog.close();

      if (e is! LoginProviderNotSelected) {
        MToast.show(Utility.errorMessage(e));
      }
    }
  }

  void googleLoginPressed() async {
    try {
      MDialog.loading(dismiss: false);

      await _authenticationUsecase.googleLogin();

      _toHome();
    } catch (e) {
      MDialog.close();

      if (e is! LoginProviderNotSelected) {
        MToast.show(Utility.errorMessage(e));
      }
    }
  }

  void _toHome() {
    Get.offAllNamed(kAppPage);
  }

  @override
  void onClose() {
    _timerCountdown.stop();

    super.onClose();
  }
}
