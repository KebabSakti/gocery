import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/feature/app/presentation/getx/controller/app_page_controller.dart';
import 'package:gocery/feature/app/presentation/widget/add_to_cart_panel.dart';
import 'package:gocery/feature/app/presentation/widget/icon_label.dart';
import 'package:gocery/feature/cart/presentation/page/cart_page.dart';
import 'package:gocery/feature/chat/presentation/page/chat_page.dart';
import 'package:gocery/feature/home/presentation/page/home_page.dart';
import 'package:gocery/feature/order/presentation/page/order_page.dart';
import 'package:gocery/feature/profile/presentation/page/profile_page.dart';

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
                items: [
                  const BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(AppIcon.home),
                  ),
                  const BottomNavigationBarItem(
                    label: 'Order',
                    icon: Icon(AppIcon.clipboard),
                  ),
                  BottomNavigationBarItem(
                    label: 'Keranjang',
                    icon: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Icon(AppIcon.shoppingcart),
                        ),
                        Positioned(
                          right: 1,
                          child: Obx(() {
                            return IconLabel(
                              label: controller.cartController.qtyTotal(),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const BottomNavigationBarItem(
                    label: 'Chat',
                    icon: Icon(AppIcon.chat),
                  ),
                  const BottomNavigationBarItem(
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
          const AddToCartPanel(controllerKey: 'AppPage'),
        ],
      ),
    );
  }
}
