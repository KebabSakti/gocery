import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/banner/domain/entity/banner_entity.dart';
import 'package:gocery/feature/home/presentation/getx/controller/banner_carousel_controller.dart';

class BannerCarousel extends GetView<BannerCarouselController> {
  const BannerCarousel({
    Key? key,
    required this.banners,
  }) : super(key: key);

  final List<BannerEntity> banners;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CarouselSlider(
            items: banners.map<Widget>((item) {
              return CachedNetworkImage(
                imageUrl: item.image!,
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
              onPageChanged: (index, _) {
                controller.bannerActive(index);
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Obx(() {
                return Row(
                  children: List<Widget>.generate(
                    banners.length,
                    (index) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == controller.bannerActive()
                              ? kPrimaryColor
                              : kLightColor,
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}
