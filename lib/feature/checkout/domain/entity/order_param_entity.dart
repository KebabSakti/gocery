import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';

class OrderParamEntity {
  OrderParamEntity({
    this.clearCart,
    this.cartItems,
  });

  bool? clearCart;
  List<CartItemEntity>? cartItems;
}
