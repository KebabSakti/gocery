import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/otp_page_controller.dart';
import 'package:gocery/feature/authentication/presentation/widget/otp_timer_countdown.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpPage extends GetView<OtpPageController> {
  const OtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kMediumPadding),
        child: Column(
          children: [
            Text(
              'Verifikasi',
              style: Get.theme.textTheme.headline1,
            ),
            const SizedBox(height: kBigPadding),
            SizedBox(
              width: Get.size.width / 1.3,
              child: Text(
                'Masukkan kode OTP yang kami kirimkan ke no hp anda',
                textAlign: TextAlign.center,
                style: Get.theme.textTheme.headline2,
              ),
            ),
            const SizedBox(height: kBigPadding),
            PinPut(
              autofocus: true,
              fieldsCount: 6,
              eachFieldPadding: const EdgeInsets.all(2),
              textStyle: const TextStyle(
                fontSize: kLargeFont,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
              selectedFieldDecoration: BoxDecoration(
                border: Border.all(
                  color: kLightColor100,
                  width: 1,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              followingFieldDecoration: BoxDecoration(
                border: Border.all(
                  color: kLightColor100,
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
                controller.otpCode = value;
              },
            ),
            const SizedBox(height: kBigPadding),
            OtpTimerCountdown(onPressed: controller.resendPressed),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Get.theme.scaffoldBackgroundColor,
        padding: const EdgeInsets.all(kMediumPadding),
        child: SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            onPressed: controller.sendPressed,
            child: const Text('Kirim'),
          ),
        ),
      ),
    );
  }
}
