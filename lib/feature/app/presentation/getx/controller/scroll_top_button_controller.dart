import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollTopButtonController extends GetxController {
  ScrollTopButtonController({required this.scrollController});

  final ScrollController scrollController;

  final RxDouble endTween = 0.0.obs;

  void _scrollListener() {
    endTween.value = (scrollController.offset > 1500) ? 1.0 : 0.0;
  }

  void scrollToTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);

    super.onInit();
  }
}
