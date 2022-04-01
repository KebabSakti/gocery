import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/product/data/model/product_model.dart';
import 'dart:convert';

CartItemModel cartItemModelFromJson(String str) =>
    CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel extends CartItemEntity {
  CartItemModel({
    String? customerAccountUid,
    String? productUid,
    String? uid,
    int? itemQtyTotal,
    String? itemPriceTotal,
    String? note,
    ProductModel? productModel,
  }) : super(
          customerAccountUid: customerAccountUid,
          productUid: productUid,
          uid: uid,
          itemQtyTotal: itemQtyTotal,
          itemPriceTotal: itemPriceTotal,
          note: note,
          productModel: productModel,
        );

  factory CartItemModel.toModel({required CartItemEntity cartItemEntity}) =>
      CartItemModel(
        customerAccountUid: cartItemEntity.customerAccountUid,
        itemPriceTotal: cartItemEntity.itemPriceTotal,
        itemQtyTotal: cartItemEntity.itemQtyTotal,
        note: cartItemEntity.note,
        productUid: cartItemEntity.productUid,
        uid: cartItemEntity.uid,
        productModel: ProductModel.toModel(
            productEntity: cartItemEntity.productModel as ProductModel),
      );

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        customerAccountUid: json["customer_account_uid"],
        productUid: json["product_uid"],
        uid: json["uid"],
        itemQtyTotal: json["item_qty_total"],
        itemPriceTotal: json["item_price_total"],
        note: json["note"],
        productModel: ProductModel.fromJson(json["product_model"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_account_uid": customerAccountUid,
        "product_uid": productUid,
        "uid": uid,
        "item_qty_total": itemQtyTotal,
        "item_price_total": itemPriceTotal,
        "note": note,
        "product_model": (productModel as ProductModel).toJson(),
      };
}
