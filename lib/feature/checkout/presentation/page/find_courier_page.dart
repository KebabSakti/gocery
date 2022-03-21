import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/feature/checkout/presentation/getx/controller/find_courier_page_controller.dart';
import 'package:gocery/feature/checkout/presentation/widget/clipper.dart';
import 'package:lottie/lottie.dart';

class FindCourierPage extends GetView<FindCourierPageController> {
  const FindCourierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightColor,
      body: Column(
        children: [
          Expanded(
            child: ClipPath(
              clipper: Clipper(),
              child: Container(
                color: kPrimaryColor,
                child: Stack(
                  children: [
                    Center(
                      child: Lottie.asset(kPulseAnimation),
                    ),
                    const Center(
                      child: Icon(
                        Icons.location_on_rounded,
                        size: 80,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Mencari kurir, mohon tunggu..',
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline2,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: controller.cancel,
                    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                    child: const Text('BATAL'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
