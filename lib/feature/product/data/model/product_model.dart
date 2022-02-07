import 'dart:convert';

import 'package:gocery/feature/product/data/model/product_statistic_model.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel extends ProductEntity {
  ProductModel({
    String? categoryUid,
    String? uid,
    String? name,
    String? description,
    String? image,
    String? price,
    String? discount,
    String? finalPrice,
    String? unit,
    int? unitCount,
    int? minOrder,
    int? maxOrder,
    int? stok,
    int? point,
    String? shipping,
    String? type,
    String? deeplink,
    bool? favourite,
    ProductStatisticModel? productStatisticModel,
  }) : super(
          categoryUid: categoryUid,
          uid: uid,
          name: name,
          description: description,
          image: image,
          price: price,
          discount: discount,
          finalPrice: finalPrice,
          unit: unit,
          unitCount: unitCount,
          minOrder: minOrder,
          maxOrder: maxOrder,
          stok: stok,
          point: point,
          shipping: shipping,
          type: type,
          deeplink: deeplink,
          favourite: favourite,
          productStatisticModel: productStatisticModel,
        );

  ProductModel copyWith({
    String? categoryUid,
    String? uid,
    String? name,
    String? description,
    String? image,
    String? price,
    String? discount,
    String? finalPrice,
    String? unit,
    int? unitCount,
    int? minOrder,
    int? maxOrder,
    int? stok,
    int? point,
    String? shipping,
    String? type,
    String? deeplink,
    bool? favourite,
    ProductStatisticModel? productStatisticModel,
  }) =>
      ProductModel(
        categoryUid: categoryUid ?? this.categoryUid,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        finalPrice: finalPrice ?? this.finalPrice,
        unit: unit ?? this.unit,
        unitCount: unitCount ?? this.unitCount,
        minOrder: minOrder ?? this.minOrder,
        maxOrder: maxOrder ?? this.maxOrder,
        stok: stok ?? this.stok,
        point: point ?? this.point,
        shipping: shipping ?? this.shipping,
        type: type ?? this.type,
        deeplink: deeplink ?? this.deeplink,
        favourite: favourite ?? this.favourite,
        productStatisticModel: productStatisticModel ??
            this.productStatisticModel as ProductStatisticModel,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        categoryUid: json["category_uid"],
        uid: json["uid"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        discount: json["discount"],
        finalPrice: json["final_price"],
        unit: json["unit"],
        unitCount: json["unit_count"],
        minOrder: json["min_order"],
        maxOrder: json["max_order"],
        stok: json["stok"],
        point: json["point"],
        shipping: json["shipping"],
        type: json["type"],
        deeplink: json["deeplink"],
        favourite: json["favourite"],
        productStatisticModel:
            ProductStatisticModel.fromJson(json["product_statistic_model"]),
      );

  Map<String, dynamic> toJson() => {
        "category_uid": categoryUid,
        "uid": uid,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "discount": discount,
        "final_price": finalPrice,
        "unit": unit,
        "unit_count": unitCount,
        "min_order": minOrder,
        "max_order": maxOrder,
        "stok": stok,
        "point": point,
        "shipping": shipping,
        "type": type,
        "deeplink": deeplink,
        "favourite": favourite,
        "product_statistic_model":
            (productStatisticModel as ProductStatisticModel).toJson(),
      };
}
