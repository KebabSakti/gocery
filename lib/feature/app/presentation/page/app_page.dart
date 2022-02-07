import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/feature/app/presentation/getx/controller/app_page_controller.dart';
import 'package:gocery/feature/cart/presentation/page/cart_page.dart';
import 'package:gocery/feature/chat/presentation/page/chat_page.dart';
import 'package:gocery/feature/home/presentation/page/home_page.dart';
import 'package:gocery/feature/order/presentation/page/order_page.dart';
import 'package:gocery/feature/profile/presentation/page/profile_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AppPage extends GetView<AppPageController> {
  const AppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onBackButtonPressed,
      child: Stack(
        children: [
          Scaffold(
            body: Stack(
              children: [
                PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    HomePage(),
                    OrderPage(),
                    CartPage(),
                    ChatPage(),
                    ProfilePage(),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: Obx(() {
              return BottomNavigationBar(
                currentIndex: controller.activePage(),
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(AppIcon.home),
                  ),
                  BottomNavigationBarItem(
                    label: 'Order',
                    icon: Icon(AppIcon.clipboard),
                  ),
                  BottomNavigationBarItem(
                    label: 'Keranjang',
                    icon: Icon(AppIcon.shoppingcart),
                  ),
                  BottomNavigationBarItem(
                    label: 'Chat',
                    icon: Icon(AppIcon.chat),
                  ),
                  BottomNavigationBarItem(
                    label: 'Profil',
                    icon: Icon(AppIcon.usercircle),
                  ),
                ],
                onTap: (index) {
                  controller.activePage(index);
                },
              );
            }),
          ),
          _addToCartPanel(controller: controller),
        ],
      ),
    );
  }
}

Widget _addToCartPanel({required AppPageController controller}) {
  return SlidingUpPanel(
    controller: controller.addToCartPanel,
    minHeight: 0,
    maxHeight: 265,
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
                    const Spacer(),
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
