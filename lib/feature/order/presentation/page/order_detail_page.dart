import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/app/presentation/widget/message_box.dart';
import 'package:gocery/feature/order/presentation/getx/controller/order_detail_page_controller.dart';

class OrderDetailPage extends GetView<OrderDetailPageController> {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('#OD000001'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              AppIcon.infocircle,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      body: _body(controller: controller),
    );
  }

  Widget _body({required GetxController controller}) {
    return ListView(
      padding: const EdgeInsets.all(kMediumPadding),
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: Ink(
            decoration: BoxDecoration(
              color: kLightColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kLightColor50),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                      left: kMediumPadding,
                      right: kMediumPadding,
                      top: kMediumPadding),
                  child: MessageBox(
                      'Agar orderan dapat di proses, lakukan pembayaran sebelum\n\n01:00 PM (59 menit lagi)'),
                ),
                Padding(
                  padding: const EdgeInsets.all(kMediumPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://res.cloudinary.com/vjtechsolution/image/upload/v1627370426/ayo%20mobile/AnyConv.com__bniva.png',
                        height: 30,
                      ),
                      (true == true)
                          ? ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                children: const [
                                  Icon(Icons.shield, size: 22),
                                  SizedBox(width: 4),
                                  Text('Bayar'),
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 6),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    color: kLightColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Lunas',
                                    style: Get.theme.textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: kMediumPadding),
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: Ink(
            decoration: BoxDecoration(
              color: kLightColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kLightColor50),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(kMediumPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tanggal'),
                      Text(
                        '17 Jan 22, 15:00 PM',
                        style: Get.theme.textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(kMediumPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Order ID'),
                      Text(
                        '#OD000001',
                        style: Get.theme.textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(kMediumPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status'),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'MENUNGGU PEMBAYARAN',
                          style: Get.textTheme.overline!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: kMediumPadding),
        Container(
          padding: const EdgeInsets.all(kMediumPadding),
          decoration: BoxDecoration(
            color: kLightColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kLightColor50),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Alamat Pengantaran'),
              const SizedBox(height: kMediumPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 30,
                    child: Icon(
                      AppIcon.mapmarker,
                      color: kLightColor100,
                      size: 19,
                    ),
                  ),
                  const SizedBox(width: kTinyPadding),
                  Expanded(
                    child: Text(
                      'Perumahan Grand Tsamara, No 27 Pangkalan Gas 3 Kg',
                      style: Get.textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kSmallPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 30,
                    child: Icon(
                      AppIcon.user,
                      color: kLightColor100,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: kTinyPadding),
                  Expanded(
                    child: Text(
                      'Julian Aryo',
                      style: Get.textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kSmallPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 30,
                    child: Icon(
                      AppIcon.phone,
                      color: kLightColor100,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: kTinyPadding),
                  Expanded(
                    child: Text(
                      '+62 812 5498 2664',
                      style: Get.textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kSmallPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 30,
                    child: Icon(
                      AppIcon.note,
                      color: kLightColor100,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: kTinyPadding),
                  Expanded(
                    child: Text(
                      'Pangkalan Gas 3 Kg',
                      style: Get.textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: kMediumPadding),
        Ink(
          decoration: BoxDecoration(
            color: kLightColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kLightColor50),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    left: kMediumPadding,
                    right: kMediumPadding,
                    top: kMediumPadding),
                child: Text('Detail Pengiriman'),
              ),
              Padding(
                padding: const EdgeInsets.all(kMediumPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'LANGSUNG',
                            style: Get.textTheme.overline,
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: Ink(
                                child: const Icon(
                                  AppIcon.infocircle,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: kMediumPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Jarak', style: Get.textTheme.bodyText1),
                        Text('5 km', style: Get.textTheme.bodyText1),
                      ],
                    ),
                    const SizedBox(height: kSmallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ongkir', style: Get.textTheme.bodyText1),
                        Text('Rp 12.000', style: Get.textTheme.bodyText1),
                      ],
                    ),
                    const SizedBox(height: kSmallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Jam Kirim', style: Get.textTheme.bodyText1),
                        Text('LANGSUNG', style: Get.textTheme.bodyText1),
                      ],
                    ),
                    const SizedBox(height: kBigPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                'http://4.bp.blogspot.com/-C-RFJkQ5Rdo/TqJcZf6LawI/AAAAAAAAAEY/I2GRCN43URY/s1600/Brad-pitt.jpg',
                            fit: BoxFit.cover,
                            width: 35,
                            height: 35,
                          ),
                        ),
                        const SizedBox(width: kSmallPadding),
                        Text(
                          'Bradd Pitt',
                          style: Get.textTheme.bodyText1,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            AppIcon.mylocation,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(kMediumPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'TERJADWAL',
                            style: Get.textTheme.overline,
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: Ink(
                                child: const Icon(
                                  AppIcon.infocircle,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: kMediumPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Jarak', style: Get.textTheme.bodyText1),
                        Text('12 km', style: Get.textTheme.bodyText1),
                      ],
                    ),
                    const SizedBox(height: kSmallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ongkir', style: Get.textTheme.bodyText1),
                        Text('Rp 10.000', style: Get.textTheme.bodyText1),
                      ],
                    ),
                    const SizedBox(height: kSmallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Jam Kirim', style: Get.textTheme.bodyText1),
                        Text('10:00 AM', style: Get.textTheme.bodyText1),
                      ],
                    ),
                    const SizedBox(height: kBigPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://www.mrdustbin.com/en/wp-content/uploads/2021/05/johnny-depp.jpg',
                            fit: BoxFit.cover,
                            width: 35,
                            height: 35,
                          ),
                        ),
                        const SizedBox(width: kSmallPadding),
                        Text(
                          'Johny Depp',
                          style: Get.textTheme.bodyText1,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            AppIcon.mylocation,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: kMediumPadding),
        Container(
          decoration: BoxDecoration(
            color: kLightColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kLightColor50),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: kMediumPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Produk Yang Dipesan'),
                    Text('5 Item', style: Get.textTheme.bodyText1),
                  ],
                ),
              ),
              const SizedBox(height: kMediumPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://loremflickr.com/350/350/vegetable,fruit?random=1',
                        width: 50,
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
                            '1 barang (1 kg)',
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: kSmallFont),
                          ),
                          const SizedBox(height: kTinyPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rp 30.000',
                                style: Get.theme.textTheme.headline4,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'TERJADWAL',
                                  style: Get.textTheme.overline,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: kTinyPadding),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                AppIcon.note,
                                color: kLightColor100,
                                size: 20,
                              ),
                              const SizedBox(width: kTinyPadding),
                              Expanded(
                                child: Text(
                                  'Ayamnya potong 12',
                                  style: Get.textTheme.bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kMediumPadding),
              Material(
                color: Colors.transparent,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: InkWell(
                  onTap: () {},
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Ink(
                    height: 40,
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: kLightColor50)),
                    ),
                    child: Center(
                      child: Text(
                        'Tampilkan Semua',
                        style: Get.textTheme.headline4,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: kMediumPadding),
        Container(
          decoration: BoxDecoration(
            color: kLightColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kLightColor50),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(kMediumPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rincian Biaya'),
                    const SizedBox(height: kMediumPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Belanja', style: Get.textTheme.bodyText1),
                        Text('Rp 100.000', style: Get.textTheme.bodyText1),
                      ],
                    ),
                    const SizedBox(height: kSmallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ongkos Kirim', style: Get.textTheme.bodyText1),
                        Text('Rp 12.000', style: Get.textTheme.bodyText1),
                      ],
                    ),
                    const SizedBox(height: kSmallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Biaya Admin', style: Get.textTheme.bodyText1),
                        Text('Rp 4.500', style: Get.textTheme.bodyText1),
                      ],
                    ),
                    const SizedBox(height: kSmallPadding),
                    const Divider(height: 1),
                    const SizedBox(height: kSmallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Diskon Voucher', style: Get.textTheme.bodyText1),
                        Text('- Rp 20.000', style: Get.textTheme.bodyText1),
                      ],
                    ),
                    const SizedBox(height: kSmallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Potongan Poin',
                                style: Get.textTheme.bodyText1),
                            const SizedBox(height: kTinyPadding),
                            Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: Checkbox(
                                    value: true,
                                    visualDensity: VisualDensity.compact,
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(width: kSmallPadding),
                                Text(
                                  '1000',
                                  style: Get.textTheme.bodyText1!.copyWith(
                                    color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text('- Rp 1.000', style: Get.textTheme.bodyText1),
                      ],
                    ),
                    const SizedBox(height: kSmallPadding),
                    const Divider(height: 1),
                    const SizedBox(height: kSmallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Bayar', style: Get.textTheme.bodyText1),
                        Text(
                          'Rp 120.000',
                          style: Get.textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: kMediumPadding),
        SizedBox(
          width: double.infinity,
          height: 45,
          child: TextButton(
            onPressed: () {
              MToast.show('Sentuh dan tahan untuk membatalkan order');
            },
            onLongPress: () {
              MToast.show('Orderan dibatalkan!');
            },
            child: Text(
              'Batalkan Order',
              style: Get.textTheme.bodyText2,
            ),
          ),
        ),
      ],
    );
  }
}
