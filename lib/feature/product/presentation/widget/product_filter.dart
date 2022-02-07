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
        FilterChip(
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text('Terjadwal'),
          ),
          selected: true,
          elevation: 0,
          labelStyle: const TextStyle(color: kPrimaryColor),
          checkmarkColor: kPrimaryColor,
          shadowColor: Colors.transparent,
          selectedShadowColor: Colors.transparent,
          backgroundColor: kLightColor,
          selectedColor: kPrimaryColor.withOpacity(0.3),
          onSelected: (value) {
            controller.setValue('Terjadwal');
          },
        ),
        const SizedBox(width: kSmallPadding),
        FilterChip(
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text('Langsung'),
          ),
          selected: true,
          elevation: 0,
          labelStyle: const TextStyle(color: kPrimaryColor),
          checkmarkColor: kPrimaryColor,
          shadowColor: Colors.transparent,
          selectedShadowColor: Colors.transparent,
          backgroundColor: kLightColor,
          selectedColor: kPrimaryColor.withOpacity(0.3),
          onSelected: (value) {
            controller.setValue('Langsung');
          },
        ),
        const SizedBox(width: kSmallPadding),
        ChoiceChip(
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text('Terlaris'),
          ),
          selected: false,
          elevation: 0,
          shadowColor: Colors.transparent,
          selectedShadowColor: Colors.transparent,
          backgroundColor: kLightColor,
          onSelected: (value) {
            controller.setValue('Terlaris');
          },
        ),
        const SizedBox(width: kSmallPadding),
        ChoiceChip(
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text('Termurah'),
          ),
          selected: false,
          elevation: 0,
          shadowColor: Colors.transparent,
          selectedShadowColor: Colors.transparent,
          backgroundColor: kLightColor,
          onSelected: (value) {},
        ),
        const SizedBox(width: kSmallPadding),
        ChoiceChip(
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text('Diskon'),
          ),
          selected: false,
          elevation: 0,
          shadowColor: Colors.transparent,
          selectedShadowColor: Colors.transparent,
          backgroundColor: kLightColor,
          onSelected: (value) {},
        ),
        const SizedBox(width: kSmallPadding),
        ChoiceChip(
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text('Banyak Point'),
          ),
          selected: false,
          elevation: 0,
          shadowColor: Colors.transparent,
          selectedShadowColor: Colors.transparent,
          backgroundColor: kLightColor,
          onSelected: (value) {},
        ),
        const SizedBox(width: kSmallPadding),
        ChoiceChip(
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text('Lagi Trending'),
          ),
          selected: true,
          elevation: 0,
          shadowColor: Colors.transparent,
          selectedShadowColor: Colors.transparent,
          backgroundColor: kLightColor,
          onSelected: (value) {},
        ),
      ],
    );
  }
}
