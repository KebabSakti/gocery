import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/app/presentation/widget/add_to_cart_panel.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/product/data/model/index_product_param_model.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_detail_page_controller.dart';
import 'package:gocery/feature/product/presentation/widget/product_item.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({Key? key}) : super(key: key) {
    controller = Get.put(
        ProductDetailPageController(controllerTag: controllerTag),
        tag: controllerTag);
  }

  final String controllerTag = Utility.randomUid();

  late final ProductDetailPageController controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onBackButtonPressed,
      child: Scaffold(
        backgroundColor: kLightColor,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: controller.scrollController,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: Get.size.height / 2.5,
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        Obx(() {
                          if (controller.productState().status ==
                              Status.success) {
                            return Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      controller.productState().data!.image!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  placeholder: (context, url) =>
                                      const ShimmerLoader(),
                                ),
                                (controller.productState().data!.stok! > 0)
                                    ? const SizedBox.shrink()
                                    : Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              kHugePadding),
                                          child: Opacity(
                                            opacity: 0.8,
                                            child: Image.asset(
                                              kSoldOut,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                Obx(() {
                                  int productIndex = controller.cartController
                                      .getIndex(
                                          param:
                                              controller.productState().data!);

                                  if (productIndex >= 0) {
                                    final CartItemEntity cartItem = controller
                                        .cartController
                                        .cartItemState()
                                        .data![productIndex];

                                    return Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: kMediumPadding,
                                            vertical: kHugePadding),
                                        decoration: BoxDecoration(
                                          color: kLightColor50,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              offset: const Offset(1,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Stack(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3),
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
                                                      cartItem.itemQtyTotal!
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: kLightColor,
                                                        fontSize: 7,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                              ],
                            );
                          }

                          return const ShimmerLoader();
                        }),
                        SafeArea(
                          child: SizedBox(
                            height: 56,
                            child: AppBar(
                              backgroundColor: Colors.transparent,
                              iconTheme:
                                  const IconThemeData(color: kLightColor),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: (Get.size.height / 2.5) - 16,
                    ),
                    decoration: const BoxDecoration(
                      color: kLightColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(kMediumPadding),
                      child: Column(
                        children: [
                          Obx(() {
                            if (controller.productState().status ==
                                Status.success) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller.productState().data!.name!,
                                          style: Get.textTheme.headline3,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: (controller
                                                        .productState()
                                                        .data!
                                                        .shipping! ==
                                                    'TERJADWAL')
                                                ? Colors.blue.withOpacity(0.8)
                                                : kPrimaryColor
                                                    .withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            controller
                                                .productState()
                                                .data!
                                                .shipping!,
                                            style: Get.textTheme.overline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: kTinyPadding),
                                  Text(
                                    'Harga per ${controller.productState().data!.unitCount!} ${controller.productState().data!.unit!}',
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  const SizedBox(height: kTinyPadding),
                                  Row(
                                    children: [
                                      Text(
                                        Utility.currency(controller
                                            .productState()
                                            .data!
                                            .finalPrice!),
                                        style: Get.theme.textTheme.headline3!
                                            .copyWith(color: kPrimaryColor),
                                      ),
                                      const SizedBox(width: kTinyPadding),
                                      Text(
                                        Utility.currency(controller
                                            .productState()
                                            .data!
                                            .price!),
                                        style: Get.theme.textTheme.bodyText2
                                            ?.copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: kErrorColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: kTinyPadding),
                                  Row(
                                    children: [
                                      SvgPicture.asset(kCoinIcon,
                                          width: 20, height: 20),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${controller.productState().data!.point!}',
                                        textAlign: TextAlign.center,
                                        style: Get.theme.textTheme.headline3!
                                            .copyWith(color: Colors.amber),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: kMediumPadding),
                                  Row(
                                    children: [
                                      _statisticItem(
                                          icon: const Icon(
                                            AppIcon.heart,
                                            color: kPrimaryColor,
                                            size: 30,
                                          ),
                                          value:
                                              '${controller.productState().data!.productStatisticModel!.favourite}'),
                                      const SizedBox(width: kMediumPadding),
                                      _statisticItem(
                                          icon: const Icon(
                                            AppIcon.eye,
                                            color: kPrimaryColor,
                                            size: 30,
                                          ),
                                          value:
                                              '${controller.productState().data!.productStatisticModel!.view}'),
                                      const SizedBox(width: kMediumPadding),
                                      _statisticItem(
                                          icon: const Icon(
                                            AppIcon.coin,
                                            color: kPrimaryColor,
                                            size: 28,
                                          ),
                                          value:
                                              '${controller.productState().data!.productStatisticModel!.sold}'),
                                    ],
                                  ),
                                  const SizedBox(height: kMediumPadding),
                                  ExpandableText(
                                    controller
                                        .productState()
                                        .data!
                                        .description!,
                                    textAlign: TextAlign.justify,
                                    expandText: 'tampilkan',
                                    collapseText: 'sembunyikan',
                                    maxLines: 4,
                                    linkColor: Colors.blue,
                                  ),
                                  const SizedBox(height: kBigPadding),
                                  Row(
                                    children: [
                                      (controller.favourite())
                                          ? SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Transform.scale(
                                                  scale: 0.7,
                                                  child:
                                                      const CircularProgressIndicator()))
                                          : ClipOval(
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.productFavourite(
                                                        uid: controller
                                                            .productState()
                                                            .data!
                                                            .uid!);
                                                  },
                                                  child: Ink(
                                                    child: Icon(
                                                      AppIcon.heartfill,
                                                      color: controller
                                                              .productState()
                                                              .data!
                                                              .favourite!
                                                          ? Colors.red
                                                          : kLightColor50,
                                                      size: 40,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                      const SizedBox(width: kMediumPadding),
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 45,
                                          child: ElevatedButton(
                                            onPressed: (controller
                                                        .productState()
                                                        .data!
                                                        .stok ==
                                                    0)
                                                ? null
                                                : () {
                                                    controller
                                                        .addToCartPanelController
                                                        .showPanel(
                                                            param: controller
                                                                .productState()
                                                                .data!);
                                                  },
                                            child: const Text(
                                                'Tambah ke keranjang'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    ShimmerLoader(width: 200, height: 20),
                                    SizedBox(width: 4),
                                    Padding(
                                      padding: EdgeInsets.all(4),
                                      child:
                                          ShimmerLoader(width: 100, height: 20),
                                    ),
                                  ],
                                ),
                                const ShimmerLoader(width: 180, height: 20),
                                const SizedBox(height: kTinyPadding),
                                const ShimmerLoader(width: 150, height: 20),
                                const SizedBox(height: kTinyPadding),
                                const ShimmerLoader(width: 100, height: 20),
                                const SizedBox(height: kMediumPadding),
                                Row(
                                  children: const [
                                    ShimmerLoader(width: 100, height: 20),
                                    SizedBox(width: kMediumPadding),
                                    ShimmerLoader(width: 100, height: 20),
                                    SizedBox(width: kMediumPadding),
                                    ShimmerLoader(width: 100, height: 20),
                                  ],
                                ),
                                const SizedBox(height: kMediumPadding),
                                const ShimmerLoader(width: 300, height: 10),
                                const SizedBox(height: kTinyPadding),
                                const ShimmerLoader(width: 280, height: 10),
                                const SizedBox(height: kTinyPadding),
                                const ShimmerLoader(width: 250, height: 10),
                                const SizedBox(height: kTinyPadding),
                                const ShimmerLoader(width: 280, height: 10),
                                const SizedBox(height: kTinyPadding),
                                const ShimmerLoader(width: 300, height: 10),
                                const SizedBox(height: kBigPadding),
                                Row(
                                  children: const [
                                    ShimmerLoader(
                                        width: 40, height: 40, radius: 40),
                                    SizedBox(width: kMediumPadding),
                                    Expanded(child: ShimmerLoader(height: 45)),
                                  ],
                                ),
                              ],
                            );
                          }),
                          const SizedBox(height: kLargePadding),
                          Obx(() {
                            var _crossAxisSpacing = kMediumPadding;
                            var _mainAxisSpacing = kMediumPadding;
                            var _screenWidth = Get.size.width;
                            var _crossAxisCount = 2;
                            var _width = (_screenWidth -
                                    ((_crossAxisCount - 1) *
                                        _crossAxisSpacing)) /
                                _crossAxisCount;
                            var _cellHeight = 660 / 2;
                            var _aspectRatio = _width / _cellHeight;

                            if (controller.productsSimiliarState().status ==
                                Status.success) {
                              final List<ProductEntity> productSimiliar =
                                  controller
                                      .productsSimiliarState()
                                      .data!
                                      .data!;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Produk Sejenis',
                                        style: Get.textTheme.headline3,
                                      ),
                                      GestureDetector(
                                        child: Text(
                                          'Lihat Semua',
                                          style: Get.textTheme.headline4,
                                        ),
                                        onTap: () {
                                          controller.toProductPage(
                                              param: IndexProductParamModel(
                                                  category: productSimiliar[0]
                                                      .categoryUid));
                                        },
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: kMediumPadding),
                                  MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: _crossAxisCount,
                                        crossAxisSpacing: _crossAxisSpacing,
                                        mainAxisSpacing: _mainAxisSpacing,
                                        childAspectRatio: _aspectRatio,
                                      ),
                                      itemCount: productSimiliar.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kLightColor50),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ProductItem(
                                            product: productSimiliar[index],
                                            onProductTap: () {
                                              controller.toProductDetail(
                                                  productEntity:
                                                      productSimiliar[index]);
                                            },
                                            onFavouriteTap: () {},
                                            onBuyTap: () {
                                              controller
                                                  .addToCartPanelController
                                                  .showPanel(
                                                      param: productSimiliar[
                                                          index]);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const ShimmerLoader(width: 100, height: 20),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: _crossAxisCount,
                                    crossAxisSpacing: _crossAxisSpacing,
                                    mainAxisSpacing: _mainAxisSpacing,
                                    childAspectRatio: _aspectRatio,
                                  ),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: kLightColor50),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const ShimmerLoader(),
                                    );
                                  },
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AddToCartPanel(controllerKey: controllerTag),
          ],
        ),
      ),
    );
  }
}

Widget _statisticItem({required Icon icon, required String value}) {
  return Row(
    children: [
      icon,
      const SizedBox(width: 4),
      Text(value, style: Get.textTheme.headline3),
    ],
  );
}
