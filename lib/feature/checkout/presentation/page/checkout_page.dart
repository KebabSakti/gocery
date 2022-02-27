import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_time_entity.dart';
import 'package:gocery/feature/checkout/presentation/getx/controller/checkout_page_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CheckoutPage extends GetView<CheckoutPageController> {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onBackButtonPressed,
      child: Stack(
        children: [
          _body(controller: controller),
          _deliveryTimePanel(controller: controller),
          _paymentChannelPanel(controller: controller),
        ],
      ),
    );
  }
}

Widget _body({required CheckoutPageController controller}) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Konfirmasi Pesanan'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(kMediumPadding),
      child: Column(
        children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Alamat Pengantaran'),
                    Obx(() {
                      return (controller.addressState().status ==
                              Status.loading)
                          ? const SizedBox.shrink()
                          : Row(
                              children: [
                                const Icon(AppIcon.editpencil,
                                    size: 15, color: kPrimaryColor),
                                const SizedBox(width: 2),
                                GestureDetector(
                                    onTap: controller.toDeliveryAddressPage,
                                    child: Text('Edit',
                                        style: Get.textTheme.headline4)),
                              ],
                            );
                    }),
                  ],
                ),
                const SizedBox(height: kMediumPadding),
                Obx(() {
                  final addressState = controller.addressState();

                  final ShippingAddressEntity? addressEntity =
                      addressState.data;

                  if (addressState.status == Status.loading) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ShimmerLoader(width: double.infinity, height: 16),
                        SizedBox(height: kSmallPadding),
                        ShimmerLoader(width: double.infinity, height: 16),
                        SizedBox(height: kSmallPadding),
                        ShimmerLoader(width: double.infinity, height: 16),
                        SizedBox(height: kSmallPadding),
                        ShimmerLoader(width: double.infinity, height: 16),
                        SizedBox(height: kSmallPadding),
                        ShimmerLoader(width: double.infinity, height: 16),
                      ],
                    );
                  }

                  if (addressEntity != null) {
                    return Column(
                      children: [
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
                                addressEntity.address!,
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
                                addressEntity.name!,
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
                                addressEntity.phone!,
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
                              child: TextField(
                                controller: TextEditingController()
                                  ..text = addressEntity.note ?? '',
                                decoration: InputDecoration(
                                  hintText: 'Berikan catatan',
                                  hintStyle: Get.textTheme.bodyText2,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                onSubmitted: (value) {
                                  controller.setAddressNote(note: value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: kLightColor,
                        onPrimary: kLightColor100,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          side: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                      child: const Text(
                        'Tambah Alamat',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                  );
                }),
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
                Obx(() {
                  final orderShippingState = controller.orderShippingState();

                  if (orderShippingState.status == Status.success) {
                    final List<OrderShippingEntity> shippings =
                        orderShippingState.data!;

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemCount: shippings.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(kMediumPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: (shippings[index].shipping! ==
                                              'TERJADWAL')
                                          ? Colors.blue
                                          : kPrimaryColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      shippings[index].shipping!,
                                      style: Get.textTheme.overline,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    padding: const EdgeInsets.all(0),
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(
                                      AppIcon.infocircle,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: kMediumPadding),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Jarak', style: Get.textTheme.bodyText1),
                                  Text(
                                      '${shippings[index].distance} ${shippings[index].distanceUnit} ',
                                      style: Get.textTheme.bodyText1),
                                ],
                              ),
                              const SizedBox(height: kSmallPadding),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ongkir',
                                      style: Get.textTheme.bodyText1),
                                  Text(
                                      Utility.currency(
                                          shippings[index].price.toString()),
                                      style: Get.textTheme.bodyText1),
                                ],
                              ),
                              const SizedBox(height: kSmallPadding),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Jam Kirim',
                                      style: Get.textTheme.bodyText1),
                                  (shippings[index].shipping == 'LANGSUNG')
                                      ? Text('LANGSUNG',
                                          style: Get.textTheme.bodyText1)
                                      : Row(
                                          children: [
                                            Text(
                                                shippings[index]
                                                    .time
                                                    .toString(),
                                                style: Get.textTheme.bodyText1),
                                            const SizedBox(width: 6),
                                            GestureDetector(
                                              onTap: controller
                                                  .openDeliveryTimerPanel,
                                              child: Row(
                                                children: [
                                                  const Icon(AppIcon.editpencil,
                                                      size: 15,
                                                      color: kPrimaryColor),
                                                  const SizedBox(width: 2),
                                                  Text('Edit',
                                                      style: Get
                                                          .textTheme.headline4),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  if (orderShippingState.status == Status.loading) {
                    return Padding(
                      padding: const EdgeInsets.all(kMediumPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          ShimmerLoader(width: double.infinity, height: 16),
                          SizedBox(height: kSmallPadding),
                          ShimmerLoader(width: double.infinity, height: 16),
                          SizedBox(height: kSmallPadding),
                          ShimmerLoader(width: double.infinity, height: 16),
                          SizedBox(height: kSmallPadding),
                          ShimmerLoader(width: double.infinity, height: 16),
                          SizedBox(height: kSmallPadding),
                          ShimmerLoader(width: double.infinity, height: 16),
                        ],
                      ),
                    );
                  }

                  return Container(
                    padding: const EdgeInsets.all(kMediumPadding),
                    width: double.infinity,
                    child: Text('Alamat belum di tambahkan',
                        style: Get.theme.textTheme.bodyText1),
                  );
                }),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: kMediumPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Produk Yang Dipesan'),
                      Text('${controller.cartItems.length} Item',
                          style: Get.textTheme.bodyText1),
                    ],
                  ),
                ),
                const SizedBox(height: kMediumPadding),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kMediumPadding),
                  child: _checkoutCartItem(
                      cartItemEntity: controller.cartItems[0]),
                ),
                const SizedBox(height: kMediumPadding),
                (controller.cartItems.length == 1)
                    ? const SizedBox.shrink()
                    : ExpansionTile(
                        title: const Text('Semua Item'),
                        tilePadding: const EdgeInsets.symmetric(
                            horizontal: kMediumPadding),
                        children: controller.cartItems.asMap().entries.map((e) {
                          if (e.key == 0) {
                            return const SizedBox.shrink();
                          }

                          return Padding(
                            padding: const EdgeInsets.all(kMediumPadding),
                            child: _checkoutCartItem(cartItemEntity: e.value),
                          );
                        }).toList(),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://res.cloudinary.com/vjtechsolution/image/upload/v1627400333/ayo%20mobile/cod_edit.png',
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.paymentChannelPanel.open();
                        },
                        child: Row(
                          children: [
                            const Icon(AppIcon.editpencil,
                                size: 15, color: kPrimaryColor),
                            const SizedBox(width: 2),
                            Text('Edit', style: Get.textTheme.headline4),
                          ],
                        ),
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
                      Row(children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://cdn-icons-png.flaticon.com/512/726/726476.png',
                          height: 20,
                        ),
                        const SizedBox(width: kTinyPadding),
                        Text(
                          '1 Voucher Terpakai',
                          style: Get.textTheme.bodyText1,
                        ),
                      ]),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(kVoucherPage);
                        },
                        child: Row(
                          children: [
                            const Icon(AppIcon.editpencil,
                                size: 15, color: kPrimaryColor),
                            const SizedBox(width: 2),
                            Text('Edit', style: Get.textTheme.headline4),
                          ],
                        ),
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
                      const Text('Rincian Biaya'),
                      const SizedBox(height: kMediumPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Belanja', style: Get.textTheme.bodyText1),
                          Obx(() {
                            return Text(
                                Utility.currency(
                                    controller.priceTotal().toString()),
                                style: Get.textTheme.bodyText1);
                          }),
                        ],
                      ),
                      const SizedBox(height: kSmallPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Ongkir', style: Get.textTheme.bodyText1),
                          Obx(() {
                            return Text(
                                Utility.currency(
                                    controller.shippingFee().toString()),
                                style: Get.textTheme.bodyText1);
                          }),
                        ],
                      ),
                      const SizedBox(height: kSmallPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Biaya Admin', style: Get.textTheme.bodyText1),
                          Obx(() {
                            return Text(
                                Utility.currency(
                                    controller.appFee().toString()),
                                style: Get.textTheme.bodyText1);
                          }),
                        ],
                      ),
                      const SizedBox(height: kSmallPadding),
                      const Divider(height: 1),
                      const SizedBox(height: kSmallPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Diskon Voucher',
                              style: Get.textTheme.bodyText1),
                          Obx(() {
                            return Text(
                                Utility.currency(
                                    controller.voucher().toString()),
                                style: Get.textTheme.bodyText1);
                          }),
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
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: Obx(() {
                                          return Checkbox(
                                            value: controller.checkbox(),
                                            // visualDensity:
                                            //     VisualDensity.compact,
                                            onChanged: controller.point() < 1000
                                                ? null
                                                : (value) {
                                                    controller.setCheckbox(
                                                        value: value);
                                                  },
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: kSmallPadding),
                                  Obx(() {
                                    return Text(
                                      Utility.currency(
                                          controller.point().toString()),
                                      style: Get.textTheme.bodyText1!.copyWith(
                                        color: Colors.amber,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                          Obx(() {
                            return Text(
                                !controller.checkbox()
                                    ? 'Rp 0'
                                    : Utility.currency(
                                        controller.point().toString()),
                                style: Get.textTheme.bodyText1);
                          }),
                        ],
                      ),
                      const SizedBox(height: kSmallPadding),
                      const Divider(height: 1),
                      const SizedBox(height: kSmallPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Bayar', style: Get.textTheme.bodyText1),
                          Obx(() {
                            return Text(
                              Utility.currency(
                                  controller.payTotal().toString()),
                              style: Get.textTheme.headline4!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 56),
        ],
      ),
    ),
    bottomSheet: Obx(() {
      return Material(
        color: (controller.priceTotal() == 0 || controller.shippingFee() == 0)
            ? Colors.grey
            : kPrimaryColor,
        child: Ink(
          height: 56,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kMediumPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Bayar',
                        style: Get.theme.textTheme.caption,
                      ),
                      Obx(() {
                        return Text(
                          Utility.currency(controller.payTotal().toString()),
                          style: Get.theme.textTheme.caption,
                        );
                      }),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (controller.priceTotal() == 0 ||
                        controller.shippingFee() == 0)
                    ? null
                    : () {
                        Get.toNamed(kOrderCompletePage);
                      },
                overlayColor: MaterialStateProperty.resolveWith(
                    (states) => kPrimaryColor400),
                child: Ink(
                  padding: const EdgeInsets.all(kMediumPadding),
                  child: Row(
                    children: [
                      Text(
                        'Buat Pesanan',
                        style: Get.theme.textTheme.caption,
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        AppIcon.arrowright,
                        color: kLightColor,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }),
  );
}

Widget _deliveryTimePanel({required CheckoutPageController controller}) {
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
                  Text('Pilih Jam Pengiriman', style: Get.textTheme.headline3),
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
                                    : () {},
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
                                          color: (!shippingTimes[index].enable!)
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
                            SizedBox(height: kMediumPadding),
                            Text('Memuat Jam Pengiriman'),
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

Widget _paymentChannelPanel({required CheckoutPageController controller}) {
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
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: kTinyPadding),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMediumPadding),
                          child: Text(
                            'Tunai Melalui Kurir',
                            style: Get.textTheme.bodyText1,
                          ),
                        ),
                        const SizedBox(height: kSmallPadding),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(kMediumPadding),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        'https://res.cloudinary.com/vjtechsolution/image/upload/v1627400333/ayo%20mobile/cod_edit.png',
                                    width: 50,
                                  ),
                                  const SizedBox(width: kMediumPadding),
                                  Expanded(
                                      child: Text('Bayar Di Tempat',
                                          style: Get.textTheme.bodyText1))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: kLargePadding),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMediumPadding),
                          child: Text(
                            'Transfer Melalui Virtual Account',
                            style: Get.textTheme.bodyText1,
                          ),
                        ),
                        const SizedBox(height: kSmallPadding),
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(kMediumPadding),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            'https://res.cloudinary.com/vjtechsolution/image/upload/v1627370426/ayo%20mobile/AnyConv.com__bniva.png',
                                        width: 50,
                                      ),
                                      const SizedBox(width: kMediumPadding),
                                      Expanded(
                                          child: Text('BNI Virtual Account',
                                              style: Get.textTheme.bodyText1))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(kMediumPadding),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            'https://res.cloudinary.com/vjtechsolution/image/upload/v1627370426/ayo%20mobile/AnyConv.com__mandiriva.png',
                                        width: 50,
                                      ),
                                      const SizedBox(width: kMediumPadding),
                                      Expanded(
                                          child: Text('Mandiri Virtual Account',
                                              style: Get.textTheme.bodyText1))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(kMediumPadding),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            'https://res.cloudinary.com/vjtechsolution/image/upload/v1627370426/ayo%20mobile/AnyConv.com__bcava.png',
                                        width: 50,
                                      ),
                                      const SizedBox(width: kMediumPadding),
                                      Expanded(
                                          child: Text('BCA Virtual Account',
                                              style: Get.textTheme.bodyText1))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: kLargePadding),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMediumPadding),
                          child: Text(
                            'Tunai Melalui Retail',
                            style: Get.textTheme.bodyText1,
                          ),
                        ),
                        const SizedBox(height: kSmallPadding),
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(kMediumPadding),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            'https://res.cloudinary.com/vjtechsolution/image/upload/v1627370428/ayo%20mobile/AnyConv.com__alfamidi.png',
                                        width: 50,
                                      ),
                                      const SizedBox(width: kMediumPadding),
                                      Expanded(
                                          child: Text('Alfamidi',
                                              style: Get.textTheme.bodyText1))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(kMediumPadding),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            'https://res.cloudinary.com/vjtechsolution/image/upload/v1627370428/ayo%20mobile/AnyConv.com__alfamart.png',
                                        width: 50,
                                      ),
                                      const SizedBox(width: kMediumPadding),
                                      Expanded(
                                          child: Text('Alfamart',
                                              style: Get.textTheme.bodyText1))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: kLargePadding),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMediumPadding),
                          child: Text(
                            'Bayar Melalui E-Wallet',
                            style: Get.textTheme.bodyText1,
                          ),
                        ),
                        const SizedBox(height: kSmallPadding),
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(kMediumPadding),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            'https://res.cloudinary.com/vjtechsolution/image/upload/v1627370425/ayo%20mobile/AnyConv.com__qris.png',
                                        width: 50,
                                      ),
                                      const SizedBox(width: kMediumPadding),
                                      Expanded(
                                          child: Text('QRIS',
                                              style: Get.textTheme.bodyText1))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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

Widget _checkoutCartItem({required CartItemEntity cartItemEntity}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: cartItemEntity.productModel!.image!,
          width: 50,
          placeholder: (context, url) =>
              const ShimmerLoader(width: 50, height: 50),
        ),
      ),
      const SizedBox(width: kMediumPadding),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartItemEntity.productModel!.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Get.theme.textTheme.bodyText1,
            ),
            const SizedBox(height: kTinyPadding),
            Text(
              '${cartItemEntity.itemQtyTotal} barang (${cartItemEntity.itemQtyTotal} ${cartItemEntity.productModel!.unit!})',
              style: Get.textTheme.bodyText2!.copyWith(fontSize: kSmallFont),
            ),
            const SizedBox(height: kTinyPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Utility.currency(cartItemEntity.itemPriceTotal!),
                  style: Get.theme.textTheme.headline4,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color:
                        (cartItemEntity.productModel!.shipping! == 'TERJADWAL')
                            ? Colors.blue
                            : kPrimaryColor,
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
                  child: TextField(
                    controller: TextEditingController()
                      ..text = cartItemEntity.note ?? '',
                    decoration: InputDecoration(
                      hintText: 'Berikan catatan',
                      hintStyle: Get.textTheme.bodyText2,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
