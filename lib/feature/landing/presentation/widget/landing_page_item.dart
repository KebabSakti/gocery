import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          asset,
          height: Get.size.height / 3,
        ),
        Text(
          title,
          style: Get.theme.textTheme.headline4,
        ),
        SizedBox(
          width: Get.size.width / 1.3,
          child: Text(
            body,
            textAlign: TextAlign.center,
            style: Get.theme.textTheme.headline6,
          ),
        ),
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
