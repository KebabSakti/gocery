import 'dart:convert';

import 'package:gocery/core/model/link_model.dart';
import 'package:gocery/core/model/meta_model.dart';
import 'package:gocery/feature/cart/data/model/cart_item_model.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_paging_entity.dart';

CartItemPagingModel cartItemPagingModelFromJson(String str) =>
    CartItemPagingModel.fromJson(json.decode(str));

String cartItemPagingModelToJson(CartItemPagingModel data) =>
    json.encode(data.toJson());

class CartItemPagingModel extends CartItemPagingEntity {
  CartItemPagingModel({
    List<CartItemModel>? data,
    LinkModel? links,
    MetaModel? meta,
  }) : super(
          data: data,
          links: links,
          meta: meta,
        );

  factory CartItemPagingModel.fromJson(Map<String, dynamic> json) =>
      CartItemPagingModel(
        data: List<CartItemModel>.from(
            json["data"].map((x) => CartItemModel.fromJson(x))),
        links: LinkModel.fromJson(json["links"]),
        meta: MetaModel.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<CartItemModel>.from(
            (data as List<CartItemModel>).map((x) => x.toJson())),
        "links": (links as LinkModel).toJson(),
        "meta": (meta as MetaModel).toJson(),
      };
}
