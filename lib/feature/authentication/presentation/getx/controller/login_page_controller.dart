import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/authentication/domain/usecase/authentication_usecase.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/timer_countdown_controller.dart';

class LoginPageController extends GetxController {
  final _authenticationUsecase = AuthenticationUsecase();
  final _timerCountdown = TimerCountdownController();

  final formKey = GlobalKey<FormState>();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();

  final RxInt otpTimeoutDuration = 0.obs;

  void forgotPasswordPressed() {
    Get.toNamed(kForgotPasswordPage);
  }

  void phoneLoginPressed() {
    Get.toNamed(kPhonePage);
  }

  void registerPressed() {
    Get.toNamed(kRegisterPage);
  }

  void emailLoginPressed() async {}

  void facebookLoginPressed() async {
    try {
      await _authenticationUsecase.facebookLogin();

      _toHome();
    } on Failure catch (e) {
      MToast.show(e.message);
    }
  }

  void googleLoginPressed() async {
    try {
      await _authenticationUsecase.googleLogin();

      _toHome();
    } on Failure catch (e) {
      MToast.show(e.message);
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
