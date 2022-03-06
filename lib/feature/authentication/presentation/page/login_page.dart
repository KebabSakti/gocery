import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/login_page_controller.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({Key? key}) : super(key: key);

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
                        border: Border.all(color: kLightColor100),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          icon:
                              const Icon(AppIcon.phone, color: kLightColor100),
                          hintText: 'Masukkan nomor hp untuk login',
                          hintStyle: Get.textTheme.bodyText2,
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        onChanged: (value) {
                          controller.phoneField =
                              Utility.phoneParser(phone: value);
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
