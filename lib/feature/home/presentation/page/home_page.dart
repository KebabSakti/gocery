import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/core/widget/small_refresh_button.dart';
import 'package:gocery/feature/app/presentation/widget/scroll_top_button.dart';
import 'package:gocery/feature/banner/domain/entity/banner_entity.dart';
import 'package:gocery/feature/bundle/domain/entity/bundle_entity.dart';
import 'package:gocery/feature/category/domain/entity/category_entity.dart';
import 'package:gocery/feature/home/presentation/getx/controller/home_page_controller.dart';
import 'package:gocery/feature/home/presentation/widget/banner_carousel.dart';
import 'package:gocery/feature/home/presentation/widget/bundle_item.dart';
import 'package:gocery/feature/product/data/model/index_product_param_model.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/presentation/widget/product_filter.dart';
import 'package:gocery/feature/product/presentation/widget/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.put(HomePageController());

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      onRefresh: () async {
        controller.init();
        controller.cartController.getCartItems();
      },
      child: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMediumPadding, vertical: kLargePadding),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Color(0xffEDF1F7)),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Mau belanja apa bunda?',
                                  style: Get.textTheme.headline3,
                                ),
                                Obx(() {
                                  final customer = controller.customerAccount();

                                  if (customer.status == Status.success) {
                                    return Row(
                                      children: [
                                        SvgPicture.asset(kCoinIcon,
                                            width: 18, height: 18),
                                        const SizedBox(width: 4),
                                        Text(
                                          customer
                                              .data!.customerPointEntity!.point
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: Get.theme.textTheme.caption!
                                              .copyWith(color: Colors.amber),
                                        ),
                                      ],
                                    );
                                  }

                                  if (customer.status == Status.error) {
                                    return SmallRefreshButton(
                                        label: 'Refresh Point',
                                        onTap: () {
                                          controller.fcm();

                                          controller.customer();
                                        });
                                  }

                                  return const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(),
                                  );
                                })
                              ],
                            ),
                          ),
                          const SizedBox(height: kMediumPadding),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(kSearchPage);
                            },
                            child: Container(
                              height: 44,
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kLightColor100,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Cari di sini..',
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: Material(
                                      color: Get.theme.primaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        child: const Icon(
                                          AppIcon.search,
                                          color: kLightColor,
                                          size: 20,
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: kMediumPadding),
                          SizedBox(
                            height: 44,
                            child: Obx(() {
                              final categoryState =
                                  controller.categoriesState();

                              if (categoryState.status == Status.success) {
                                List<CategoryEntity> categories =
                                    categoryState.data!;

                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: categoryState.data!.length,
                                  itemBuilder: (context, index) {
                                    CategoryEntity category = categories[index];

                                    return Padding(
                                      padding: EdgeInsets.only(
                                          right: (index >= 0 &&
                                                  index < categories.length - 1)
                                              ? kMediumPadding
                                              : 0),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(kProductPage,
                                                arguments:
                                                    IndexProductParamModel(
                                                        category:
                                                            category.uid));
                                          },
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Ink(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: category.color == null
                                                  ? kPrimaryColor
                                                  : Color(int.parse(
                                                      category.color!)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                SvgPicture.network(
                                                  category.image!,
                                                  height: 20,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  category.name!,
                                                  style: Get.textTheme.caption,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }

                              if (categoryState.status == Status.error) {
                                return ElevatedButton(
                                  onPressed: controller.categories,
                                  style: ElevatedButton.styleFrom(
                                    primary: kLightColor,
                                    onPrimary: kLightColor100,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      side: BorderSide(color: kPrimaryColor),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(AppIcon.refreshleft,
                                          size: 14, color: kPrimaryColor),
                                      SizedBox(width: 2),
                                      Text(
                                        'Refresh Kategori',
                                        style: TextStyle(
                                            fontSize: kSmallFont,
                                            color: kPrimaryColor),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      right: (index >= 0 && index < 4 - 1)
                                          ? kMediumPadding
                                          : 0),
                                  child: const ShimmerLoader(
                                    width: 100,
                                    radius: 10,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kMediumPadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMediumPadding),
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kLightColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(() {
                          final bannerState = controller.bannersState();

                          if (bannerState.status == Status.success) {
                            final List<BannerEntity> banners =
                                bannerState.data!;

                            return BannerCarousel(banners: banners);
                          }

                          if (bannerState.status == Status.error) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SmallRefreshButton(
                                  label: 'Refresh Banner',
                                  onTap: controller.banners,
                                ),
                              ],
                            );
                          }

                          return const ShimmerLoader();
                        }),
                      ),
                    ),
                    const SizedBox(height: kBigPadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMediumPadding),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Paling Laku',
                                style: Get.textTheme.headline3,
                              ),
                              GestureDetector(
                                child: Text(
                                  'Lihat Semua',
                                  style: Get.textTheme.headline4,
                                ),
                                onTap: () {
                                  Get.toNamed(kProductPage,
                                      arguments: IndexProductParamModel(
                                          sorting: 'sold'));
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: kMediumPadding),
                          SizedBox(
                            height: 300,
                            child: Obx(() {
                              final productPopularState =
                                  controller.producPopulartState();

                              if (productPopularState.status ==
                                  Status.success) {
                                final List<ProductEntity> populars =
                                    productPopularState.data!.data!;

                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: populars.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.only(
                                        right: (index >= 0 && index < 9)
                                            ? kMediumPadding
                                            : 0),
                                    child: Center(
                                      child: ProductItem(
                                        product: populars[index],
                                        onFavouriteTap: () {},
                                        onProductTap: () {
                                          controller.toProductDetail(
                                              productEntity: populars[index]);
                                        },
                                        onBuyTap: () {
                                          controller.addToCartPanelController
                                              .showPanel(
                                                  param: populars[index]);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }

                              if (productPopularState.status == Status.error) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: kLightColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SmallRefreshButton(
                                        label: 'Refresh Produk Paling Laku',
                                        onTap: controller.productsPopular,
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      right: (index >= 0 && index < 2)
                                          ? kMediumPadding
                                          : 0),
                                  child: ShimmerLoader(
                                      radius: 10,
                                      width: (Get.size.width - 70) / 2),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: kBigPadding),
                    Obx(() {
                      final bundleState = controller.bundlesState();

                      if (bundleState.status == Status.success) {
                        final List<BundleEntity> bundles = bundleState.data!;

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMediumPadding),
                          itemCount: bundles.length,
                          separatorBuilder: (context, index) => const Divider(
                            height: kBigPadding,
                            color: Colors.transparent,
                          ),
                          itemBuilder: (context, index) {
                            return BundleItem(bundle: bundles[index]);
                          },
                        );
                      }

                      if (bundleState.status == Status.error) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMediumPadding),
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: kLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SmallRefreshButton(
                                  label: 'Refresh Produk Bundle',
                                  onTap: controller.bundles,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kMediumPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                ShimmerLoader(height: 20, width: 100),
                                ShimmerLoader(height: 20, width: 100),
                              ],
                            ),
                            const SizedBox(height: kSmallPadding),
                            const ShimmerLoader(height: 15, width: 300),
                            const SizedBox(height: kSmallPadding),
                            const ShimmerLoader(height: 15, width: 200),
                            const SizedBox(height: kMediumPadding),
                            SizedBox(
                              height: 300,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      right: (index >= 0 && index < 9)
                                          ? kMediumPadding
                                          : 0),
                                  child: ShimmerLoader(
                                      radius: 10,
                                      width: (Get.size.width - 70) / 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                  ]),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kMediumPadding),
                  sliver: SliverStickyHeader(
                    header: Container(
                      height: 60,
                      color: kBackgroundColor,
                      child: const ProductFilter(controllerKey: 'HomePage'),
                    ),

                    // return Container(
                    //   height: 40,
                    //   color: kBackgroundColor,
                    //   margin: const EdgeInsets.symmetric(
                    //       vertical: kMediumPadding),
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 5,
                    //     itemBuilder: (context, index) => Padding(
                    //       padding: EdgeInsets.only(
                    //           right: (index >= 0 && index < 4)
                    //               ? kMediumPadding
                    //               : 0),
                    //       child: const ShimmerLoader(width: 100, radius: 50),
                    //     ),
                    //   ),
                    // );

                    sliver: Obx(() {
                      final productsState = controller.productsState();

                      var _crossAxisSpacing = kMediumPadding;
                      var _mainAxisSpacing = kMediumPadding;
                      var _screenWidth = Get.size.width;
                      var _crossAxisCount = 2;
                      var _width = (_screenWidth -
                              ((_crossAxisCount - 1) * _crossAxisSpacing)) /
                          _crossAxisCount;
                      var _cellHeight = 660 / 2;
                      var _aspectRatio = _width / _cellHeight;

                      if (productsState.status == Status.success) {
                        final List<ProductEntity> products =
                            productsState.data!.data!;

                        return SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _crossAxisCount,
                            crossAxisSpacing: _crossAxisSpacing,
                            mainAxisSpacing: _mainAxisSpacing,
                            childAspectRatio: _aspectRatio,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return ProductItem(
                                product: products[index],
                                onProductTap: () {
                                  controller.toProductDetail(
                                      productEntity: products[index]);
                                },
                                onFavouriteTap: () {},
                                onBuyTap: () {
                                  controller.addToCartPanelController
                                      .showPanel(param: products[index]);
                                },
                              );
                            },
                            childCount: products.length,
                          ),
                        );
                      }

                      if (productsState.status == Status.error) {
                        return SliverToBoxAdapter(
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: kLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SmallRefreshButton(
                                  label: 'Refresh Produk',
                                  onTap: () {
                                    controller.products(
                                        param: controller
                                            .productFilterController
                                            .filter());
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _crossAxisCount,
                          crossAxisSpacing: _crossAxisSpacing,
                          mainAxisSpacing: _mainAxisSpacing,
                          childAspectRatio: _aspectRatio,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return const ShimmerLoader(radius: 10);
                          },
                          childCount: 4,
                        ),
                      );
                    }),
                  ),
                ),
                const SliverPadding(
                    padding: EdgeInsets.only(bottom: kMediumPadding)),
                Obx(() {
                  if (controller.paging()) {
                    return SliverPadding(
                      padding: const EdgeInsets.only(bottom: kMediumPadding),
                      sliver: SliverToBoxAdapter(
                        child: Center(
                          child: Transform.scale(
                            scale: 0.7,
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    );
                  }

                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                })
              ],
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: ScrollTopButton(
                controllerKey: 'HomePage',
                scrollController: controller.scrollController,
              ),
            ),
            // Obx(() {
            //   return SizedBox(
            //     height: controller.cartController.qtyTotal() == 0 ? 0 : 70,
            //   );
            // }),
            // const CartPanel(controllerKey: 'HomePage'),
            // Obx(() {
            //   return Positioned(
            //     bottom: controller.cartController.qtyTotal() == 0 ? 10 : 70,
            //     right: 10,
            //     child: ScrollTopButton(
            //       controllerKey: 'HomePage',
            //       scrollController: controller.scrollController,
            //     ),
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}
