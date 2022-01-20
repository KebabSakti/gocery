import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/product/data/model/product_model.dart';
import 'package:gocery/feature/product/presentation/widget/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
    List<String> _banners = [
      'https://image.freepik.com/free-vector/realistic-sale-background-with-ripped-paper_52683-55790.jpg',
      'https://image.freepik.com/free-vector/gradient-colored-sale-background_52683-68460.jpg',
      'https://image.freepik.com/free-vector/realistic-3d-sale-background_52683-63257.jpg',
      'https://image.freepik.com/free-vector/gradient-colorful-sale-background_52683-56915.jpg',
      'https://image.freepik.com/free-vector/gradient-super-sale-background_52683-62918.jpg',
      'https://image.freepik.com/free-vector/flat-design-black-friday-sale-with-megaphone_52683-47165.jpg',
    ];
    List<String> _products = List.generate(
        20,
        (index) =>
            'https://loremflickr.com/350/350/vegetable,fruit?random=$index');
    List<Widget> _widgets = [
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
                    'Halo, Leonardo',
                    style: Get.textTheme.headline3,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(kCoinIcon, width: 18, height: 18),
                      const SizedBox(width: 4),
                      Text(
                        '100',
                        textAlign: TextAlign.center,
                        style: Get.theme.textTheme.caption!
                            .copyWith(color: Colors.amber),
                      ),
                    ],
                  )
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kLightColor100,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _categories.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                      right: (index >= 0 && index < _categories.length - 1)
                          ? kMediumPadding
                          : 0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(kProductPage);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Ink(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: _categories[index].color == null
                              ? kPrimaryColor
                              : Color(_categories[index].color!),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.network(
                              _categories[index].image!,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _categories[index].name!,
                              style: Get.textTheme.caption,
                            ),
                          ],
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
      const SizedBox(height: kMediumPadding),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
        child: Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kLightColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CarouselSlider(
                  items: _banners.map<Widget>((e) {
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
                    autoPlay: true,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, _) {},
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: List<Widget>.generate(
                        _banners.length,
                        (index) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: kLightColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: kBigPadding),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Paling Laku',
                  style: Get.textTheme.headline3,
                ),
                Text(
                  'Lihat Semua',
                  style: Get.textTheme.headline4,
                )
              ],
            ),
            const SizedBox(height: kMediumPadding),
            SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                      right: (index >= 0 && index < 9) ? kMediumPadding : 0),
                  child: Center(
                    child: ProductItem(
                      product: ProductModel(image: _products[index]),
                      onProductTap: () {},
                      onFavouriteTap: () {},
                      onBuyTap: () {},
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: kBigPadding),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pisang Gapit Viral',
                  style: Get.textTheme.headline3,
                ),
                Text(
                  'Lihat Semua',
                  style: Get.textTheme.headline4,
                )
              ],
            ),
            const SizedBox(height: kSmallPadding),
            const Text(
                'Yuk bikin pisang gapit yang lagi viral di sosmed, beli bahan-bahannya di bawah ya'),
            const SizedBox(height: kMediumPadding),
            SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                      right: (index >= 0 && index < 9) ? kMediumPadding : 0),
                  child: ProductItem(
                    product: ProductModel(image: _products[index]),
                    onProductTap: () {},
                    onFavouriteTap: () {},
                    onBuyTap: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: kBigPadding),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Teman Sarapan',
                  style: Get.textTheme.headline3,
                ),
                Text(
                  'Lihat Semua',
                  style: Get.textTheme.headline4,
                )
              ],
            ),
            const SizedBox(height: kSmallPadding),
            const Text(
                'Jangan lupa sarapan yang bergizi ya sebelum memulai aktifitas harian kamu'),
            const SizedBox(height: kMediumPadding),
            SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                      right: (index >= 0 && index < 9) ? kMediumPadding : 0),
                  child: ProductItem(
                    product: ProductModel(image: _products[index]),
                    onProductTap: () {},
                    onFavouriteTap: () {},
                    onBuyTap: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    var _crossAxisSpacing = kMediumPadding;
    var _mainAxisSpacing = kMediumPadding;
    var _screenWidth = Get.size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var _cellHeight = 660 / 2;
    var _aspectRatio = _width / _cellHeight;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _widgets[index],
              childCount: _widgets.length,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
            sliver: SliverStickyHeader(
              header: Container(
                height: 60,
                color: kBackgroundColor,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                        right: (index >= 0 && index < 9) ? kTinyPadding : 0),
                    child: ChoiceChip(
                      label: Text('Filter $index'),
                      selected: index == 1 ? true : false,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      backgroundColor: kLightColor,
                      onSelected: (value) {},
                    ),
                  ),
                ),
              ),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount,
                  crossAxisSpacing: _crossAxisSpacing,
                  mainAxisSpacing: _mainAxisSpacing,
                  childAspectRatio: _aspectRatio,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ProductItem(
                      product: ProductModel(image: _products[index]),
                      onProductTap: () {},
                      onFavouriteTap: () {},
                      onBuyTap: () {},
                    );
                  },
                  childCount: _products.length,
                ),
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: kMediumPadding)),
        ],
      ),
    );
  }
}

class CategoryModel {
  final String? name;
  final String? image;
  final int? color;

  CategoryModel({
    this.name,
    this.image,
    this.color,
  });
}
