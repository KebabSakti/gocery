import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/search/data/datasource/search_datasource.dart';
import 'package:gocery/feature/search/data/model/search_model.dart';

class SearchRemoteDatasourceImpl implements SearchDatasource {
  SearchRemoteDatasourceImpl({required this.client});

  final Network client;

  @override
  Future<List<SearchModel>> indexSearch() async {
    final response = await client.get(kSearchIndex);

    final List<SearchModel> model =
        await compute(_searches, response.toString());

    return model;
  }

  @override
  Future<List<SearchModel>> suggestionSearch({required String keyword}) async {
    final response =
        await client.get(kSearchSuggestion, query: {'keyword': keyword});

    final List<SearchModel> model =
        await compute(_searches, response.toString());

    return model;
  }

  @override
  Future<void> storeSearch({required String keyword}) async {
    await client.post(kSearchStore, data: {'keyword': keyword});
  }

  @override
  Future<void> deleteSearch({required String uid}) async {
    await client.delete(kSearchDelete, data: {'uid': uid});
  }
}

List<SearchModel> _searches(dynamic data) {
  var parsed = jsonDecode(data);

  List<SearchModel> datas =
      List<SearchModel>.from(parsed.map((item) => SearchModel.fromJson(item)));

  return datas;
}
