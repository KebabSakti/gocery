import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/feature/app/presentation/getx/controller/app_bottom_navigation_bar_controller.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key? key, this.active = 0}) : super(key: key);

  final int active;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AppBottomNavigationBarController(),
        builder: (AppBottomNavigationBarController c) {
          return BottomNavigationBar(
            currentIndex: active,
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
                icon: Icon(AppIcon.shoppingCart),
              ),
              BottomNavigationBarItem(
                label: 'Chat',
                icon: Icon(AppIcon.chat),
              ),
              BottomNavigationBarItem(
                label: 'Profil',
                icon: Icon(AppIcon.userCircle),
              ),
            ],
            onTap: (index) {
              if (index != active) {
                c.setActive(index);
              }
            },
          );
        });
  }
}
