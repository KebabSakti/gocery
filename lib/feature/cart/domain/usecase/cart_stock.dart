import 'package:gocery/feature/cart/domain/repository/cart_repository.dart';

class CartStock {
  final CartRepository repository;

  CartStock({required this.repository});

  Future<void> call({required List<String> param}) async {
    await repository.stocks(param: param);
  }
}
