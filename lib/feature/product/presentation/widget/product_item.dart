import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_item_controller.dart';

class ProductItem extends StatelessWidget {
  late final ProductItemController controller;

  ProductItem({
    Key? key,
    required this.product,
    this.onProductTap,
    this.onFavouriteTap,
    this.onBuyTap,
  }) : super(key: key) {
    controller = Get.put(ProductItemController());
  }

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
                      Obx(() {
                        int productIndex =
                            controller.cartController.getIndex(param: product);

                        if (productIndex >= 0) {
                          final CartItemEntity cartItem = controller
                              .cartController
                              .cartItemState()
                              .data![productIndex];

                          return Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 35,
                              width: 35,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(kTinyPadding),
                              decoration: BoxDecoration(
                                color: kLightColor50,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: const Offset(
                                        1, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3),
                                    child: Icon(AppIcon.shoppingcart),
                                  ),
                                  Positioned(
                                    right: 1,
                                    child: ClipOval(
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        color: Colors.redAccent,
                                        child: Center(
                                          child: Text(
                                            cartItem.itemQtyTotal!.toString(),
                                            style: const TextStyle(
                                              color: kLightColor,
                                              fontSize: 7,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      }),
                      (product.stok! > 0)
                          ? const SizedBox.shrink()
                          : Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(kSmallPadding),
                                child: Opacity(
                                  opacity: 0.8,
                                  child: Image.asset(kSoldOut, width: 120),
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
                      height: 28,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: product.stok == 0 ? null : onBuyTap,
                        child: const Text('Beli'),
                      ),
                      // child: Obx(() {
                      //   int productIndex = controller.cartController
                      //       .getIndex(param: product);

                      //   if (productIndex >= 0) {
                      //     final CartItemEntity cartItem = controller
                      //         .cartController
                      //         .cartItemState()
                      //         .data![productIndex];

                      //     return Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         ElevatedButton(
                      //           onPressed: () {
                      //             controller.decrementItem(param: cartItem);
                      //           },
                      //           child: const Icon(AppIcon.minus, size: 16),
                      //           style: ElevatedButton.styleFrom(
                      //             shape: const CircleBorder(),
                      //             primary: kPrimaryColor,
                      //             onPrimary: kPrimaryColor100,
                      //           ),
                      //         ),
                      //         Text(cartItem.itemQtyTotal!.toString(),
                      //             style: Get.textTheme.bodyText1),
                      //         ElevatedButton(
                      //           onPressed: () {
                      //             controller.incrementItem(param: cartItem);
                      //           },
                      //           child: const Icon(AppIcon.plus, size: 16),
                      //           style: ElevatedButton.styleFrom(
                      //             shape: const CircleBorder(),
                      //             primary: kPrimaryColor,
                      //             onPrimary: kPrimaryColor100,
                      //           ),
                      //         ),
                      //       ],
                      //     );
                      //   }

                      //   return ElevatedButton(
                      //     onPressed: product.stok == 0
                      //         ? null
                      //         : () {
                      //             controller.addToCart(param: product);
                      //           },
                      //     child: const Text('Beli'),
                      //   );
                      // }),
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
