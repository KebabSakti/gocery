import 'dart:convert';

import 'package:gocery/core/entity/meta_entity.dart';

MetaModel metaModelFromJson(String str) => MetaModel.fromJson(json.decode(str));

String metaModelToJson(MetaModel data) => json.encode(data.toJson());

class MetaModel extends MetaEntity {
  MetaModel({
    int? currentPage,
    int? from,
    int? lastPage,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) : super(
          currentPage: currentPage,
          from: from,
          lastPage: lastPage,
          path: path,
          perPage: perPage,
          to: to,
          total: total,
        );

  MetaModel copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) =>
      MetaModel(
        currentPage: currentPage ?? this.currentPage,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}
