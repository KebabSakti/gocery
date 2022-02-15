import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/error/network_exception.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/banner/data/model/banner_model.dart';

abstract class BannerRemoteDatasource {
  Future<List<BannerModel>> indexBanner();
}

class BannerRemoteDatasourceImpl implements BannerRemoteDatasource {
  BannerRemoteDatasourceImpl({required this.client});

  final Network client;

  @override
  Future<List<BannerModel>> indexBanner() async {
    try {
      var response = await client.get(kBannerIndex);

      return compute(_banners, response.toString());
    } on DioError catch (exception, stackTrace) {
      throw NetworkException(exception, stackTrace);
    }
  }
}

List<BannerModel> _banners(dynamic data) {
  var parsed = jsonDecode(data);

  List<BannerModel> datas =
      List<BannerModel>.from(parsed.map((item) => BannerModel.fromJson(item)));

  return datas;
}
