import 'package:gocery/feature/cart/data/datasource/cart_datasource.dart';
import 'package:gocery/feature/cart/data/model/cart_item_model.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({required this.datasource});

  final CartDatasource datasource;

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    return await datasource.getCartItems();
  }

  @override
  Future<void> updateCart({required List<CartItemEntity> param}) async {
    return await datasource.updateCart(param: param as List<CartItemModel>);
  }

  @override
  Future<void> clearCart() async {
    return await datasource.clearCart();
  }

  @override
  Future<bool> stocks({required List<String> param}) async {
    return await datasource.stocks(param: param);
  }
}
