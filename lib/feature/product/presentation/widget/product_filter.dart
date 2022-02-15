import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_filter_controller.dart';

class ProductFilter extends GetView<ProductFilterController> {
  const ProductFilter({Key? key, required this.controllerKey})
      : super(key: key);

  final String controllerKey;

  @override
  String? get tag => controllerKey;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        ActionChip(
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: const [
                Icon(
                  AppIcon.slidercircleh,
                  size: 20,
                ),
                SizedBox(width: 6),
                Text('Semua Filter'),
              ],
            ),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: kLightColor,
          onPressed: () {},
        ),
        const SizedBox(width: kSmallPadding),
        Obx(() {
          return ChoiceChip(
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text('Terjadwal'),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            selectedShadowColor: Colors.transparent,
            backgroundColor: kLightColor,
            selected: controller.filter().shipping == 'TERJADWAL',
            onSelected: (value) {
              final param = controller
                  .filter()
                  .copyWith(shipping: value ? 'TERJADWAL' : '');

              controller.filter(param);
            },
          );
        }),
        const SizedBox(width: kSmallPadding),
        Obx(() {
          return ChoiceChip(
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text('Langsung'),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            selectedShadowColor: Colors.transparent,
            backgroundColor: kLightColor,
            selected: controller.filter().shipping == 'LANGSUNG',
            onSelected: (value) {
              final param = controller
                  .filter()
                  .copyWith(shipping: value ? 'LANGSUNG' : '');

              controller.filter(param);
            },
          );
        }),
        const SizedBox(width: kSmallPadding),
        Obx(() {
          return ChoiceChip(
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text('Terlaris'),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            selectedShadowColor: Colors.transparent,
            backgroundColor: kLightColor,
            selected: controller.filter().sorting == 'sold',
            onSelected: (value) {
              final param =
                  controller.filter().copyWith(sorting: value ? 'sold' : '');

              controller.filter(param);
            },
          );
        }),
        const SizedBox(width: kSmallPadding),
        Obx(() {
          return ChoiceChip(
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text('Termurah'),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            selectedShadowColor: Colors.transparent,
            backgroundColor: kLightColor,
            selected: controller.filter().sorting == 'price',
            onSelected: (value) {
              final param =
                  controller.filter().copyWith(sorting: value ? 'price' : '');

              controller.filter(param);
            },
          );
        }),
        const SizedBox(width: kSmallPadding),
        Obx(() {
          return ChoiceChip(
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text('Diskon'),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            selectedShadowColor: Colors.transparent,
            backgroundColor: kLightColor,
            selected: controller.filter().sorting == 'discount',
            onSelected: (value) {
              final param = controller
                  .filter()
                  .copyWith(sorting: value ? 'discount' : '');

              controller.filter(param);
            },
          );
        }),
        const SizedBox(width: kSmallPadding),
        Obx(() {
          return ChoiceChip(
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text('Banyak Point'),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            selectedShadowColor: Colors.transparent,
            backgroundColor: kLightColor,
            selected: controller.filter().sorting == 'point',
            onSelected: (value) {
              final param =
                  controller.filter().copyWith(sorting: value ? 'point' : '');

              controller.filter(param);
            },
          );
        }),
        const SizedBox(width: kSmallPadding),
        Obx(() {
          return ChoiceChip(
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text('Lagi Trending'),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            selectedShadowColor: Colors.transparent,
            backgroundColor: kLightColor,
            selected: controller.filter().sorting == 'view',
            onSelected: (value) {
              final param =
                  controller.filter().copyWith(sorting: value ? 'view' : '');

              controller.filter(param);
            },
          );
        }),
        const SizedBox(width: kSmallPadding),
        Obx(() {
          return ChoiceChip(
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text('Populer'),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            selectedShadowColor: Colors.transparent,
            backgroundColor: kLightColor,
            selected: controller.filter().sorting == 'search',
            onSelected: (value) {
              final param =
                  controller.filter().copyWith(sorting: value ? 'search' : '');

              controller.filter(param);
            },
          );
        }),
      ],
    );
  }
}
