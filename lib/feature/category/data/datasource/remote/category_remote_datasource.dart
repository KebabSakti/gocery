import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/error/network_exception.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/category/data/model/category_model.dart';

abstract class CategoryRemoteDatasource {
  Future<List<CategoryModel>> index();
}

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource {
  CategoryRemoteDatasourceImpl({required this.client});

  final Network client;

  @override
  Future<List<CategoryModel>> index() async {
    try {
      var response = await client.get(kCategoryIndex);

      return compute(_categories, response.toString());
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }
}

List<CategoryModel> _categories(dynamic data) {
  var parsed = jsonDecode(data);

  List<CategoryModel> datas = List<CategoryModel>.from(parsed.map(
    (item) => CategoryModel.fromJson(item),
  ));

  return datas;
}
