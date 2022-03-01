import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/checkout/domain/entity/payment_channel_entity.dart';
import 'package:gocery/feature/checkout/presentation/getx/controller/checkout_page_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PaymentChanelPanel extends StatelessWidget {
  const PaymentChanelPanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CheckoutPageController controller;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: controller.paymentChannelPanel,
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
                            controller.paymentChannelPanel.close();
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
                    Text('Pilih Metode Pembayaran',
                        style: Get.textTheme.headline3),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Builder(builder: (context) {
              return Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Obx(() {
                    final channelState = controller.channelState();

                    if (channelState.status == Status.success) {
                      final List<PaymentChannelEntity> payments =
                          channelState.data!;

                      return ListView.separated(
                        itemCount: payments.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              controller.setPayment(param: payments[index]);
                            },
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: kMediumPadding,
                                vertical: kSmallPadding),
                            leading: CachedNetworkImage(
                              imageUrl: payments[index].picture!,
                              width: 50,
                              placeholder: (context, url) =>
                                  const ShimmerLoader(),
                            ),
                            title: Text(
                              payments[index].name!,
                              style: Get.textTheme.bodyText1,
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox(
                      height: 400,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
