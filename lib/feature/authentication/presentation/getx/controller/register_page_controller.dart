import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/param/auth_register_param.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/authentication/data/repository/auth_repository_impl.dart';
import 'package:gocery/feature/authentication/domain/usecase/register_user.dart';

class RegisterPageController extends GetxController {
  final _registerUser =
      RegisterUser(repository: Get.find<AuthRepositoryImpl>());

  final formKey = GlobalKey<FormState>();
  final nameField = TextEditingController();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  final phoneField = TextEditingController();

  void formOnSubmit() async {
    if (formKey.currentState!.validate()) {
      try {
        MDialog.loading();

        await _registerUser(
            param: AuthRegisterParam(
          name: nameField.text,
          email: emailField.text,
          password: passwordField.text,
          phone: phoneField.text,
        ));

        Get.offAllNamed(kAppPage);
      } catch (e) {
        MDialog.close();

        MToast.show(e.toString());
      }
    }
  }
}
