import 'package:gocery/feature/cart/data/datasource/cart_datasource.dart';
import 'package:gocery/feature/cart/data/model/cart_item_model.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_paging_entity.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({required this.datasource});

  final CartDatasource datasource;

  @override
  Future<CartItemPagingEntity> getCartItems() async {
    return await datasource.getCartItems();
  }

  @override
  Future<void> updateCarts({required List<CartItemEntity> param}) async {
    return await datasource.updateCarts(param: param as List<CartItemModel>);
  }

  @override
  Future<void> clearCarts() async {
    return await datasource.clearCarts();
  }
}
