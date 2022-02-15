import 'package:gocery/feature/cart/data/model/cart_item_model.dart';
import 'package:gocery/feature/cart/data/model/cart_item_paging_model.dart';

abstract class CartDatasource {
  Future<CartItemPagingModel> getCartItems();

  Future<void> updateCarts({required List<CartItemModel> param});

  Future<void> clearCarts();
}
