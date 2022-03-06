import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/checkout/domain/entity/voucher_entity.dart';
import 'package:gocery/feature/checkout/presentation/getx/controller/checkout_page_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VoucherPanel extends StatelessWidget {
  const VoucherPanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CheckoutPageController controller;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: controller.voucherPanel,
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
                    Text('Voucher Belanja', style: Get.textTheme.headline3),
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
                    final voucherState = controller.voucherState();

                    if (voucherState.status == Status.success) {
                      final List<VoucherEntity> vouchers = voucherState.data!;

                      if (vouchers.isEmpty) {
                        return const SizedBox(
                          height: 400,
                          child: Center(
                            child: Text('Belum ada voucher tersedia'),
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: vouchers.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              controller.setVoucher(
                                param: vouchers[index].copyWith(
                                    selected: !vouchers[index].selected!),
                              );
                            },
                            selected: vouchers[index].selected!,
                            selectedTileColor: kPrimaryColor100,
                            leading: CachedNetworkImage(
                              imageUrl:
                                  'https://cdn-icons-png.flaticon.com/512/726/726476.png',
                              height: 40,
                              placeholder: (context, url) =>
                                  const ShimmerLoader(
                                      height: 30, width: 30, radius: 30),
                            ),
                            title: Text(
                              vouchers[index].title!,
                              style: Get.textTheme.bodyText1,
                            ),
                            subtitle: Row(
                              children: [
                                const Icon(
                                  AppIcon.calendar,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  vouchers[index].expiredAt!,
                                  style: Get.textTheme.overline!
                                      .copyWith(color: kLightColor100),
                                ),
                              ],
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
