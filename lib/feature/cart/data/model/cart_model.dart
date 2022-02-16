import 'dart:convert';

import 'package:gocery/feature/cart/data/model/cart_item_model.dart';
import 'package:gocery/feature/cart/domain/entity/cart_entity.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel extends CartEntity {
  CartModel({
    String? customerAccountUid,
    String? uid,
    int? qtyTotal,
    String? priceTotal,
    List<CartItemModel>? cartItems,
  }) : super(
          customerAccountUid: customerAccountUid,
          uid: uid,
          qtyTotal: qtyTotal,
          priceTotal: priceTotal,
          cartItems: cartItems,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        customerAccountUid: json["customer_account_uid"],
        uid: json["uid"],
        qtyTotal: json["qty_total"],
        priceTotal: json["price_total"],
        cartItems: List<CartItemModel>.from(json["cart_items"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "customer_account_uid": customerAccountUid,
        "uid": uid,
        "qty_total": qtyTotal,
        "price_total": priceTotal,
        "cart_items": List<CartItemModel>.from(
            (cartItems as List<CartItemModel>).map((x) => x)),
      };
}
