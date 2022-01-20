import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/feature/auth/presentation/getx/controller/login_page_controller.dart';
import 'package:gocery/feature/auth/presentation/widget/auth_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LoginPageController(),
        builder: (LoginPageController c) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(kMediumPadding),
                  alignment: Alignment.center,
                  constraints: BoxConstraints(
                    minHeight: Get.size.height - 24,
                    maxHeight: double.infinity,
                    minWidth: double.infinity,
                  ),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            kGoceryLogoTop,
                            width: 80,
                          ),
                          const SizedBox(height: kHugePadding),
                          Text( 
                            'Selamat Datang',
                            style: Get.theme.textTheme.headline1,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: Get.size.width / 1.3,
                            child: Text(
                              'Login untuk memulai',
                              textAlign: TextAlign.center,
                              style: Get.theme.textTheme.headline2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kHugePadding),
                      Form(
                        key: c.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AuthFormField(
                              controller: c.emailField,
                              hintText: 'Email',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: kBigPadding),
                            AuthFormField(
                              controller: c.passwordField,
                              hintText: 'Password',
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: kBigPadding),
                            SizedBox(
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: c.forgotPasswordPressed,
                                child: const Text(
                                  'Lupa password',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: kBigPadding),
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: c.emailLoginPressed,
                                child: const Text('Login'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: kHugePadding),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: c.facebookLoginPressed,
                                child: SvgPicture.asset(
                                  kFacebookLogo,
                                  width: 15,
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(kSmallPadding),
                                  primary: const Color(0xff0041A8),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: c.phoneLoginPressed,
                                child: const Icon(
                                  Icons.phone_rounded,
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(kSmallPadding),
                                  primary: const Color(0xff42AAFF),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: c.googleLoginPressed,
                                child: SvgPicture.asset(kGoogleLogo, width: 28),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(kSmallPadding),
                                  primary: const Color(0xffF2F8FF),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: kBigPadding),
                          RichText(
                            text: TextSpan(
                              text: 'Belum punya akun ? ',
                              style: Get.theme.textTheme.bodyText2,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Daftar',
                                  style: const TextStyle(color: kPrimaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = c.registerPressed,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
