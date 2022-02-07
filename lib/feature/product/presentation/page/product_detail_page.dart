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
import 'package:gocery/feature/product/presentation/getx/controller/product_detail_page_controller.dart';
import 'package:gocery/feature/product/presentation/widget/product_item.dart';

class ProductDetailPage extends GetView<ProductDetailPageController> {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightColor,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: Get.size.height / 2.5,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Obx(() {
                    if (controller.productState().status == Status.success) {
                      return CachedNetworkImage(
                        imageUrl: controller.productState().data!.image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: (context, url) => const ShimmerLoader(),
                      );
                    }

                    return const ShimmerLoader();
                  }),
                  SafeArea(
                    child: SizedBox(
                      height: 56,
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        iconTheme: const IconThemeData(color: kLightColor),
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
                      if (controller.productState().status == Status.success) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          : kPrimaryColor.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      controller.productState().data!.shipping!,
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
                                  Utility.currency(
                                      controller.productState().data!.price!),
                                  style: Get.theme.textTheme.bodyText2
                                      ?.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough),
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
                              controller.productState().data!.description!,
                              textAlign: TextAlign.justify,
                              expandText: 'tampilkan',
                              collapseText: 'sembunyikan',
                              maxLines: 4,
                              linkColor: Colors.blue,
                            ),
                            const SizedBox(height: kBigPadding),
                            Row(
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
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
                                      onPressed: () {
                                        // Get.find<ProductDetailPageController>()
                                        //     .addToCartPanel
                                        //     .open();
                                      },
                                      child: const Text('Tambah ke keranjang'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              ShimmerLoader(width: 200, height: 20),
                              SizedBox(width: 4),
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: ShimmerLoader(width: 100, height: 20),
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
                              ShimmerLoader(width: 40, height: 40, radius: 40),
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
                              ((_crossAxisCount - 1) * _crossAxisSpacing)) /
                          _crossAxisCount;
                      var _cellHeight = 660 / 2;
                      var _aspectRatio = _width / _cellHeight;

                      if (controller.productsSimiliarState().status ==
                          Status.success) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Produk Sejenis',
                                  style: Get.textTheme.headline3,
                                ),
                                Text(
                                  'Lihat Semua',
                                  style: Get.textTheme.headline4,
                                )
                              ],
                            ),
                            const SizedBox(height: kMediumPadding),
                            MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: _crossAxisCount,
                                  crossAxisSpacing: _crossAxisSpacing,
                                  mainAxisSpacing: _mainAxisSpacing,
                                  childAspectRatio: _aspectRatio,
                                ),
                                itemCount: controller
                                    .productsSimiliarState()
                                    .data!
                                    .data!
                                    .length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: kLightColor50),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ProductItem(
                                      product: controller
                                          .productsSimiliarState()
                                          .data!
                                          .data![index],
                                      onProductTap: () {
                                        controller.toProductDetail(
                                            productEntity: controller
                                                .productsSimiliarState()
                                                .data!
                                                .data![index]);
                                      },
                                      onFavouriteTap: () {},
                                      onBuyTap: () {},
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
                                  border: Border.all(color: kLightColor50),
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
