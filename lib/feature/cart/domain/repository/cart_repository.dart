import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';

abstract class CartRepository {
  Future<List<CartItemEntity>> getCartItems();

  Future<void> updateCart({required List<CartItemEntity> param});

  Future<void> clearCart();
}
