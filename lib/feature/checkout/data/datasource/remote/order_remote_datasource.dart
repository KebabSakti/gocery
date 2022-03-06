import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/error/network_exception.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/checkout/data/datasource/order_datasource.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_param_model.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_model.dart';
import 'package:gocery/feature/checkout/data/model/payment_channel_model.dart';
import 'package:gocery/feature/checkout/data/model/shipping_address_model.dart';
import 'package:gocery/feature/checkout/data/model/shipping_time_model.dart';
import 'package:gocery/feature/checkout/data/model/voucher_model.dart';
import 'package:gocery/feature/checkout/domain/entity/order_submit_param_entity.dart';

class OrderRemoteDatasource implements OrderDatasource {
  OrderRemoteDatasource({required this.client});

  final Network client;

  @override
  Future<ShippingAddressModel> getLastAddress() async {
    try {
      final response = await client.get(kAddressLast);

      final ShippingAddressModel model =
          await compute(shippingAddressModelFromJson, response.toString());

      return model;
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  @override
  Future<List<OrderShippingModel>> getOrderShipping(
      {required OrderShippingParamModel param}) async {
    try {
      final response = await client.get(kOrderFee, query: {
        'latitude': param.latitude,
        'longitude': param.longitude,
        'type': param.type
      });

      final List<OrderShippingModel> models =
          await compute(_orderShippings, response.toString());

      return models;
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  @override
  Future<List<ShippingTimeModel>> getShippingTimes() async {
    try {
      final response = await client.get(kOrderTime);

      final List<ShippingTimeModel> models =
          await compute(_orderTimes, response.toString());

      return models;
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  @override
  Future<List<PaymentChannelModel>> getPaymentChannels() async {
    try {
      final response = await client.get(kOrderPaymentChannel);

      final List<PaymentChannelModel> models =
          await compute(_paymentChannels, response.toString());

      return models;
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  @override
  Future<PaymentChannelModel> getDefaultPaymentChannel() async {
    try {
      final response = await client.get(kOrderDefaultPaymentChannel);

      final PaymentChannelModel model =
          await compute(paymentChannelModelFromJson, response.toString());

      return model;
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  @override
  Future<List<VoucherModel>> getVouchers() async {
    try {
      final response = await client.get(kOrderVoucher);

      final List<VoucherModel> models =
          await compute(_vouchers, response.toString());

      return models;
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  @override
  Future<void> submitOrder({required OrderSubmitParamEntity param}) async {
    // throw UnimplementedError();
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
