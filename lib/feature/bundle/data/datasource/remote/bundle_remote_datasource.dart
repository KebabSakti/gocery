import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/bundle/data/model/bundle_model.dart';

abstract class BundleRemoteDatasource {
  Future<List<BundleModel>> indexBundle();
}

class BundleRemoteDatasourceImpl implements BundleRemoteDatasource {
  BundleRemoteDatasourceImpl({required this.client});

  final Network client;

  @override
  Future<List<BundleModel>> indexBundle() async {
    var response = await client.get(kBundleIndex);

    return compute(_bundles, response.toString());
  }
}

List<BundleModel> _bundles(dynamic data) {
  var parsed = jsonDecode(data);

  List<BundleModel> datas =
      List<BundleModel>.from(parsed.map((item) => BundleModel.fromJson(item)));

  return datas;
}
