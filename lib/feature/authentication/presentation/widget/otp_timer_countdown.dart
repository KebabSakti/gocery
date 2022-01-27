import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/feature/authentication/presentation/getx/controller/login_page_controller.dart';

class OtpTimerCountdown extends StatelessWidget {
  const OtpTimerCountdown({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final _loginPageController = Get.find<LoginPageController>();

    return Obx(() {
      return Column(
        children: [
          Text(
            Utility.showOtpCountdown(
              _loginPageController.otpTimeoutDuration(),
            ),
            style: const TextStyle(color: kPrimaryColor),
          ),
          TextButton(
            onPressed: _loginPageController.otpTimeoutDuration() > 0
                ? null
                : onPressed,
            child: const Text('Kirim Ulang'),
          ),
        ],
      );
    });
  }
}
