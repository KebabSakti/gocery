import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/product/data/model/index_product_param_model.dart';
import 'package:gocery/feature/product/data/model/product_paging_model.dart';

abstract class ProductRemoteDatasource {
  Future<ProductPagingModel> indexProduct(
      {required IndexProductParamModel param});
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
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
}
