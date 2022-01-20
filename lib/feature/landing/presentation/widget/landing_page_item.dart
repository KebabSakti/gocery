import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';

class LandingPageItem extends StatelessWidget {
  const LandingPageItem({
    Key? key,
    required this.asset,
    required this.title,
    required this.body,
    required this.button,
    this.onPressed,
  }) : super(key: key);

  final String asset;
  final String title;
  final String body;
  final String button;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          asset,
          height: Get.size.height / 3,
        ),
        const SizedBox(height: kBigPadding),
        Text(
          title,
          style: Get.theme.textTheme.headline1,
        ),
        const SizedBox(height: kBigPadding),
        Text(
          body,
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.headline2,
        ),
        const SizedBox(height: kHugePadding),
        SizedBox(
          width: 217,
          height: 44,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(button),
          ),
        )
      ],
    );
  }
}
