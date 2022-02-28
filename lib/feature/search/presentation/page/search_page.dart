import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/core/widget/small_refresh_button.dart';
import 'package:gocery/feature/app/presentation/widget/add_to_cart_panel.dart';
import 'package:gocery/feature/product/data/model/index_product_param_model.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/presentation/widget/product_item.dart';
import 'package:gocery/feature/search/presentation/getx/controller/search_page_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String controllerTag = Utility.randomUid();

    final SearchPageController controller = Get.put(
        SearchPageController(controllerTag: controllerTag),
        tag: controllerTag);

    return RefreshIndicator(
      onRefresh: () async {
        controller.init();
      },
      child: Scaffold(
        backgroundColor: kLightColor,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Cari Produk'),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(kMediumPadding),
                  child: Container(
                    height: 44,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: kLightColor100),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: controller.searchField,
                      textInputAction: TextInputAction.search,
                      style: Get.textTheme.bodyText1,
                      decoration: InputDecoration(
                        hintText: 'Ketik di sini',
                        hintStyle: Get.theme.textTheme.bodyText2,
                        contentPadding: const EdgeInsets.only(right: 8, top: 4),
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        suffixIconConstraints:
                            const BoxConstraints(maxWidth: 32, maxHeight: 32),
                        suffixIcon: SizedBox(
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
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return Expanded(
                    child: (controller.searchKeyword().isNotEmpty)
                        ? CustomScrollView(
                            shrinkWrap: true,
                            slivers: [
                              Obx(() {
                                final keywordState =
                                    controller.keywordSuggestionState();

                                if (keywordState.status == Status.success) {
                                  final keywords = keywordState.data!;

                                  return SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kMediumPadding,
                                          vertical: kSmallPadding),
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.toProductPage(
                                              param: IndexProductParamModel(
                                                  name:
                                                      keywords[index].keyword));
                                        },
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                              '${keywords[index].keyword}'),
                                        ),
                                      ),
                                    );
                                  }, childCount: keywords.length));
                                }

                                if (keywordState.status == Status.loading) {
                                  return SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kMediumPadding,
                                          vertical: kSmallPadding),
                                      child: GestureDetector(
                                        child: const SizedBox(
                                          width: double.infinity,
                                          child: ShimmerLoader(height: 15),
                                        ),
                                      ),
                                    );
                                  }, childCount: 5));
                                }

                                return const SliverToBoxAdapter();
                              }),
                              Obx(() {
                                final productSuggestState =
                                    controller.productSuggestionState();

                                if (productSuggestState.status ==
                                    Status.success) {
                                  final List<ProductEntity> productSuggested =
                                      productSuggestState.data!.data!;

                                  return SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            controller.toProductDetail(
                                                param: productSuggested[index]);
                                          },
                                          child: Ink(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: kMediumPadding,
                                            ),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        productSuggested[index]
                                                            .image!,
                                                    width: 50,
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${productSuggested[index].name}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Get.textTheme
                                                            .bodyText1,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        Utility.currency(
                                                            productSuggested[
                                                                    index]
                                                                .finalPrice!),
                                                        style: Get.textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                fontSize:
                                                                    kSmallFont,
                                                                color:
                                                                    kPrimaryColor),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }, childCount: productSuggested.length),
                                  );
                                }

                                if (productSuggestState.status ==
                                    Status.loading) {
                                  return SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: kMediumPadding,
                                        ),
                                        child: Row(
                                          children: [
                                            const ShimmerLoader(
                                              width: 50,
                                              height: 50,
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  ShimmerLoader(height: 15),
                                                  SizedBox(height: 4),
                                                  ShimmerLoader(height: 15),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }, childCount: 5),
                                  );
                                }

                                return const SliverToBoxAdapter();
                              }),
                            ],
                          )
                        : CustomScrollView(
                            slivers: [
                              Obx(() {
                                final historyState =
                                    controller.productHistoryState();

                                if (historyState.status == Status.loading) {
                                  return SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: kMediumPadding,
                                          bottom: kHugePadding,
                                          left: kMediumPadding,
                                          right: kMediumPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Terakhir Dilihat',
                                              style: Get.textTheme.headline3),
                                          const SizedBox(
                                              height: kMediumPadding),
                                          SizedBox(
                                            height: 65,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 10,
                                              itemBuilder: (context, index) =>
                                                  Padding(
                                                padding: EdgeInsets.only(
                                                    right: (index >= 0 &&
                                                            index < 9)
                                                        ? kMediumPadding
                                                        : 0),
                                                child: const ShimmerLoader(
                                                    width: 65),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (historyState.status == Status.error) {
                                  return SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: kMediumPadding,
                                          bottom: kHugePadding,
                                          left: kMediumPadding,
                                          right: kMediumPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Terakhir Dilihat',
                                              style: Get.textTheme.headline3),
                                          const SizedBox(
                                              height: kMediumPadding),
                                          SmallRefreshButton(
                                            onTap: () {
                                              controller.productHistories();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (historyState.status == Status.success) {
                                  final products = historyState.data!;

                                  return SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: kMediumPadding,
                                          bottom: kHugePadding,
                                          left: kMediumPadding,
                                          right: kMediumPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Terakhir Dilihat',
                                              style: Get.textTheme.headline3),
                                          const SizedBox(
                                              height: kMediumPadding),
                                          SizedBox(
                                            height: 65,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: products.length,
                                              itemBuilder: (context, index) =>
                                                  Padding(
                                                padding: EdgeInsets.only(
                                                    right: (index >= 0 &&
                                                            index <
                                                                (products
                                                                        .length -
                                                                    1))
                                                        ? kMediumPadding
                                                        : 0),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    onTap: () {
                                                      controller
                                                          .toProductDetail(
                                                              param: products[
                                                                  index]);
                                                    },
                                                    child: Ink(
                                                      width: 65,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                              CachedNetworkImageProvider(
                                                            products[index]
                                                                .image!,
                                                          ),
                                                        ),
                                                      ),
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

                                return const SliverToBoxAdapter(
                                    child: SizedBox.shrink());
                              }),
                              Obx(() {
                                final searchState = controller.searchsState();

                                if (searchState.status == Status.loading) {
                                  return SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: kMediumPadding,
                                          left: kMediumPadding,
                                          right: kMediumPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Riwayat Pencarian',
                                            style: Get.textTheme.headline3,
                                          ),
                                          const SizedBox(
                                              height: kMediumPadding),
                                          ListView.separated(
                                            itemCount: 5,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            separatorBuilder: (context,
                                                    index) =>
                                                const Divider(
                                                    height: 1,
                                                    color: Colors.transparent),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: const [
                                                    Expanded(
                                                      child: ShimmerLoader(
                                                          height: 20),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (searchState.status == Status.error) {
                                  return SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: kMediumPadding,
                                          left: kMediumPadding,
                                          right: kMediumPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Riwayat Pencarian',
                                            style: Get.textTheme.headline3,
                                          ),
                                          const SizedBox(
                                              height: kMediumPadding),
                                          SmallRefreshButton(onTap: () {
                                            controller.searches();
                                          }),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (searchState.status == Status.success) {
                                  final searches = searchState.data!;

                                  return SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: kMediumPadding,
                                          left: kMediumPadding,
                                          right: kMediumPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Riwayat Pencarian',
                                            style: Get.textTheme.headline3,
                                          ),
                                          const SizedBox(
                                              height: kMediumPadding),
                                          ListView.separated(
                                            itemCount: searches.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(height: 1),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.toProductPage(
                                                            param: IndexProductParamModel(
                                                                name: searches[
                                                                        index]
                                                                    .keyword));
                                                      },
                                                      child: Text(
                                                          '${searches[index].keyword}'),
                                                    ),
                                                    ClipOval(
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          onTap: () {
                                                            controller.deleteSearch(
                                                                uid: searches[
                                                                        index]
                                                                    .uid!);
                                                          },
                                                          child: Ink(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6),
                                                            child: const Icon(
                                                              AppIcon.close,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return const SliverToBoxAdapter(
                                    child: SizedBox.shrink());
                              }),
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

                                final mostSearhcProductState =
                                    controller.mostSearchProductState();

                                if (mostSearhcProductState.status ==
                                    Status.loading) {
                                  return SliverToBoxAdapter(
                                    child: Container(
                                      color: Get.theme.scaffoldBackgroundColor,
                                      padding:
                                          const EdgeInsets.all(kMediumPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Paling Dicari',
                                                style: Get.textTheme.headline3,
                                              ),
                                              GestureDetector(
                                                child: Text(
                                                  'Lihat Semua',
                                                  style:
                                                      Get.textTheme.headline4,
                                                ),
                                                onTap: () {},
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                              height: kMediumPadding),
                                          GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: _crossAxisCount,
                                              crossAxisSpacing:
                                                  _crossAxisSpacing,
                                              mainAxisSpacing: _mainAxisSpacing,
                                              childAspectRatio: _aspectRatio,
                                            ),
                                            itemCount: 4,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: kLightColor50),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const ShimmerLoader(),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (mostSearhcProductState.status ==
                                    Status.error) {
                                  return SliverToBoxAdapter(
                                    child: Container(
                                      color: Get.theme.scaffoldBackgroundColor,
                                      padding:
                                          const EdgeInsets.all(kMediumPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Paling Dicari',
                                                style: Get.textTheme.headline3,
                                              ),
                                              GestureDetector(
                                                child: Text(
                                                  'Lihat Semua',
                                                  style:
                                                      Get.textTheme.headline4,
                                                ),
                                                onTap: () {},
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                              height: kMediumPadding),
                                          Container(
                                            height: 300,
                                            decoration: BoxDecoration(
                                              color: kLightColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SmallRefreshButton(
                                                  label: 'Refresh Produk',
                                                  onTap: () {
                                                    controller.products();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (mostSearhcProductState.status ==
                                    Status.success) {
                                  final products =
                                      mostSearhcProductState.data!.data;

                                  return SliverToBoxAdapter(
                                    child: Container(
                                      color: Get.theme.scaffoldBackgroundColor,
                                      padding:
                                          const EdgeInsets.all(kMediumPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Paling Dicari',
                                                style: Get.textTheme.headline3,
                                              ),
                                              GestureDetector(
                                                child: Text(
                                                  'Lihat Semua',
                                                  style:
                                                      Get.textTheme.headline4,
                                                ),
                                                onTap: () {
                                                  controller.toProductPage(
                                                      param:
                                                          IndexProductParamModel(
                                                              sorting:
                                                                  'search'));
                                                },
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                              height: kMediumPadding),
                                          GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: _crossAxisCount,
                                              crossAxisSpacing:
                                                  _crossAxisSpacing,
                                              mainAxisSpacing: _mainAxisSpacing,
                                              childAspectRatio: _aspectRatio,
                                            ),
                                            itemCount: products!.length,
                                            itemBuilder: (context, index) {
                                              return ProductItem(
                                                product: products[index],
                                                onProductTap: () {
                                                  controller.toProductDetail(
                                                      param: products[index]);
                                                },
                                                onFavouriteTap: () {},
                                                onBuyTap: () {
                                                  controller
                                                      .addToCartPanelController
                                                      .showPanel(
                                                          param:
                                                              products[index]);
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return const SliverToBoxAdapter(
                                    child: SizedBox.shrink());
                              }),
                            ],
                          ),
                  );
                }),
              ],
            ),
            AddToCartPanel(controllerKey: controllerTag),
          ],
        ),
      ),
    );
  }
}
