import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/feature/bundle/domain/entity/bundle_entity.dart';
import 'package:gocery/feature/product/presentation/widget/product_item.dart';

class BundleItem extends StatelessWidget {
  const BundleItem({
    Key? key,
    required this.bundle,
  }) : super(key: key);

  final BundleEntity bundle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              bundle.name!,
              style: Get.textTheme.headline3,
            ),
            Text(
              'Lihat Semua',
              style: Get.textTheme.headline4,
            )
          ],
        ),
        const SizedBox(height: kSmallPadding),
        Text(
          bundle.description!,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: kMediumPadding),
        SizedBox(
          height: 300,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                  right: (index >= 0 && index < 9) ? kMediumPadding : 0),
              child: ProductItem(
                product: bundle.products![index],
                onProductTap: () {
                  Get.toNamed(kProductDetailPage,
                      arguments: bundle.products![index]);
                },
                onFavouriteTap: () {},
                onBuyTap: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
