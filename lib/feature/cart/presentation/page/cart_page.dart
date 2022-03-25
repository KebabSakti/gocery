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
                Obx(() {
                  return (!controller.outOfStock())
                      ? const SizedBox.shrink()
                      : Container(
                          padding: const EdgeInsets.all(kMediumPadding),
                          decoration: BoxDecoration(
                              color: kPrimaryColor100,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      1, 1), // changes position of shadow
                                ),
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(
                                AppIcon.infocircle,
                                color: Colors.amber,
                              ),
                              SizedBox(width: kSmallPadding),
                              Expanded(
                                child: Text(
                                    'Beberapa produk dalam keranjang anda kehabisan stok, update keranjang belanjaan untuk melanjutkan'),
                              ),
                            ],
                          ),
                        );
                }),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(kMediumPadding),
                    itemCount: cartItems.length,
                    separatorBuilder: (context, index) =>
                        const Divider(color: Colors.transparent),
                    itemBuilder: (context, index) {
                      final CartItemEntity cartItem = cartItems[index];

                      return Ink(
                        key: ValueKey(cartItem.productUid),
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
                              child: SizedBox(
                                height: 70,
                                width: 70,
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: cartItem.productModel!.image!,
                                      fit: BoxFit.cover,
                                    ),
                                    (cartItem.productModel!.stok! > 0)
                                        ? const SizedBox.shrink()
                                        : Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Opacity(
                                                opacity: 0.8,
                                                child: Image.asset(
                                                  kSoldOut,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: kMediumPadding),
                            Expanded(
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              style:
                                                  Get.theme.textTheme.bodyText1,
                                            ),
                                          ),
                                          const SizedBox(width: kMediumPadding),
                                          IconButton(
                                            onPressed: () {
                                              controller.removeItem(
                                                  param: cartItem);
                                            },
                                            padding: const EdgeInsets.all(0),
                                            constraints: const BoxConstraints(),
                                            icon: const Icon(
                                              AppIcon.closecircle,
                                              color: Colors.red,
                                            ),
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
                                              color: (cartItem.productModel!
                                                          .shipping ==
                                                      'TERJADWAL')
                                                  ? Colors.blue
                                                  : kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              '${cartItem.productModel!.shipping}',
                                              style: Get.textTheme.overline,
                                            ),
                                          ),
                                          (cartItem.productModel!.stok! == 0)
                                              ? const SizedBox.shrink()
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: kPrimaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .decrementItem(
                                                                  param:
                                                                      cartItem);
                                                        },
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        constraints:
                                                            const BoxConstraints(),
                                                        icon: const Icon(
                                                            AppIcon.minus),
                                                      ),
                                                      Text(
                                                        '${cartItem.itemQtyTotal}',
                                                        style: Get
                                                            .theme
                                                            .textTheme
                                                            .bodyText1,
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .incrementItem(
                                                                  param:
                                                                      cartItem);
                                                        },
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        constraints:
                                                            const BoxConstraints(),
                                                        icon: const Icon(
                                                            AppIcon.plus),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                        ],
                                      ),
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
                Obx(() {
                  return Material(
                    color:
                        (controller.outOfStock()) ? Colors.grey : kPrimaryColor,
                    child: Ink(
                      height: 56,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kMediumPadding),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total',
                                    style: Get.theme.textTheme.caption,
                                  ),
                                  Text(
                                    Utility.currency(controller.cartController
                                        .priceTotal()
                                        .toString()),
                                    style: Get.theme.textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (controller.outOfStock())
                                ? null
                                : () {
                                    controller.toCheckoutPage(param: cartItems);
                                  },
                            overlayColor: MaterialStateProperty.resolveWith(
                                (_) => kPrimaryColor400),
                            child: Ink(
                              padding: const EdgeInsets.all(kMediumPadding),
                              child: Row(
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
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ],
            );
          }

          return _emptyCart(controller: controller);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );

        // return ListView.separated(
        //   shrinkWrap: true,
        //   padding: const EdgeInsets.all(kMediumPadding),
        //   itemCount: 5,
        //   separatorBuilder: (context, index) => const Divider(
        //     color: Colors.transparent,
        //   ),
        //   itemBuilder: (context, index) {
        //     return const ShimmerLoader(height: 150);
        //   },
        // );
      }),
    );
  }
}

Widget _emptyCart({required CartPageController controller}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(kBigPadding),
          decoration: BoxDecoration(
            color: kLightColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            AppIcon.shoppingcart,
            size: 100,
            color: kLightColor100,
          ),
        ),
        const SizedBox(height: kBigPadding),
        SizedBox(
          width: 300,
          child: Text(
            'Yah, keranjang belanjanya masih kosong, yuk belanja dulu',
            textAlign: TextAlign.center,
            style: Get.theme.textTheme.headline2,
          ),
        ),
        const SizedBox(height: kHugePadding),
        SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              controller.appPageController.activePage(0);
            },
            child: const Text('Mulai Belanja'),
          ),
        ),
      ],
    ),
  );
}
