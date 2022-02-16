import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';

class CartEntity {
  CartEntity({
    this.customerAccountUid,
    this.uid,
    this.qtyTotal,
    this.priceTotal,
    this.cartItems,
  });

  final String? customerAccountUid;
  final String? uid;
  final int? qtyTotal;
  final String? priceTotal;
  final List<CartItemEntity>? cartItems;

  CartEntity copyWith({
    String? customerAccountUid,
    String? uid,
    int? qtyTotal,
    String? priceTotal,
    List<CartItemEntity>? cartItems,
  }) =>
      CartEntity(
        customerAccountUid: customerAccountUid ?? this.customerAccountUid,
        uid: uid ?? this.uid,
        qtyTotal: qtyTotal ?? this.qtyTotal,
        priceTotal: priceTotal ?? this.priceTotal,
        cartItems: cartItems ?? this.cartItems,
      );
}
