// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/search/domain/entity/search_entity.dart';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel extends SearchEntity {
  SearchModel({
    String? customerAccountUid,
    String? uid,
    String? keyword,
    int? searchCount,
  }) : super(
          customerAccountUid: customerAccountUid,
          uid: uid,
          keyword: keyword,
          searchCount: searchCount,
        );

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        customerAccountUid: json["customer_account_uid"],
        uid: json["uid"],
        keyword: json["keyword"],
        searchCount: json["search_count"],
      );

  Map<String, dynamic> toJson() => {
        "customer_account_uid": customerAccountUid,
        "uid": uid,
        "keyword": keyword,
        "search_count": searchCount,
      };
}
