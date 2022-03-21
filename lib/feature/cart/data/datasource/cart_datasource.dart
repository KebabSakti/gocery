import 'package:gocery/feature/cart/data/model/cart_item_model.dart';

abstract class CartDatasource {
  Future<List<CartItemModel>> getCartItems();

  Future<void> updateCart({required List<CartItemModel> param});

  Future<void> clearCart();

  Future<bool> stocks({required List<String> param});
}
