import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/cart/data/model/cart_item_model.dart';
import 'package:gocery/feature/checkout/data/datasource/order_datasource.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_param_model.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_model.dart';
import 'package:gocery/feature/checkout/data/model/payment_channel_model.dart';
import 'package:gocery/feature/checkout/data/model/shipping_address_model.dart';
import 'package:gocery/feature/checkout/data/model/shipping_time_model.dart';
import 'package:gocery/feature/checkout/data/model/voucher_model.dart';
import 'package:gocery/feature/checkout/domain/entity/order_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/payment_channel_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/voucher_entity.dart';

class OrderRemoteDatasource implements OrderDatasource {
  OrderRemoteDatasource({
    required this.client,
    // required this.googleMapsPlaces,
    // required this.googleMapsGeocoding,
  });

  final Network client;
  // final GoogleMapsPlaces googleMapsPlaces;
  // final GoogleMapsGeocoding googleMapsGeocoding;

  @override
  Future<ShippingAddressModel> getLastAddress() async {
    final response = await client.get(kAddressLast);

    final ShippingAddressModel model =
        await compute(shippingAddressModelFromJson, response.toString());

    return model;
  }

  @override
  Future<List<OrderShippingModel>> getOrderShipping(
      {required OrderShippingParamModel param}) async {
    final response = await client.get(kOrderFee, query: {
      'latitude': param.latitude,
      'longitude': param.longitude,
      'type': param.type
    });

    final List<OrderShippingModel> models =
        await compute(_orderShippings, response.toString());

    return models;
  }

  @override
  Future<List<ShippingTimeModel>> getShippingTimes() async {
    final response = await client.get(kOrderTime);

    final List<ShippingTimeModel> models =
        await compute(_orderTimes, response.toString());

    return models;
  }

  @override
  Future<List<PaymentChannelModel>> getPaymentChannels() async {
    final response = await client.get(kOrderPaymentChannel);

    final List<PaymentChannelModel> models =
        await compute(_paymentChannels, response.toString());

    return models;
  }

  @override
  Future<PaymentChannelModel> getDefaultPaymentChannel() async {
    final response = await client.get(kOrderDefaultPaymentChannel);

    final PaymentChannelModel model =
        await compute(paymentChannelModelFromJson, response.toString());

    return model;
  }

  @override
  Future<List<VoucherModel>> getVouchers() async {
    final response = await client.get(kOrderVoucher);

    final List<VoucherModel> models =
        await compute(_vouchers, response.toString());

    return models;
  }

  @override
  Future<void> submitOrder({required OrderEntity param}) async {
    await client.post(
      kOrderSubmit,
      data: {
        'uid': param.uid,
        'items': param.cartItemEntity!
            .map((e) => CartItemModel.toModel(cartItemEntity: e).toJson())
            .toList(),
        'delivery': ShippingAddressModel.toModel(
                shippingAddressEntity:
                    param.shippingAddressEntity as ShippingAddressEntity)
            .toJson(),
        'shippings': param.orderShippingEntity!
            .map((e) =>
                OrderShippingModel.toModel(orderShippingEntity: e).toJson())
            .toList(),
        'payment': PaymentChannelModel.toModel(
                paymentChannelEntity:
                    param.paymentChannelEntity as PaymentChannelEntity)
            .toJson(),
        'vouchers': param.voucherEntity!
            .map((e) => VoucherModel.toModel(
                    voucherEntity: param.voucherEntity as VoucherEntity)
                .toJson())
            .toList(),
        'qty_total': param.qtyTotal,
        'price_total': param.priceTotal,
        'shipping_fee': param.shippingFee,
        'app_fee': param.appFee,
        'voucher_deduction': param.voucherDeduction,
        'point_deduction': param.pointDeduction,
        'pay_total': param.payTotal,
      },
    );
  }

  @override
  Future<List<ShippingAddressModel>> placesPredictions(
      {String keyword = ''}) async {
    throw UnimplementedError();
  }

  @override
  Future<void> cancelOrder({required String orderUid}) async {
    await client.get(kOrderCancel, query: {'order_uid': orderUid});
  }
}

List<OrderShippingModel> _orderShippings(dynamic data) {
  var parsed = jsonDecode(data);

  List<OrderShippingModel> datas = List<OrderShippingModel>.from(
      parsed.map((item) => OrderShippingModel.fromJson(item)));

  return datas;
}

List<ShippingTimeModel> _orderTimes(dynamic data) {
  var parsed = jsonDecode(data);

  List<ShippingTimeModel> datas = List<ShippingTimeModel>.from(
      parsed.map((item) => ShippingTimeModel.fromJson(item)));

  return datas;
}

List<PaymentChannelModel> _paymentChannels(dynamic data) {
  var parsed = jsonDecode(data);

  List<PaymentChannelModel> datas = List<PaymentChannelModel>.from(
      parsed.map((item) => PaymentChannelModel.fromJson(item)));

  return datas;
}

List<VoucherModel> _vouchers(dynamic data) {
  var parsed = jsonDecode(data);

  List<VoucherModel> datas = List<VoucherModel>.from(
      parsed.map((item) => VoucherModel.fromJson(item)));

  return datas;
}
