import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/login_page_controller.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginPageAlt extends GetView<LoginPageController> {
  const LoginPageAlt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(kMediumPadding),
            alignment: Alignment.center,
            constraints: BoxConstraints(
              minHeight: Get.size.height - 30,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMediumPadding),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff8F9BB3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InternationalPhoneNumberInput(
                        autoFocus: true,
                        countries: const ['ID'],
                        spaceBetweenSelectorAndTextField: 0,
                        errorMessage: 'No hp tidak valid',
                        selectorConfig: const SelectorConfig(
                          setSelectorButtonAsPrefixIcon: true,
                        ),
                        inputDecoration: InputDecoration(
                          hintText: '812-5498-2664',
                          hintStyle: Get.theme.textTheme.bodyText2,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        onInputChanged: (phone) {
                          controller.phoneField = phone.phoneNumber ?? '';
                        },
                      ),
                    ),
                    const SizedBox(height: kBigPadding),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: controller.phoneLoginPressed,
                        child: const Text('Kirim Kode OTP'),
                      ),
                    ),
                    const SizedBox(height: kBigPadding),
                    const Text('atau'),
                    const SizedBox(height: kBigPadding),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              kFacebookLogo,
                              width: 14,
                            ),
                            const SizedBox(width: kMediumPadding),
                            const Text('Lanjutkan dengan Facebook'),
                            const SizedBox(width: 40),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff3b5998),
                        ),
                        onPressed: controller.facebookLoginPressed,
                      ),
                    ),
                    const SizedBox(height: kMediumPadding),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(kGoogleLogo, width: 20),
                            const SizedBox(width: kMediumPadding),
                            const Text('Lanjutkan dengan Google'),
                            const SizedBox(width: 50),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kLightColor,
                          onPrimary: kLightColor100,
                          side:
                              const BorderSide(width: 1, color: kLightColor100),
                        ),
                        onPressed: controller.googleLoginPressed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
