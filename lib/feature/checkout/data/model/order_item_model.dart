// To parse this JSON data, do
//
//     final orderItemModel = orderItemModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/checkout/domain/entity/order_item_entity.dart';

OrderItemModel orderItemModelFromJson(String str) =>
    OrderItemModel.fromJson(json.decode(str));

String orderItemModelToJson(OrderItemModel data) => json.encode(data.toJson());

class OrderItemModel extends OrderItemEntity {
  OrderItemModel({
    String? orderUid,
    String? productUid,
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
    int? itemQtyTotal,
    String? itemPriceTotal,
    String? note,
  }) : super(
          orderUid: orderUid,
          productUid: productUid,
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
          itemQtyTotal: itemQtyTotal,
          itemPriceTotal: itemPriceTotal,
          note: note,
        );

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        orderUid: json["order_uid"],
        productUid: json["product_uid"],
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
        itemQtyTotal: json["item_qty_total"],
        itemPriceTotal: json["item_price_total"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "order_uid": orderUid,
        "product_uid": productUid,
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
        "item_qty_total": itemQtyTotal,
        "item_price_total": itemPriceTotal,
        "note": note,
      };
}
