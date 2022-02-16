import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/presentation/getx/controller/cart_page_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  final CartPageController controller = Get.put(CartPageController());

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: Obx(() {
        final cartState = controller.cartController.cartItemState();

        if (cartState.status == Status.success) {
          final List<CartItemEntity> cartItems = cartState.data!;

          if (cartItems.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(kMediumPadding),
                    itemCount: cartItems.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.transparent,
                    ),
                    itemBuilder: (context, index) {
                      final CartItemEntity cartItem = cartItems[index];

                      return Container(
                        padding: const EdgeInsets.all(kMediumPadding),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xffEBF0F9)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: cartItem.productModel!.image!,
                                width: 70,
                              ),
                            ),
                            const SizedBox(width: kMediumPadding),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          cartItem.productModel!.name!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Get.theme.textTheme.bodyText1,
                                        ),
                                      ),
                                      const SizedBox(width: kMediumPadding),
                                      const Icon(
                                        AppIcon.closecircle,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: kTinyPadding),
                                  Text(
                                    'Harga per ${cartItem.itemQtyTotal} ${cartItem.productModel!.unit}',
                                    style: Get.theme.textTheme.bodyText2!
                                        .copyWith(fontSize: kSmallFont),
                                  ),
                                  const SizedBox(height: kTinyPadding),
                                  Text(
                                    Utility.currency(
                                        cartItem.itemPriceTotal.toString()),
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
                                          color: Colors.blue.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          '${cartItem.productModel!.shipping}',
                                          style: Get.textTheme.overline,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: kPrimaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {},
                                                child:
                                                    const Icon(AppIcon.minus)),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: Text(
                                                '${cartItem.itemQtyTotal}',
                                                style: Get
                                                    .theme.textTheme.bodyText1,
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  controller.incrementItem(
                                                      param: cartItem);
                                                },
                                                child:
                                                    const Icon(AppIcon.plus)),
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
                      );
                    },
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(kCheckoutPage);
                    },
                    child: Ink(
                      color: kPrimaryColor,
                      height: 56,
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMediumPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total',
                                style: Get.theme.textTheme.caption,
                              ),
                              Text(
                                'Rp 20.000',
                                style: Get.theme.textTheme.caption,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Lanjut',
                                style: Get.theme.textTheme.caption,
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                AppIcon.arrowright,
                                color: kLightColor,
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return _emptyCart();
        }

        return _emptyCart();
      }),
    );
  }
}

Widget _emptyCart() {
  return const SizedBox.shrink();
}
