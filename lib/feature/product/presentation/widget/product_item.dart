import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
    this.onProductTap,
    this.onFavouriteTap,
    this.onBuyTap,
  }) : super(key: key);

  final ProductEntity product;
  final VoidCallback? onProductTap;
  final VoidCallback? onFavouriteTap;
  final VoidCallback? onBuyTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onProductTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          width: (Get.size.width - 70) / 2,
          decoration: BoxDecoration(
            color: kLightColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: SizedBox(
                  height: 125,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: product.image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: (context, url) => const ShimmerLoader(),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SizedBox(
                            width: 32,
                            height: 32,
                            child: Material(
                              color: const Color(0xff121924).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                child: (product.favourite!)
                                    ? const Icon(
                                        AppIcon.heartfill,
                                        color: Colors.red,
                                        size: 20,
                                      )
                                    : const Icon(
                                        AppIcon.heart,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                onTap: onFavouriteTap,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              color: (product.shipping! == 'TERJADWAL')
                                  ? Colors.blue.withOpacity(0.8)
                                  : kPrimaryColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              product.shipping!,
                              style: Get.textTheme.overline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 175,
                padding: const EdgeInsets.all(kSmallPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Get.theme.textTheme.bodyText1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(kCoinIcon, width: 15, height: 15),
                        const SizedBox(width: 4),
                        Text(
                          '${product.point}',
                          textAlign: TextAlign.center,
                          style: Get.theme.textTheme.caption!
                              .copyWith(color: Colors.amber),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Harga per ${product.unitCount} ${product.unit}',
                          textAlign: TextAlign.center,
                          style: Get.theme.textTheme.bodyText2!.copyWith(
                            fontSize: kSmallFont,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          Utility.currency(product.price!),
                          style: Get.theme.textTheme.bodyText2?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            fontSize: kSmallFont,
                            color: kErrorColor,
                          ),
                        ),
                        Text(
                          Utility.currency(product.finalPrice!),
                          style: Get.theme.textTheme.bodyText1!
                              .copyWith(color: kPrimaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onBuyTap,
                        child: const Text('Beli'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
