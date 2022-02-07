import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/feature/app/presentation/getx/controller/scroll_top_button_controller.dart';
import 'package:gocery/feature/product/domain/entity/index_product_param_entity.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_filter_controller.dart';

class ProductPageController extends GetxController {
  ProductPageController() {
    scrollController = ScrollController();

    productFilterController =
        Get.put(ProductFilterController(), tag: 'ProductPage');

    scrollTopButtonController = Get.put(
        ScrollTopButtonController(scrollController: scrollController),
        tag: 'ProductPage');
  }

  late final ScrollController scrollController;
  late final ProductFilterController productFilterController;
  late final ScrollTopButtonController scrollTopButtonController;

  void initListener() {
    //PRODUCT FILTER LISTENER
    debounce(productFilterController.filter, (IndexProductParamEntity filter) {
      //
    }, time: const Duration(milliseconds: 500));
  }

  void init() {}

  @override
  void onInit() {
    initListener();

    init();

    super.onInit();
  }
}
