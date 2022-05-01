import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:gocery/core/config/app_const.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('Pembayaran'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(kMediumPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://res.cloudinary.com/vjtechsolution/image/upload/v1645681088/ayo%20mobile/Logo_ovo_purple.svg.png',
                        height: 20,
                      ),
                      CountdownTimer(endTime: endTime),
                    ],
                  ),
                  const SizedBox(height: kMediumPadding),
                  Container(
                    height: 300,
                    width: double.infinity,
                    padding: const EdgeInsets.all(kMediumPadding),
                    decoration: BoxDecoration(
                      color: kLightColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kLightColor50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
