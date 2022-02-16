import 'package:gocery/feature/cart/domain/repository/cart_repository.dart';

class ClearCart {
  ClearCart({required this.repository});

  final CartRepository repository;

  Future<void> call() async {
    await repository.clearCart();
  }
}
