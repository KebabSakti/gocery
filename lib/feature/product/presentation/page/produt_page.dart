import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/app/presentation/widget/add_to_cart_panel.dart';
import 'package:gocery/feature/app/presentation/widget/scroll_top_button.dart';
import 'package:gocery/feature/category/domain/entity/category_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_page_controller.dart';
import 'package:gocery/feature/product/presentation/widget/product_filter.dart';
import 'package:gocery/feature/product/presentation/widget/product_item.dart';

class ProductPage extends StatelessWidget {
  ProductPage({Key? key}) : super(key: key) {
    controller = Get.put(ProductPageController(controllerTag: controllerTag),
        tag: controllerTag);
  }

  final String controllerTag = Utility.randomUid();

  late final ProductPageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final categoryState = controller.categoriesState();

      var _crossAxisSpacing = kMediumPadding;
      var _mainAxisSpacing = kMediumPadding;
      var _screenWidth = Get.size.width;
      var _crossAxisCount = 2;
      var _width =
          (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
              _crossAxisCount;
      var _cellHeight = 660 / 2;
      var _aspectRatio = _width / _cellHeight;

      if (categoryState.status == Status.success) {
        final List<CategoryEntity> categories = categoryState.data!;

        return WillPopScope(
          onWillPop: controller.onBackButtonPressed,
          child: DefaultTabController(
            length: categories.length,
            initialIndex: controller.activeTab(),
            child: Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    title: const Text('Produk'),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Get.toNamed(kSearchPage);
                        },
                        icon: const Icon(AppIcon.search),
                      ),
                    ],
                    bottom: TabBar(
                      labelColor: kPrimaryColor,
                      unselectedLabelColor: kLightColor100,
                      labelStyle: Get.theme.textTheme.bodyText2,
                      unselectedLabelStyle: Get.theme.textTheme.bodyText2,
                      isScrollable: true,
                      tabs: categories.map((e) => Tab(text: e.name)).toList(),
                      onTap: (index) {
                        controller.productFilterController.filter(controller
                            .productFilterController
                            .filter()
                            .copyWith(category: categories[index].uid));
                      },
                    ),
                  ),
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kMediumPadding),
                        child: SizedBox(
                          height: 60,
                          child: ProductFilter(
                              controllerKey: controller.controllerTag),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            ListView(
                              controller: controller.scrollController,
                              children: [
                                Obx(() {
                                  final productState =
                                      controller.productsState();

                                  if (productState.status == Status.success) {
                                    final List<ProductEntity> products =
                                        productState.data!.data!;

                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.only(
                                          left: kMediumPadding,
                                          right: kMediumPadding,
                                          bottom: kMediumPadding),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: _crossAxisCount,
                                        crossAxisSpacing: _crossAxisSpacing,
                                        mainAxisSpacing: _mainAxisSpacing,
                                        childAspectRatio: _aspectRatio,
                                      ),
                                      itemCount: products.length,
                                      itemBuilder: (context, index) {
                                        return ProductItem(
                                          product: products[index],
                                          onProductTap: () {
                                            Get.toNamed(kProductDetailPage,
                                                arguments: products[index]);
                                          },
                                          onFavouriteTap: () {},
                                          onBuyTap: () {
                                            controller.addToCartPanelController
                                                .showPanel(
                                                    param: products[index]);
                                          },
                                        );
                                      },
                                    );
                                  }

                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(
                                        left: kMediumPadding,
                                        right: kMediumPadding,
                                        bottom: kMediumPadding),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: _crossAxisCount,
                                      crossAxisSpacing: _crossAxisSpacing,
                                      mainAxisSpacing: _mainAxisSpacing,
                                      childAspectRatio: _aspectRatio,
                                    ),
                                    itemCount: 6,
                                    itemBuilder: (context, index) {
                                      return const ShimmerLoader(radius: 10);
                                    },
                                  );
                                }),
                                Obx(() {
                                  if (controller.paging()) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: kMediumPadding),
                                      child: Center(
                                        child: Transform.scale(
                                          scale: 0.7,
                                          child:
                                              const CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                  }

                                  return const SizedBox.shrink();
                                }),
                              ],
                            ),
                            Positioned(
                                bottom: 10,
                                right: 10,
                                child: ScrollTopButton(
                                    controllerKey: controller.controllerTag)),
                          ],
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

      return Scaffold(
        appBar: AppBar(
          title: const Text('Produk'),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(kSearchPage);
              },
              icon: const Icon(AppIcon.search),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 40,
              color: kBackgroundColor,
              margin: const EdgeInsets.all(kMediumPadding),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                      right: (index >= 0 && index < 4) ? kMediumPadding : 0),
                  child: const ShimmerLoader(width: 100, radius: 50),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(
                    left: kMediumPadding,
                    right: kMediumPadding,
                    bottom: kMediumPadding),
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount,
                  crossAxisSpacing: _crossAxisSpacing,
                  mainAxisSpacing: _mainAxisSpacing,
                  childAspectRatio: _aspectRatio,
                ),
                itemBuilder: (context, index) {
                  return const ShimmerLoader(radius: 10);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
