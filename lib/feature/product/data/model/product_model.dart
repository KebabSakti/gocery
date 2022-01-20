import 'dart:convert';

import 'package:gocery/feature/product/domain/entity/product_entity.dart';

ProductModel authModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel extends ProductEntity {
  ProductModel({
    String? id,
    String? name,
    String? image,
    double? price,
    double? discount,
    String? type,
    bool? favourite,
  }) : super(
          id: id,
          name: name,
          image: image,
          price: price,
          discount: discount,
          type: type,
          favourite: favourite,
        );

  ProductModel copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
    double? discount,
    String? type,
    bool? favourite,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        type: type ?? this.type,
        favourite: favourite ?? this.favourite,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: double.parse(json["price"]),
        discount: double.parse(json["discount"]),
        type: json["type"],
        favourite: json["favourite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price.toString(),
        "discount": discount.toString(),
        "type": type,
        "favourite": favourite,
      };
}
