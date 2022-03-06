import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/payment_channel_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/voucher_entity.dart';
import 'package:gocery/feature/partner/domain/entity/courier_profile_entity.dart';

class OrderSubmitParamEntity {
  OrderSubmitParamEntity({
    this.shippingAddressEntity,
    this.paymentChannelEntity,
    this.orderShippingEntity,
    this.cartItemEntity,
    this.voucherEntity,
    this.courierProfileEntity,
  });

  final ShippingAddressEntity? shippingAddressEntity;
  final PaymentChannelEntity? paymentChannelEntity;
  final List<OrderShippingEntity>? orderShippingEntity;
  final List<CartItemEntity>? cartItemEntity;
  final List<VoucherEntity>? voucherEntity;
  final List<CourierProfileEntity>? courierProfileEntity;

  OrderSubmitParamEntity copyWith({
    ShippingAddressEntity? shippingAddressEntity,
    PaymentChannelEntity? paymentChannelEntity,
    List<OrderShippingEntity>? orderShippingEntity,
    List<CartItemEntity>? cartItemEntity,
    List<VoucherEntity>? voucherEntity,
    List<CourierProfileEntity>? courierProfileEntity,
  }) =>
      OrderSubmitParamEntity(
        cartItemEntity: cartItemEntity ?? this.cartItemEntity,
        orderShippingEntity: orderShippingEntity ?? this.orderShippingEntity,
        paymentChannelEntity: paymentChannelEntity ?? this.paymentChannelEntity,
        shippingAddressEntity:
            shippingAddressEntity ?? this.shippingAddressEntity,
        voucherEntity: voucherEntity ?? this.voucherEntity,
        courierProfileEntity: courierProfileEntity ?? this.courierProfileEntity,
      );
}
