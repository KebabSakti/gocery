import 'package:gocery/feature/bundle/domain/entity/bundle_entity.dart';
import 'package:gocery/feature/product/data/model/product_model.dart';

import 'dart:convert';

BundleModel bundleModelFromJson(String str) =>
    BundleModel.fromJson(json.decode(str));

String bundleModelToJson(BundleModel data) => json.encode(data.toJson());

class BundleModel extends BundleEntity {
  BundleModel({
    String? uid,
    String? name,
    String? description,
    List<ProductModel>? products,
  }) : super(
          uid: uid,
          name: name,
          description: description,
          products: products,
        );

  BundleModel copyWith({
    String? uid,
    String? name,
    String? description,
    List<ProductModel>? products,
  }) =>
      BundleModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        description: description ?? this.description,
        products: products ?? this.products as List<ProductModel>,
      );

  factory BundleModel.fromJson(Map<String, dynamic> json) => BundleModel(
        uid: json["uid"],
        name: json["name"],
        description: json["description"],
        products: List<ProductModel>.from(
            json["products"].map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "description": description,
        "products": List<ProductModel>.from(
            (products as List<ProductModel>).map((x) => x.toJson())),
      };
}
