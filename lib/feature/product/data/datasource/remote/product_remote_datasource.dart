import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/error/network_exception.dart';
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
    try {
      var response = await client.get(
        kProductIndex,
        query: param.toJson(),
      );

      ProductPagingModel model =
          await compute(productPagingModelFromJson, response.toString());

      return model;
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  @override
  Future<ProductModel> showProduct({required String uid}) async {
    try {
      var response = await client.get(kProductShow + '/' + uid + '/show');

      ProductModel model =
          await compute(productModelFromJson, response.toString());

      return model;
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  @override
  Future<ProductModel> toggleProductFavourite({required String uid}) async {
    try {
      var response = await client.post(kProductFavourite, data: {'uid': uid});

      ProductModel model =
          await compute(productModelFromJson, response.toString());

      return model;
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  @override
  Future statisticProduct({required ProductStatisticParam param}) async {
    try {
      await client.post(kProductStatistic, data: param.toJson());
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }

  @override
  Future<List<ProductModel>> productViewHistories() async {
    try {
      final response = await client.get(kProductViewHistory);

      List<ProductModel> models = await compute(_products, response.toString());

      return models;
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }
}

List<ProductModel> _products(dynamic data) {
  try {
    var parsed = jsonDecode(data);

    List<ProductModel> datas = List<ProductModel>.from(
        parsed.map((item) => ProductModel.fromJson(item)));

    return datas;
  } on DioError catch (exception, stackTrace) {
    throw NetworkException(exception, stackTrace);
  }
}
