import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';

class CheckoutCartItem extends StatelessWidget {
  const CheckoutCartItem({
    Key? key,
    required this.cartItemEntity,
    required this.onSubmitted,
  }) : super(key: key);

  final CartItemEntity cartItemEntity;
  final void Function(String value) onSubmitted;

  @override
  Widget build(BuildContext context) {
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
                      color: (cartItemEntity.productModel!.shipping! ==
                              'TERJADWAL')
                          ? Colors.blue
                          : kPrimaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      cartItemEntity.productModel!.shipping!,
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
                      onSubmitted: onSubmitted,
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
}
