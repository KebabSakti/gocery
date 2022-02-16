import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/domain/repository/cart_repository.dart';

class GetCartItem {
  GetCartItem({required this.repository});

  final CartRepository repository;

  Future<List<CartItemEntity>> call() async {
    return await repository.getCartItems();
  }
}
