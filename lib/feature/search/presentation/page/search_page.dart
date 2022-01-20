import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/feature/product/data/model/product_model.dart';
import 'package:gocery/feature/product/presentation/widget/product_item.dart';
import 'package:gocery/feature/search/presentation/getx/controller/search_page_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _products = List.generate(
        20,
        (index) =>
            'https://loremflickr.com/350/350/vegetable,fruit?random=$index');

    var _crossAxisSpacing = kMediumPadding;
    var _mainAxisSpacing = kMediumPadding;
    var _screenWidth = Get.size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var _cellHeight = 660 / 2;
    var _aspectRatio = _width / _cellHeight;

    return GetBuilder(
        init: SearchPageController(),
        builder: (SearchPageController c) {
          return Scaffold(
            backgroundColor: kLightColor,
            appBar: AppBar(
              elevation: 0,
              title: const Text('Cari Produk'),
            ),
            body: Column(
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
                      controller: c.searchField,
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
                    child: (c.searchMode())
                        ? ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
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
                                            imageUrl: _products[index],
                                            width: 50,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Produk $index',
                                              style: Get.textTheme.bodyText1,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Sayur Segar',
                                              style: Get.textTheme.bodyText2!
                                                  .copyWith(
                                                      fontSize: kSmallFont),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : CustomScrollView(
                            slivers: [
                              const SliverToBoxAdapter(
                                  child: SizedBox(height: kMediumPadding)),
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kMediumPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Terakhir Dilihat',
                                          style: Get.textTheme.headline3),
                                      const SizedBox(height: kMediumPadding),
                                      SizedBox(
                                        height: 60,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 10,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                            padding: EdgeInsets.only(
                                                right: (index >= 0 && index < 9)
                                                    ? kMediumPadding
                                                    : 0),
                                            child: Material(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onTap: () {},
                                                child: Ink(
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image:
                                                          CachedNetworkImageProvider(
                                                        _products[index],
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
                              ),
                              const SliverToBoxAdapter(
                                  child: SizedBox(height: kHugePadding)),
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kMediumPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Riwayat Pencarian',
                                        style: Get.textTheme.headline3,
                                      ),
                                      const SizedBox(height: kMediumPadding),
                                      ListView.separated(
                                        itemCount: 3,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            const Divider(height: 1),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text('Item $index'),
                                                ClipOval(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () {},
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
                              ),
                              const SliverToBoxAdapter(
                                  child: SizedBox(height: kMediumPadding)),
                              SliverToBoxAdapter(
                                child: Container(
                                  color: Get.theme.scaffoldBackgroundColor,
                                  padding: const EdgeInsets.all(kMediumPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Paling Dicari',
                                        style: Get.textTheme.headline3,
                                      ),
                                      const SizedBox(height: kMediumPadding),
                                      GridView.builder(
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
                                        itemCount: _products.length,
                                        itemBuilder: (context, index) {
                                          return ProductItem(
                                            product: ProductModel(
                                                image: _products[index]),
                                            onProductTap: () {},
                                            onFavouriteTap: () {},
                                            onBuyTap: () {},
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  );
                }),
              ],
            ),
          );
        });
  }
}
