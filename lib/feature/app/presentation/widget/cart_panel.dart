import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/feature/app/presentation/getx/controller/cart_panel_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CartPanel extends GetView<CartPanelController> {
  const CartPanel({Key? key, required this.controllerKey}) : super(key: key);

  final String controllerKey;

  @override
  String? get tag => controllerKey;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: controller.panelController,
      backdropColor: kDarkColor,
      minHeight: 0,
      maxHeight: 60,
      backdropEnabled: false,
      backdropTapClosesPanel: false,
      isDraggable: false,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(1, 1), // changes position of shadow
        ),
      ],
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      // header: Container(
      //   width: Get.size.width,
      //   alignment: Alignment.center,
      //   child: Icon(Icons.drag_handle_rounded, color: Colors.grey[400]),
      // ),
      panel: Container(
        color: Colors.grey[50],
        padding: const EdgeInsets.all(kMediumPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Icon(AppIcon.shoppingcart, size: 35),
                    ),
                    Positioned(
                      right: 1,
                      child: Obx(() {
                        return ClipOval(
                          child: Container(
                            width: 20,
                            height: 20,
                            color: Colors.redAccent,
                            child: Center(
                                child: Text(
                              controller.cartController.qtyTotal().toString(),
                              style: const TextStyle(
                                color: kLightColor,
                                fontSize: kTinyFont,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(width: kSmallPadding),
                Obx(() {
                  return Text(
                    Utility.currency(
                        controller.cartController.priceTotal().toString()),
                    style: Get.textTheme.bodyText1,
                  );
                }),
              ],
            ),
            SizedBox(
              height: 35,
              width: 100,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Lanjut'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
