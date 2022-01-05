import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/feature/auth/presentation/getx/controller/forgot_password_page_controller.dart';
import 'package:gocery/feature/auth/presentation/widget/auth_form_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ForgotPasswordPageController(),
        builder: (ForgotPasswordPageController c) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Lupa Password',
                          style: Get.theme.textTheme.headline4,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: Get.size.width / 1.3,
                          child: Text(
                            'Ketik email atau no hp anda untuk reset password',
                            textAlign: TextAlign.center,
                            style: Get.theme.textTheme.headline6,
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
        });
  }
}
