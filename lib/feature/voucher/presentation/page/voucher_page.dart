import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightColor,
      appBar: AppBar(
        title: const Text('Voucher Belanja'),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Ink(
                color: kLightColor,
                padding: const EdgeInsets.all(kBigPadding),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://cdn-icons-png.flaticon.com/512/726/726476.png',
                      height: 30,
                      placeholder: (context, url) =>
                          const ShimmerLoader(height: 30, radius: 50),
                    ),
                    const SizedBox(width: kMediumPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Potongan Belanja 10.000',
                            style: Get.textTheme.bodyText1,
                          ),
                          const SizedBox(height: kTinyPadding),
                          Row(
                            children: [
                              const Icon(
                                AppIcon.calendar,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Hingga 1 Februari 2022',
                                style: Get.textTheme.overline!
                                    .copyWith(color: kLightColor100),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
