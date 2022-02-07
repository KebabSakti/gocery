import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_filter_controller.dart';

class ProductPageController extends GetxController {
  final productFilterController =
      Get.put(ProductFilterController(), tag: 'ProductPage');

  @override
  void onInit() {
    debounce(productFilterController.mValue, (String value) {
      debugPrint(value);
    }, time: const Duration(milliseconds: 200));

    super.onInit();
  }
}
