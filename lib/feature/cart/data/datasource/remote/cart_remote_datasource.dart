import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/error/network_exception.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/cart/data/datasource/cart_datasource.dart';
import 'package:gocery/feature/cart/data/model/cart_item_model.dart';

class CartRemoteDatasource implements CartDatasource {
  CartRemoteDatasource({required this.client});

  final Network client;

  @override
  Future<List<CartItemModel>> getCartItems() async {
    try {
      final response = await client.get(kCartIndex);

      final models = await compute(_cartItems, response.toString());

      return models;
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  @override
  Future<void> updateCart({required List<CartItemModel> param}) async {
    try {
      await client.post(kCartUpdate,
          data: FormData.fromMap({
            'carts': param
                .map((e) => {
                      'product_uid': e.productUid,
                      'item_qty_total': e.itemQtyTotal,
                      'note': e.note,
                    })
                .toList(),
          }));
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await client.delete(kCartClear, data: {});
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  List<CartItemModel> _cartItems(dynamic data) {
    var parsed = jsonDecode(data);

    List<CartItemModel> datas = List<CartItemModel>.from(
        parsed.map((item) => CartItemModel.fromJson(item)));

    return datas;
  }
}