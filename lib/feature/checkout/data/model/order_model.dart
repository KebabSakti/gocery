// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/cart/data/model/cart_item_model.dart';
import 'package:gocery/feature/checkout/data/model/order_item_model.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_model.dart';
import 'package:gocery/feature/checkout/data/model/order_status_model.dart';
import 'package:gocery/feature/checkout/data/model/payment_channel_model.dart';
import 'package:gocery/feature/checkout/data/model/shipping_address_model.dart';
import 'package:gocery/feature/checkout/data/model/shipping_detail_model.dart';
import 'package:gocery/feature/checkout/data/model/voucher_model.dart';
import 'package:gocery/feature/checkout/domain/entity/order_entity.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel extends OrderEntity {
  OrderModel({
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
    OrderStatusModel? orderStatusModel,
    PaymentChannelModel? paymentChannelModel,
    ShippingAddressModel? shippingAddressModel,
    OrderItemModel? orderItemModel,
    List<VoucherModel>? voucherModel,
    ShippingDetailModel? shippingDetailModel,
    List<OrderShippingModel>? orderShippingModel,
    List<CartItemModel>? cartItemModel,
  }) : super(
          customerAccountUid: customerAccountUid,
          uid: uid,
          invoice: invoice,
          qtyTotal: qtyTotal,
          priceTotal: priceTotal,
          shippingFee: shippingFee,
          appFee: appFee,
          voucherDeduction: voucherDeduction,
          pointDeduction: pointDeduction,
          payTotal: payTotal,
          payment: payment,
          orderStatusEntity: orderStatusModel,
          paymentChannelEntity: paymentChannelModel,
          shippingAddressEntity: shippingAddressModel,
          orderItemEntity: orderItemModel,
          voucherEntity: voucherModel,
          shippingDetailEntity: shippingDetailModel,
          orderShippingEntity: orderShippingModel,
          cartItemEntity: cartItemModel,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        customerAccountUid: json["customer_account_uid"],
        uid: json["uid"],
        invoice: json["invoice"],
        qtyTotal: json["qty_total"],
        priceTotal: json["price_total"],
        shippingFee: json["shipping_fee"],
        appFee: json["app_fee"],
        voucherDeduction: json["voucher_deduction"],
        pointDeduction: json["point_deduction"],
        payTotal: json["pay_total"],
        payment: json["payment"],
        orderStatusModel: OrderStatusModel.fromJson(json["order_status_model"]),
        paymentChannelModel:
            PaymentChannelModel.fromJson(json["payment_channel_model"]),
        shippingAddressModel:
            ShippingAddressModel.fromJson(json["shipping_address_model"]),
        orderItemModel: OrderItemModel.fromJson(json["order_item_model"]),
        voucherModel: List<VoucherModel>.from(
            json["voucher_model"].map((x) => VoucherModel.fromJson(x))),
        shippingDetailModel:
            ShippingDetailModel.fromJson(json["shipping_detail_model"]),
        orderShippingModel: List<OrderShippingModel>.from(
            json["order_shipping_model"]
                .map((x) => OrderShippingModel.fromJson(x))),
        cartItemModel: List<CartItemModel>.from(
            json["cart_item_model"].map((x) => CartItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customer_account_uid": customerAccountUid,
        "uid": uid,
        "invoice": invoice,
        "qty_total": qtyTotal,
        "price_total": priceTotal,
        "shipping_fee": shippingFee,
        "app_fee": appFee,
        "voucher_deduction": voucherDeduction,
        "point_deduction": pointDeduction,
        "pay_total": payTotal,
        "payment": payment,
        "order_status_model": (orderStatusEntity as OrderStatusModel).toJson(),
        "payment_channel_model":
            (paymentChannelEntity as PaymentChannelModel).toJson(),
        "shipping_address_model":
            (shippingAddressEntity as ShippingAddressModel).toJson(),
        "order_item_model": (orderItemEntity as OrderItemModel).toJson(),
        "voucher_model": List<VoucherModel>.from(
            (voucherEntity as List<VoucherModel>).map((x) => x.toJson())),
        "shipping_detail_model":
            (shippingDetailEntity as ShippingDetailModel).toJson(),
        "order_shipping_model": List<OrderShippingModel>.from(
            (orderShippingEntity as List<OrderShippingModel>)
                .map((x) => x.toJson())),
        "cart_item_model": List<CartItemModel>.from(
            (cartItemEntity as List<CartItemModel>).map((x) => x.toJson())),
      };
}
