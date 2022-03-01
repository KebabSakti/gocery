import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_time_entity.dart';
import 'package:gocery/feature/checkout/presentation/getx/controller/checkout_page_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DeliveryTimePanel extends StatelessWidget {
  const DeliveryTimePanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CheckoutPageController controller;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: controller.deliveryTimePanel,
      minHeight: 0,
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
                          onTap: () {
                            controller.deliveryTimePanel.close();
                          },
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
                    Text('Pilih Jam Pengiriman',
                        style: Get.textTheme.headline3),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Builder(builder: (context) {
              return Expanded(
                child: Column(
                  children: [
                    // Container(
                    //   color: kBackgroundColor,
                    //   padding: const EdgeInsets.all(kBigPadding),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: const [
                    //       Icon(
                    //         AppIcon.infocircle,
                    //         color: Colors.amber,
                    //       ),
                    //       SizedBox(width: kSmallPadding),
                    //       Expanded(
                    //         child: Text(
                    //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ultricies leo sapien, non interdum ligula tempor et.'),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: Obx(() {
                        final shippingTimesState =
                            controller.shippingTimesState();

                        if (shippingTimesState.status == Status.success) {
                          final List<ShippingTimeEntity> shippingTimes =
                              shippingTimesState.data!;

                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: shippingTimes.length,
                            separatorBuilder: (context, index) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: (!shippingTimes[index].enable!)
                                      ? null
                                      : () {
                                          controller.setShippingTime(
                                              time: shippingTimes[index].time!);
                                        },
                                  child: Ink(
                                    padding: const EdgeInsets.all(kBigPadding),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          shippingTimes[index].time!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                            color:
                                                (!shippingTimes[index].enable!)
                                                    ? Colors.grey[300]
                                                    : kDarkColor,
                                          ),
                                        ),
                                        // (index == 0)
                                        //     ? const Icon(AppIcon.checkmarkcircle,
                                        //         color: kPrimaryColor)
                                        //     : const SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        return SizedBox(
                          height: 400,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              // SizedBox(height: kMediumPadding),
                              // Text('Memuat Jam Pengiriman'),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
