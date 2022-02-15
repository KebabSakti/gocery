import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/product/data/datasource/product_datasource.dart';
import 'package:gocery/feature/product/data/model/index_product_param_model.dart';
import 'package:gocery/feature/product/data/model/product_model.dart';
import 'package:gocery/feature/product/data/model/product_paging_model.dart';
import 'package:gocery/feature/product/data/model/product_statistic_param.dart';

class ProductRemoteDatasourceImpl implements ProductDatasource {
  ProductRemoteDatasourceImpl({required this.client});

  final Network client;

  @override
  Future<ProductPagingModel> indexProduct(
      {required IndexProductParamModel param}) async {
    var response = await client.get(
      kProductIndex,
      query: param.toJson(),
    );

    ProductPagingModel model =
        await compute(productPagingModelFromJson, response.toString());

    return model;
  }

  @override
  Future<ProductModel> showProduct({required String uid}) async {
    var response = await client.get(kProductShow + '/' + uid + '/show');

    ProductModel model =
        await compute(productModelFromJson, response.toString());

    return model;
  }

  @override
  Future<ProductModel> toggleProductFavourite({required String uid}) async {
    var response = await client.post(kProductFavourite, data: {'uid': uid});

    ProductModel model =
        await compute(productModelFromJson, response.toString());

    return model;
  }

  @override
  Future statisticProduct({required ProductStatisticParam param}) async {
    await client.post(kProductStatistic, data: param.toJson());
  }

  @override
  Future<List<ProductModel>> productViewHistories() async {
    final response = await client.get(kProductViewHistory);

    List<ProductModel> models = await compute(_products, response.toString());

    return models;
  }
}

List<ProductModel> _products(dynamic data) {
  var parsed = jsonDecode(data);

  List<ProductModel> datas = List<ProductModel>.from(
      parsed.map((item) => ProductModel.fromJson(item)));

  return datas;
}
