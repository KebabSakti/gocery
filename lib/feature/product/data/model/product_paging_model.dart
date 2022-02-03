import 'dart:convert';

import 'package:gocery/core/model/link_model.dart';
import 'package:gocery/core/model/meta_model.dart';
import 'package:gocery/feature/product/data/model/product_model.dart';
import 'package:gocery/feature/product/domain/entity/product_paging_entity.dart';

ProductPagingModel productPagingModelFromJson(String str) =>
    ProductPagingModel.fromJson(json.decode(str));

String productPagingModelToJson(ProductPagingModel data) =>
    json.encode(data.toJson());

class ProductPagingModel extends ProductPagingEntity {
  ProductPagingModel({
    List<ProductModel>? data,
    LinkModel? links,
    MetaModel? meta,
  }) : super(
          data: data,
          links: links,
          meta: meta,
        );

  ProductPagingModel copyWith({
    List<ProductModel>? data,
    LinkModel? links,
    MetaModel? meta,
  }) =>
      ProductPagingModel(
        data: data ?? this.data as List<ProductModel>,
        links: links ?? this.links as LinkModel,
        meta: meta ?? this.meta as MetaModel,
      );

  factory ProductPagingModel.fromJson(Map<String, dynamic> json) =>
      ProductPagingModel(
        data: List<ProductModel>.from(
            json["data"].map((x) => ProductModel.fromJson(x))),
        links: LinkModel.fromJson(json["links"]),
        meta: MetaModel.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<ProductModel>.from(
            (data as List<ProductModel>).map((x) => x.toJson())),
        "links": (links as LinkModel).toJson(),
        "meta": (meta as MetaModel).toJson(),
      };
}
