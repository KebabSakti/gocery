import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/product/data/model/product_model.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_detail_page_controller.dart';
import 'package:gocery/feature/product/presentation/widget/product_item.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductDetailPage extends GetView<ProductDetailPageController> {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _products = List<String>.generate(
        5,
        (index) =>
            'https://loremflickr.com/350/350/vegetable,fruit?random=${index + 1}');

    return WillPopScope(
      onWillPop: controller.onBackButtonPressed,
      child: Scaffold(
        backgroundColor: kLightColor,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            _body2(_products),
            _addToCartPanel(controller: controller),
          ],
        ),
      ),
    );
  }
}

Widget _body2(List<String> products) {
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

  return SingleChildScrollView(
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: Get.size.height / 2.5,
          child: Stack(
            children: <Widget>[
              CarouselSlider(
                items: products.map<Widget>((e) {
                  return CachedNetworkImage(
                    imageUrl: e,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => const ShimmerLoader(),
                  );
                }).toList(),
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  height: double.infinity,
                  autoPlay: false,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, _) {},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: List<Widget>.generate(
                        products.length,
                        (index) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 30.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[100],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Pisang Impor Malaysia',
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
                          color: Colors.blue.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'TERJADWAL',
                          style: Get.textTheme.overline,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Harga per 1 kg',
                  style: Get.theme.textTheme.bodyText2,
                ),
                const SizedBox(height: kTinyPadding),
                Row(
                  children: [
                    Text(
                      'Rp 30.000',
                      style: Get.theme.textTheme.headline3!
                          .copyWith(color: kPrimaryColor),
                    ),
                    const SizedBox(width: kTinyPadding),
                    Text(
                      'Rp 36.000',
                      style: Get.theme.textTheme.bodyText2
                          ?.copyWith(decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
                const SizedBox(height: kTinyPadding),
                Row(
                  children: [
                    SvgPicture.asset(kCoinIcon, width: 20, height: 20),
                    const SizedBox(width: 4),
                    Text(
                      '100',
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
                        value: '100'),
                    const SizedBox(width: kMediumPadding),
                    _statisticItem(
                        icon: const Icon(
                          AppIcon.eye,
                          color: kPrimaryColor,
                          size: 30,
                        ),
                        value: '720'),
                    const SizedBox(width: kMediumPadding),
                    _statisticItem(
                        icon: const Icon(
                          AppIcon.coin,
                          color: kPrimaryColor,
                          size: 28,
                        ),
                        value: '1000'),
                  ],
                ),
                const SizedBox(height: kMediumPadding),
                const Text(
                    'Everybody enjoys indulging in juicy red cherries during the summer season. This vibrant red fruit is a great blend of sweet flavours with a tingle of sourness and adds the ...'),
                const SizedBox(height: kBigPadding),
                Row(
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Ink(
                            child: const Icon(
                              AppIcon.heartfill,
                              color: Colors.red,
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
                            Get.find<ProductDetailPageController>()
                                .addToCartPanel
                                .open();
                          },
                          child: const Text('Tambah ke keranjang'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kLargePadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Produk Serupa',
                      style: Get.textTheme.headline3,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _crossAxisCount,
                        crossAxisSpacing: _crossAxisSpacing,
                        mainAxisSpacing: _mainAxisSpacing,
                        childAspectRatio: _aspectRatio,
                      ),
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: kLightColor50),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ProductItem(
                            product: ProductModel(image: _products[index]),
                            onProductTap: () {},
                            onFavouriteTap: () {},
                            onBuyTap: () {},
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
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

Widget _addToCartPanel({required ProductDetailPageController controller}) {
  return SlidingUpPanel(
    controller: controller.addToCartPanel,
    minHeight: 0,
    maxHeight: 285,
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
    panel: Material(
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
                        onTap: () {},
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
                                'https://loremflickr.com/350/350/vegetable,fruit?random=1',
                            width: 70,
                          ),
                        ),
                        const SizedBox(width: kMediumPadding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pisang impor manis banget superrrrr',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.bodyText1,
                              ),
                              const SizedBox(height: kTinyPadding),
                              Text(
                                'Harga per 1 kg',
                                style: Get.theme.textTheme.bodyText2!
                                    .copyWith(fontSize: kSmallFont),
                              ),
                              const SizedBox(height: kTinyPadding),
                              Text(
                                'Rp 30.000',
                                style: Get.theme.textTheme.bodyText1!
                                    .copyWith(color: kPrimaryColor),
                              ),
                              const SizedBox(height: kSmallPadding),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'TERJADWAL',
                                      style: Get.textTheme.overline,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: kPrimaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(AppIcon.minus),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: Text(
                                            '999',
                                            style:
                                                Get.theme.textTheme.bodyText1,
                                          ),
                                        ),
                                        const Icon(AppIcon.plus),
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
                    const SizedBox(height: kBigPadding),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(kCheckoutPage);
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
    ),
  );
}
