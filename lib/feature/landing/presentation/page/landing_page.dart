import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_asset.dart';
import 'package:gocery/feature/landing/presentation/getx/landing_page_controller.dart';
import 'package:gocery/feature/landing/presentation/widget/landing_page_item.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LandingPageController(),
        builder: (LandingPageController c) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: double.infinity,
                        viewportFraction: 1,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, _) => c.activeSlide(index),
                      ),
                      items: [
                        LandingPageItem(
                          asset: kLandingOne,
                          title: 'Belanja Online',
                          body: 'Belanja kapan pun dan dimana pun kamu mau',
                          button: 'Belanja Sekarang',
                          onPressed: c.toLoginPage,
                        ),
                        LandingPageItem(
                          asset: kLandingTwo,
                          title: 'Antar Ke Rumah',
                          body:
                              'Kamu di rumah aja, biar kami antar belanjaannya sampai depan pintu',
                          button: 'Belanja Sekarang',
                          onPressed: c.toLoginPage,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [0, 1]
                            .map((e) => Container(
                                  width: 10,
                                  height: 10,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: e == c.activeSlide()
                                        ? Get.theme.primaryColor
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                  )
                ],
              ),
            ),
          );
        });
  }
}
