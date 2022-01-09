import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/app/presentation/widget/app_bottom_navigation_bar.dart';

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
          name: 'Gas',
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1609097688/mock/gas-bottle-fullsize.svg'),
      CategoryModel(
          name: 'Sembako',
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512528/ayo%20mobile/flour.svg'),
      CategoryModel(
          name: 'Daging',
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512527/ayo%20mobile/steak.svg'),
      CategoryModel(
          name: 'Bumbu',
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512529/ayo%20mobile/pepper.svg'),
      CategoryModel(
          name: 'Ikan',
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512527/ayo%20mobile/fish.svg'),
      CategoryModel(
          name: 'Cake',
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512529/ayo%20mobile/cupcake.svg'),
      CategoryModel(
          name: 'Sayur',
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512530/ayo%20mobile/salad.svg'),
      CategoryModel(
          name: 'Alat Dapur',
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512529/ayo%20mobile/knives.svg'),
      CategoryModel(
          name: 'Buah',
          image:
              'https://res.cloudinary.com/vjtechsolution/image/upload/v1630512527/ayo%20mobile/apple.svg'),
    ];
    List<Widget> _banners = [
      CachedNetworkImage(
        imageUrl:
            'https://image.freepik.com/free-vector/realistic-sale-background-with-ripped-paper_52683-55790.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      CachedNetworkImage(
        imageUrl:
            'https://image.freepik.com/free-vector/gradient-colored-sale-background_52683-68460.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      CachedNetworkImage(
        imageUrl:
            'https://image.freepik.com/free-vector/realistic-3d-sale-background_52683-63257.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      CachedNetworkImage(
        imageUrl:
            'https://image.freepik.com/free-vector/gradient-colorful-sale-background_52683-56915.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      CachedNetworkImage(
        imageUrl:
            'https://image.freepik.com/free-vector/gradient-super-sale-background_52683-62918.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      CachedNetworkImage(
        imageUrl:
            'https://image.freepik.com/free-vector/flat-design-black-friday-sale-with-megaphone_52683-47165.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    ];
    List<String> _products = List.generate(
        20,
        (index) =>
            'https://loremflickr.com/350/350/vegetable,fruit?random=$index');
    List<Widget> _widgets = [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
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
              child: Text(
                'Halo, Leonardo',
                style: Get.textTheme.headline6
                    ?.copyWith(color: const Color(0xff222B45)),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 44,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff8F9BB3),
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
                          color: Colors.white,
                          size: 20,
                        ),
                        onTap: () {},
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _categories.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                      right: (index >= 0 && index < _categories.length - 1)
                          ? 16
                          : 0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10),
                      child: Ink(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xff64BA02),
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
                              style: const TextStyle(
                                color: Colors.white,
                              ),
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
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CarouselSlider(
                  items: _banners,
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
            ],
          ),
        ),
      ),
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Paling Laku',
                  style: Get.textTheme.headline6
                      ?.copyWith(color: const Color(0xff222B45)),
                ),
                Text(
                  'Semua',
                  style: Get.textTheme.headline6
                      ?.copyWith(color: Get.theme.primaryColor),
                )
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 280,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => Padding(
              padding:
                  EdgeInsets.only(right: (index >= 0 && index < 9) ? 16 : 0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  child: Ink(
                    width: (Get.size.width - 80) / 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: SizedBox(
                            height: 125,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: _products[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  placeholder: (context, url) =>
                                      const ShimmerLoader(),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: SizedBox(
                                      width: 32,
                                      height: 32,
                                      child: Material(
                                        color: const Color(0xff121924)
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(12),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: const Icon(
                                            AppIcon.heart,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        'TERJADWAL',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 155,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pisang impor manis banget',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: Get.theme.textTheme.bodyText2?.copyWith(
                                  color: const Color(0xff222B45),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // const SizedBox(height: 10),
                              Column(
                                children: [
                                  Text(
                                    'Rp 36.000',
                                    style:
                                        Get.theme.textTheme.bodyText2?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  Text(
                                    'Rp 30.000',
                                    style:
                                        Get.theme.textTheme.bodyText2?.copyWith(
                                      color: Get.theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              // const Spacer(),
                              SizedBox(
                                height: 30,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Beli'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pisang Gapit Viral',
                  style: Get.textTheme.headline6
                      ?.copyWith(color: const Color(0xff222B45)),
                ),
                Text(
                  'Semua',
                  style: Get.textTheme.headline6
                      ?.copyWith(color: Get.theme.primaryColor),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text(
                'Yuk bikin pisang gapit yang lagi viral di sosmed, beli bahan-bahannya di bawah ya')
          ],
        ),
      ),
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 280,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => Padding(
              padding:
                  EdgeInsets.only(right: (index >= 0 && index < 9) ? 16 : 0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  child: Ink(
                    width: (Get.size.width - 80) / 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: SizedBox(
                            height: 125,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: _products[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  placeholder: (context, url) =>
                                      const ShimmerLoader(),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: SizedBox(
                                      width: 32,
                                      height: 32,
                                      child: Material(
                                        color: const Color(0xff121924)
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(12),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: const Icon(
                                            AppIcon.heart,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        'TERJADWAL',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 155,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pisang impor manis banget',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: Get.theme.textTheme.bodyText2?.copyWith(
                                  color: const Color(0xff222B45),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // const SizedBox(height: 10),
                              Column(
                                children: [
                                  Text(
                                    'Rp 36.000',
                                    style:
                                        Get.theme.textTheme.bodyText2?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  Text(
                                    'Rp 30.000',
                                    style:
                                        Get.theme.textTheme.bodyText2?.copyWith(
                                      color: Get.theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              // const Spacer(),
                              SizedBox(
                                height: 30,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Beli'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Teman Sarapan',
                  style: Get.textTheme.headline6
                      ?.copyWith(color: const Color(0xff222B45)),
                ),
                Text(
                  'Semua',
                  style: Get.textTheme.headline6
                      ?.copyWith(color: Get.theme.primaryColor),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text(
                'Jangan lupa sarapan yang bergizi ya sebelum memulai aktifitas harian kamu')
          ],
        ),
      ),
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 280,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => Padding(
              padding:
                  EdgeInsets.only(right: (index >= 0 && index < 9) ? 16 : 0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  child: Ink(
                    width: (Get.size.width - 80) / 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: SizedBox(
                            height: 125,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: _products[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  placeholder: (context, url) =>
                                      const ShimmerLoader(),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: SizedBox(
                                      width: 32,
                                      height: 32,
                                      child: Material(
                                        color: const Color(0xff121924)
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(12),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: const Icon(
                                            AppIcon.heart,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        'TERJADWAL',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 155,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pisang impor manis banget',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: Get.theme.textTheme.bodyText2?.copyWith(
                                  color: const Color(0xff222B45),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // const SizedBox(height: 10),
                              Column(
                                children: [
                                  Text(
                                    'Rp 36.000',
                                    style:
                                        Get.theme.textTheme.bodyText2?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  Text(
                                    'Rp 30.000',
                                    style:
                                        Get.theme.textTheme.bodyText2?.copyWith(
                                      color: Get.theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              // const Spacer(),
                              SizedBox(
                                height: 30,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Beli'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 30),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: _widgets.length,
          itemBuilder: (context, index) => _widgets[index],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(active: 0),
    );
  }
}

class CategoryModel {
  final String? name;
  final String? image;

  CategoryModel({this.name, this.image});
}
