import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_paging_entity.dart';

abstract class CartRepository {
  Future<CartItemPagingEntity> getCartItems();

  Future<void> updateCarts({required List<CartItemEntity> param});

  Future<void> clearCarts();
}
