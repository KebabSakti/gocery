import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/feature/app/presentation/getx/controller/scroll_top_button_controller.dart';

class ScrollTopButton extends GetView<ScrollTopButtonController> {
  const ScrollTopButton({Key? key, required this.controllerKey})
      : super(key: key);

  final String controllerKey;

  @override
  String? get tag => controllerKey;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TweenAnimationBuilder(
        curve: Curves.bounceOut,
        duration: const Duration(milliseconds: 300),
        tween: Tween<double>(
          begin: 0.0,
          end: controller.endTween.value,
        ),
        child: GestureDetector(
          child: Opacity(
            opacity: 1.0,
            child: SvgPicture.asset(
              kScrollTopButtonIcon,
              width: 45,
              height: 45,
            ),
          ),
          onTap: controller.scrollToTop,
        ),
        builder: (BuildContext context, double scale, Widget? child) =>
            Transform.scale(
          scale: scale,
          child: child,
        ),
      );
    });
  }
}
