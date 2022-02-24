import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/error/network_exception.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/checkout/data/datasource/order_datasource.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_param_model.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_model.dart';
import 'package:gocery/feature/checkout/data/model/shipping_address_model.dart';
import 'package:gocery/feature/checkout/data/model/order_model.dart';

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
  Future<void> submitOrder({required OrderModel param}) async {
    // TODO: implement submitOrder
    throw UnimplementedError();
  }
}

List<OrderShippingModel> _orderShippings(dynamic data) {
  var parsed = jsonDecode(data);

  List<OrderShippingModel> datas = List<OrderShippingModel>.from(
      parsed.map((item) => OrderShippingModel.fromJson(item)));

  return datas;
}
