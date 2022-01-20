import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/core/service/storage/storage.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/auth/data/model/auth_param.dart';
import 'package:gocery/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:gocery/feature/auth/domain/usecase/login_usecase.dart';

class LoginPageController extends GetxController {
  final _loginUsecase = LoginUsecase(
    secureStorage: Get.find<SecureStorageImpl>(),
    authRepository: Get.find<AuthRepositoryImpl>(),
  );

  final formKey = GlobalKey<FormState>();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();

  void forgotPasswordPressed() {
    Get.toNamed(kForgotPasswordPage);
  }

  void phoneLoginPressed() {
    Get.toNamed(kPhonePage);
  }

  void registerPressed() {
    Get.toNamed(kRegisterPage);
  }

  void emailLoginPressed() async {
    try {
      if (formKey.currentState!.validate()) {
        MDialog.loading();

        await _loginUsecase.emailLogin(UserLoginParam(
          email: emailField.text,
          password: passwordField.text,
        ));
      }
    } on Failure catch (e) {
      MDialog.close();

      MToast.show(e.message);
    }
  }

  void facebookLoginPressed() async {
    try {
      await _loginUsecase.facebookLogin();
    } on Failure catch (e) {
      MToast.show(e.message);
    }
  }

  void googleLoginPressed() async {
    try {
      // await _loginUsecase.googleLogin();

      Get.offAllNamed(kAppPage, arguments: 0);
    } on Failure catch (e) {
      MToast.show(e.message);
    }
  }
}
