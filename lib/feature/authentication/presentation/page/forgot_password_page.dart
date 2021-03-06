import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/forgot_password_page_controller.dart';
import 'package:gocery/feature/authentication/presentation/widget/auth_form_field.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordPageController> {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kMediumPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lupa Password',
                    style: Get.theme.textTheme.headline1,
                  ),
                  const SizedBox(height: kSmallPadding),
                  SizedBox(
                    width: Get.size.width / 1.3,
                    child: Text(
                      'Ketik email atau no hp anda untuk reset password',
                      textAlign: TextAlign.center,
                      style: Get.theme.textTheme.headline2,
                    ),
                  )
                ],
              ),
              const Form(
                child: AuthFormField(
                  hintText: 'Email',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Kirim'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
