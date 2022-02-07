import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/feature/home/presentation/page/home_page.dart';
import 'package:gocery/feature/product/data/model/product_model.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_page_controller.dart';
import 'package:gocery/feature/product/presentation/widget/product_filter.dart';
import 'package:gocery/feature/product/presentation/widget/product_item.dart';

class ProductPage extends GetView<ProductPageController> {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> _categories = [
      CategoryModel(
          name: 'Semua',
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1601044196/mock/groceries.svg'),
      CategoryModel(
          name: 'Gas',
          color: 0xFF884DFF,
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1609097688/mock/gas-bottle-fullsize.svg'),
      CategoryModel(
          name: 'Sembako',
          color: 0xFF0095FF,
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512528/ayo%20mobile/flour.svg'),
      CategoryModel(
          name: 'Daging',
          color: 0xFFEE6352,
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512527/ayo%20mobile/steak.svg'),
      CategoryModel(
          name: 'Bumbu',
          color: 0xFFFF8900,
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512529/ayo%20mobile/pepper.svg'),
      CategoryModel(
          name: 'Ikan',
          color: 0xFFFFCF00,
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512527/ayo%20mobile/fish.svg'),
      CategoryModel(
          name: 'Cake',
          color: 0xFFB83B5E,
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512529/ayo%20mobile/cupcake.svg'),
      CategoryModel(
          name: 'Sayur',
          color: 0xFF83F084,
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512530/ayo%20mobile/salad.svg'),
      CategoryModel(
          name: 'Alat Dapur',
          color: 0xFF53CDD8,
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512529/ayo%20mobile/knives.svg'),
      CategoryModel(
          name: 'Buah',
          color: 0xFF59CD90,
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512527/ayo%20mobile/apple.svg'),
    ];

    return DefaultTabController(
      length: _categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Produk'),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(kSearchPage);
              },
              icon: const Icon(AppIcon.search),
            )
          ],
          bottom: TabBar(
            labelColor: kPrimaryColor,
            unselectedLabelColor: kLightColor100,
            labelStyle: Get.theme.textTheme.bodyText2,
            unselectedLabelStyle: Get.theme.textTheme.bodyText2,
            isScrollable: true,
            tabs: _categories
                .map((e) => Tab(
                      text: e.name,
                    ))
                .toList(),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: _categories.map((e) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kMediumPadding),
                  child: SizedBox(
                    height: 60,
                    child: ProductFilter(controllerKey: 'ProductPage'),
                  ),
                ),
                Expanded(child: _tabItem()),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

Widget _tabItem() {
  List<ProductModel> _products = List.generate(
      20,
      (index) => ProductModel(
            image:
                'https://loremflickr.com/350/350/vegetable,fruit?random=$index',
            name: 'Ayam Segar',
            point: index,
            price: '2000',
            finalPrice: '1000',
            shipping: 'LANGSUNG',
            favourite: false,
          ));

  var _crossAxisSpacing = kMediumPadding;
  var _mainAxisSpacing = kMediumPadding;
  var _screenWidth = Get.size.width;
  var _crossAxisCount = 2;
  var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
      _crossAxisCount;
  var _cellHeight = 660 / 2;
  var _aspectRatio = _width / _cellHeight;

  return GridView.builder(
    padding: const EdgeInsets.only(
        left: kMediumPadding, right: kMediumPadding, bottom: kMediumPadding),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: _crossAxisCount,
      crossAxisSpacing: _crossAxisSpacing,
      mainAxisSpacing: _mainAxisSpacing,
      childAspectRatio: _aspectRatio,
    ),
    itemCount: _products.length,
    itemBuilder: (context, index) {
      return ProductItem(
        product: _products[index],
        onProductTap: () {},
        onFavouriteTap: () {},
        onBuyTap: () {},
      );
    },
  );
}
