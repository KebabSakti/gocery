import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/cart/data/datasource/cart_datasource.dart';
import 'package:gocery/feature/cart/data/model/cart_item_model.dart';

class CartRemoteDatasource implements CartDatasource {
  CartRemoteDatasource({required this.client});

  final Network client;

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final response = await client.get(kCartIndex);

    final models = await compute(_cartItems, response.toString());

    return models;
  }

  @override
  Future<void> updateCart({required List<CartItemModel> param}) async {
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
  }

  @override
  Future<void> clearCart() async {
    await client.delete(kCartClear, data: {});
  }

  List<CartItemModel> _cartItems(dynamic data) {
    var parsed = jsonDecode(data);

    List<CartItemModel> datas = List<CartItemModel>.from(
        parsed.map((item) => CartItemModel.fromJson(item)));

    return datas;
  }

  @override
  Future<bool> stocks({required List<String> param}) async {
    final response =
        await client.get(kOrderStock, query: {'uids': param.join(',')});

    var parsed = jsonDecode(response.toString());

    return parsed;
  }
}
