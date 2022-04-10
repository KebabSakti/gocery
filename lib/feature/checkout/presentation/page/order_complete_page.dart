import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderCompletePage extends StatelessWidget {
  const OrderCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(kAppPage);

        return false;
      },
      child: Scaffold(
        backgroundColor: kLightColor,
        body: Padding(
          padding: const EdgeInsets.all(kMediumPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Order Berhasil',
                  style: Get.textTheme.headline1,
                ),
                const SizedBox(height: kBigPadding),
                Text(
                  'Orderan anda berhasil di proses, lihat status orderan kamu di halaman order',
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.headline2,
                ),
                const SizedBox(height: kHugePadding),
                SvgPicture.asset(kOrderComplete, height: 250),
                const SizedBox(height: kHugePadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.offAllNamed(kAppPage, arguments: 1);
                        },
                        child: Row(
                          children: const [
                            Icon(AppIcon.clipboard),
                            SizedBox(width: kTinyPadding),
                            Text('Order'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: kTinyPadding),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          await launch(
                              'https://checkout-staging.xendit.co/web/61e273d5b088a50b28578f82',
                              forceWebView: true,
                              enableJavaScript: true);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kLightColor,
                          onPrimary: kLightColor100,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            side: BorderSide(color: kPrimaryColor),
                          ),
                        ),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://res.cloudinary.com/vjtechsolution/image/upload/v1627370426/ayo%20mobile/AnyConv.com__bniva.png',
                              height: 15,
                            ),
                            const SizedBox(width: kTinyPadding),
                            Text(
                              'Bayar',
                              style: Get.textTheme.headline4,
                            ),
                          ],
                        ),
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
