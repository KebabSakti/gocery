import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';

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
                    Text(
                      '$index %',
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: kHugeFont,
                      ),
                    ),
                    const SizedBox(width: kMediumPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Diskon $index% Semua Produk',
                            style: Get.textTheme.bodyText1,
                          ),
                          const SizedBox(height: 4),
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
