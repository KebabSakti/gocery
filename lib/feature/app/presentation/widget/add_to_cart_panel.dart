import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/feature/app/presentation/getx/controller/add_to_cart_panel_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddToCartPanel extends GetView<AddToCartPanelController> {
  const AddToCartPanel({
    Key? key,
    required this.controllerKey,
  }) : super(key: key);

  final String controllerKey;

  @override
  String? get tag => controllerKey;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: controller.panelController,
      minHeight: 0,
      maxHeight: 300,
      backdropEnabled: true,
      backdropColor: kDarkColor,
      backdropTapClosesPanel: true,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(1, 1), // changes position of shadow
        ),
      ],
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      panel: Obx(() {
        final cartItem = controller.cartItem();

        if (cartItem.productModel != null) {
          return Material(
            color: Colors.transparent,
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(kMediumPadding),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                controller.panelController.close();
                              },
                              child: Ink(
                                child: const Icon(
                                  AppIcon.close,
                                  color: kLightColor100,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: kMediumPadding),
                        Text(
                          'Beli Produk',
                          style: Get.textTheme.headline3,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1),
                Builder(builder: (context) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(kBigPadding),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${controller.cartItem().productModel!.image}',
                                  width: 70,
                                ),
                              ),
                              const SizedBox(width: kMediumPadding),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.cartItem().productModel!.name}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Get.theme.textTheme.bodyText1,
                                    ),
                                    const SizedBox(height: kTinyPadding),
                                    Text(
                                      'Harga per ${controller.cartItem().itemQtyTotal} ${controller.cartItem().productModel!.unit}',
                                      style: Get.theme.textTheme.bodyText2!
                                          .copyWith(fontSize: kSmallFont),
                                    ),
                                    const SizedBox(height: kTinyPadding),
                                    Text(
                                      Utility.currency(controller
                                          .cartItem()
                                          .itemPriceTotal
                                          .toString()),
                                      style: Get.theme.textTheme.bodyText1!
                                          .copyWith(color: kPrimaryColor),
                                    ),
                                    const SizedBox(height: kSmallPadding),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: (controller
                                                        .cartItem()
                                                        .productModel!
                                                        .shipping ==
                                                    'TERJADWAL')
                                                ? Colors.blue
                                                : kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            '${controller.cartItem().productModel!.shipping}',
                                            style: Get.textTheme.overline,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kPrimaryColor),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  controller.decrementItem(
                                                      param: controller
                                                          .cartItem());
                                                },
                                                padding:
                                                    const EdgeInsets.all(0),
                                                constraints:
                                                    const BoxConstraints(),
                                                icon: const Icon(AppIcon.minus),
                                              ),
                                              Text(
                                                '${controller.cartItem().itemQtyTotal}',
                                                style: Get
                                                    .theme.textTheme.bodyText1,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  controller.incrementItem(
                                                      param: controller
                                                          .cartItem());
                                                },
                                                padding:
                                                    const EdgeInsets.all(0),
                                                constraints:
                                                    const BoxConstraints(),
                                                icon: const Icon(AppIcon.plus),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.toCheckoutPage(
                                    param: controller.cartItem());
                              },
                              child: const Text('Checkout Produk Ini'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
