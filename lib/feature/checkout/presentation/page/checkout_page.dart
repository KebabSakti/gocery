import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/payment_channel_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/voucher_entity.dart';
import 'package:gocery/feature/checkout/presentation/getx/controller/checkout_page_controller.dart';
import 'package:gocery/feature/checkout/presentation/widget/checkout_cart_item.dart';
import 'package:gocery/feature/checkout/presentation/widget/delivery_time_panel.dart';
import 'package:gocery/feature/checkout/presentation/widget/payment_chanel_panel.dart';
import 'package:gocery/feature/checkout/presentation/widget/voucher_panel.dart';

class CheckoutPage extends GetView<CheckoutPageController> {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onBackButtonPressed,
      child: Stack(
        children: [
          Scaffold(
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
                                            onTap: controller
                                                .toDeliveryAddressPage,
                                            child: Text('Edit',
                                                style:
                                                    Get.textTheme.headline4)),
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
                                ShimmerLoader(
                                    width: double.infinity, height: 16),
                                SizedBox(height: kSmallPadding),
                                ShimmerLoader(
                                    width: double.infinity, height: 16),
                                SizedBox(height: kSmallPadding),
                                ShimmerLoader(
                                    width: double.infinity, height: 16),
                                SizedBox(height: kSmallPadding),
                                ShimmerLoader(
                                    width: double.infinity, height: 16),
                                SizedBox(height: kSmallPadding),
                                ShimmerLoader(
                                    width: double.infinity, height: 16),
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
                                          controller.setAddressNote(
                                              note: value);
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
                              onPressed: () {
                                controller.toDeliveryAddressPage();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: kLightColor,
                                onPrimary: kLightColor100,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
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
                          final orderShippingState =
                              controller.orderShippingState();

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 4),
                                            decoration: BoxDecoration(
                                              color:
                                                  (shippings[index].shipping! ==
                                                          'TERJADWAL')
                                                      ? Colors.blue
                                                      : kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(6),
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
                                          Text('Jarak',
                                              style: Get.textTheme.bodyText1),
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
                                              Utility.currency(shippings[index]
                                                  .price
                                                  .toString()),
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
                                          (shippings[index].shipping ==
                                                  'LANGSUNG')
                                              ? Text('LANGSUNG',
                                                  style:
                                                      Get.textTheme.bodyText1)
                                              : Row(
                                                  children: [
                                                    Text(
                                                        shippings[index]
                                                            .time
                                                            .toString(),
                                                        style: Get.textTheme
                                                            .bodyText1),
                                                    const SizedBox(width: 6),
                                                    GestureDetector(
                                                      onTap: controller
                                                          .openDeliveryTimePanel,
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                              AppIcon
                                                                  .editpencil,
                                                              size: 15,
                                                              color:
                                                                  kPrimaryColor),
                                                          const SizedBox(
                                                              width: 2),
                                                          Text('Edit',
                                                              style: Get
                                                                  .textTheme
                                                                  .headline4),
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
                                  ShimmerLoader(
                                      width: double.infinity, height: 16),
                                  SizedBox(height: kSmallPadding),
                                  ShimmerLoader(
                                      width: double.infinity, height: 16),
                                  SizedBox(height: kSmallPadding),
                                  ShimmerLoader(
                                      width: double.infinity, height: 16),
                                  SizedBox(height: kSmallPadding),
                                  ShimmerLoader(
                                      width: double.infinity, height: 16),
                                  SizedBox(height: kSmallPadding),
                                  ShimmerLoader(
                                      width: double.infinity, height: 16),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMediumPadding),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMediumPadding),
                          child: CheckoutCartItem(
                            cartItemEntity: controller.cartItems[0],
                            onSubmitted: (value) {
                              controller.setCartItemNote(
                                  param: controller.cartItems[0]
                                      .copyWith(note: value));
                            },
                          ),
                        ),
                        const SizedBox(height: kMediumPadding),
                        (controller.cartItems.length == 1)
                            ? const SizedBox.shrink()
                            : ExpansionTile(
                                title: const Text('Semua Item'),
                                tilePadding: const EdgeInsets.symmetric(
                                    horizontal: kMediumPadding),
                                children: controller.cartItems
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  if (e.key == 0) {
                                    return const SizedBox.shrink();
                                  }

                                  return Padding(
                                    padding:
                                        const EdgeInsets.all(kMediumPadding),
                                    child: CheckoutCartItem(
                                      cartItemEntity: e.value,
                                      onSubmitted: (value) {
                                        controller.setCartItemNote(
                                            param: controller.cartItems[0]
                                                .copyWith(note: value));
                                      },
                                    ),
                                  );
                                }).toList(),
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
                        Padding(
                          padding: const EdgeInsets.all(kMediumPadding),
                          child: Obx(() {
                            final defaultChannelState =
                                controller.defaultChannelState();

                            if (defaultChannelState.status == Status.success) {
                              final PaymentChannelEntity payment =
                                  defaultChannelState.data!;

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: payment.picture!,
                                          height: 20,
                                        ),
                                        const SizedBox(width: kSmallPadding),
                                        Expanded(
                                          child: Text(payment.name!,
                                              style: Get.textTheme.bodyText1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.openPaymentChannelPanel();
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(AppIcon.editpencil,
                                            size: 15, color: kPrimaryColor),
                                        const SizedBox(width: 2),
                                        Text('Edit',
                                            style: Get.textTheme.headline4),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }

                            return Row(
                              children: const [
                                ShimmerLoader(width: 50, height: 20),
                                SizedBox(width: kSmallPadding),
                                Expanded(child: ShimmerLoader(height: 16)),
                              ],
                            );
                          }),
                        ),
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.all(kMediumPadding),
                          child: Obx(() {
                            final voucherState = controller.voucherState();

                            if (voucherState.status == Status.success) {
                              final List<VoucherEntity> vouchers = voucherState
                                  .data!
                                  .where((element) => element.selected == true)
                                  .toList();

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          'https://cdn-icons-png.flaticon.com/512/726/726476.png',
                                      height: 20,
                                    ),
                                    const SizedBox(width: kTinyPadding),
                                    Text(
                                      vouchers.isEmpty
                                          ? 'Pakai Voucher Lebih Murah'
                                          : '${vouchers.length} Voucher Terpakai',
                                      style: Get.textTheme.bodyText1,
                                    ),
                                  ]),
                                  GestureDetector(
                                    onTap: () {
                                      controller.openVoucherPanel();
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(AppIcon.editpencil,
                                            size: 15, color: kPrimaryColor),
                                        const SizedBox(width: 2),
                                        Text('Edit',
                                            style: Get.textTheme.headline4),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }

                            return Row(
                              children: const [
                                ShimmerLoader(
                                    width: 16, height: 16, radius: 16),
                                SizedBox(width: kSmallPadding),
                                Expanded(child: ShimmerLoader(height: 16)),
                              ],
                            );
                          }),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Belanja',
                                      style: Get.textTheme.bodyText1),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Ongkir',
                                      style: Get.textTheme.bodyText1),
                                  Obx(() {
                                    return Text(
                                        Utility.currency(controller
                                            .shippingFee()
                                            .toString()),
                                        style: Get.textTheme.bodyText1);
                                  }),
                                ],
                              ),
                              const SizedBox(height: kSmallPadding),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text('Biaya Admin',
                                          style: Get.textTheme.bodyText1),
                                      const SizedBox(width: 4),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Potongan Voucher',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    value:
                                                        controller.checkbox(),
                                                    // visualDensity:
                                                    //     VisualDensity.compact,
                                                    onChanged:
                                                        controller.point() <
                                                                1000
                                                            ? null
                                                            : (value) {
                                                                controller
                                                                    .setCheckbox(
                                                                        value:
                                                                            value);
                                                              },
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: kSmallPadding),
                                          Obx(() {
                                            return Text(
                                              Utility.currency(controller
                                                  .point()
                                                  .toString()),
                                              style: Get.textTheme.bodyText1!
                                                  .copyWith(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Bayar',
                                      style: Get.textTheme.bodyText1),
                                  Obx(() {
                                    return Text(
                                      controller.payTotal() == 0.0
                                          ? 'GRATIS!!'
                                          : Utility.currency(
                                              controller.payTotal().toString(),
                                            ),
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
                color: (controller.priceTotal() == 0.0 ||
                        controller.shippingFee() == 0.0)
                    ? Colors.grey
                    : kPrimaryColor,
                child: Ink(
                  height: 56,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMediumPadding),
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
                                  controller.payTotal() == 0.0
                                      ? 'GRATIS!!'
                                      : Utility.currency(
                                          controller.payTotal().toString(),
                                        ),
                                  style: Get.theme.textTheme.caption,
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (controller.priceTotal() == 0.0 ||
                                controller.shippingFee() == 0.0)
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
          ),
          DeliveryTimePanel(controller: controller),
          PaymentChanelPanel(controller: controller),
          VoucherPanel(controller: controller),
        ],
      ),
    );
  }
}
