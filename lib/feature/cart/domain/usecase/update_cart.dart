import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/domain/repository/cart_repository.dart';

class UpdateCart {
  UpdateCart({required this.repository});

  final CartRepository repository;

  Future<void> call({required List<CartItemEntity> param}) async {
    await repository.updateCart(param: param);
  }
}
