import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/feature/auth/presentation/getx/controller/auth_controller.dart';
import 'package:gocery/feature/auth/presentation/getx/controller/otp_page_controller.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: OtpPageController(),
        builder: (OtpPageController c) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 61),
              child: Column(
                children: [
                  Text(
                    'Verifikasi',
                    style: Get.theme.textTheme.headline4,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Get.size.width / 1.3,
                    child: Text(
                      'Masukkan kode OTP yang kami kirimkan ke no hp anda',
                      textAlign: TextAlign.center,
                      style: Get.theme.textTheme.headline6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PinPut(
                    autofocus: true,
                    fieldsCount: 6,
                    eachFieldPadding: const EdgeInsets.all(2),
                    textStyle: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Get.theme.primaryColor,
                    ),
                    selectedFieldDecoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff8F9BB3),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    followingFieldDecoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff8F9BB3),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    submittedFieldDecoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff8F9BB3),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    onChanged: (value) {
                      c.otpCode = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    return Column(
                      children: [
                        Text(
                          Utility.showOtpCountdown(
                            Get.find<AuthController>().otpTimeoutDuration(),
                          ),
                          style: TextStyle(
                            color: Get.theme.primaryColor,
                          ),
                        ),
                        TextButton(
                          onPressed: Get.find<AuthController>().timerStarted()
                              ? null
                              : c.resendPressed,
                          child: const Text('Kirim Ulang'),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            bottomSheet: Container(
              color: Get.theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: c.sendPressed,
                  child: const Text('Kirim'),
                ),
              ),
            ),
          );
        });
  }
}