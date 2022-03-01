import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_item_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_status_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/payment_channel_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_detail_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/voucher_entity.dart';

class OrderEntity {
  OrderEntity({
    this.customerAccountUid,
    this.uid,
    this.invoice,
    this.qtyTotal,
    this.priceTotal,
    this.shippingFee,
    this.appFee,
    this.voucherDeduction,
    this.pointDeduction,
    this.payTotal,
    this.payment,
    this.orderStatusEntity,
    this.paymentChannelEntity,
    this.shippingAddressEntity,
    this.orderItemEntity,
    this.voucherEntity,
    this.shippingDetailEntity,
    this.orderShippingEntity,
    this.cartItemEntity,
  });

  final String? customerAccountUid;
  final String? uid;
  final String? invoice;
  final int? qtyTotal;
  final String? priceTotal;
  final String? shippingFee;
  final String? appFee;
  final String? voucherDeduction;
  final String? pointDeduction;
  final String? payTotal;
  final String? payment;
  final OrderStatusEntity? orderStatusEntity;
  final PaymentChannelEntity? paymentChannelEntity;
  final ShippingAddressEntity? shippingAddressEntity;
  final OrderItemEntity? orderItemEntity;
  final List<VoucherEntity>? voucherEntity;
  final ShippingDetailEntity? shippingDetailEntity;
  final List<OrderShippingEntity>? orderShippingEntity;
  final List<CartItemEntity>? cartItemEntity;

  OrderEntity copyWith({
    String? customerAccountUid,
    String? uid,
    String? invoice,
    int? qtyTotal,
    String? priceTotal,
    String? shippingFee,
    String? appFee,
    String? voucherDeduction,
    String? pointDeduction,
    String? payTotal,
    String? payment,
    OrderStatusEntity? orderStatusEntity,
    PaymentChannelEntity? paymentChannelEntity,
    ShippingAddressEntity? shippingAddressEntity,
    OrderItemEntity? orderItemEntity,
    List<VoucherEntity>? voucherEntity,
    ShippingDetailEntity? shippingDetailEntity,
    List<OrderShippingEntity>? orderShippingEntity,
    List<CartItemEntity>? cartItemEntity,
  }) =>
      OrderEntity(
        customerAccountUid: customerAccountUid ?? this.customerAccountUid,
        uid: uid ?? this.uid,
        invoice: invoice ?? this.invoice,
        qtyTotal: qtyTotal ?? this.qtyTotal,
        priceTotal: priceTotal ?? this.priceTotal,
        shippingFee: shippingFee ?? this.shippingFee,
        appFee: appFee ?? this.appFee,
        voucherDeduction: voucherDeduction ?? this.voucherDeduction,
        pointDeduction: pointDeduction ?? this.pointDeduction,
        payTotal: payTotal ?? this.payTotal,
        payment: payment ?? this.payment,
        orderStatusEntity: orderStatusEntity ?? this.orderStatusEntity,
        paymentChannelEntity: paymentChannelEntity ?? this.paymentChannelEntity,
        shippingAddressEntity:
            shippingAddressEntity ?? this.shippingAddressEntity,
        orderItemEntity: orderItemEntity ?? this.orderItemEntity,
        voucherEntity: voucherEntity ?? this.voucherEntity,
        shippingDetailEntity: shippingDetailEntity ?? this.shippingDetailEntity,
        orderShippingEntity: orderShippingEntity ?? this.orderShippingEntity,
        cartItemEntity: cartItemEntity ?? this.cartItemEntity,
      );
}
