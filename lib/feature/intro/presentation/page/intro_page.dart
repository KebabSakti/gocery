import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/feature/intro/presentation/getx/intro_page_controller.dart';

class IntroPage extends GetView<IntroPageController> {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kGoceryLogoWhite,
              width: Get.size.width / 2,
            )
            // CircularProgressIndicator(),
            // SizedBox(height: 16),
            // Text(
            //   'Lagi siap siap',
            //   textAlign: TextAlign.center,
            // ),
          ],
        ),
      ),
    );
  }
}
