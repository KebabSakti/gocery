import 'package:gocery/feature/cart/domain/repository/cart_repository.dart';

class CartStock {
  final CartRepository repository;

  CartStock({required this.repository});

  Future<bool> call({required List<String> param}) async {
    return await repository.stocks(param: param);
  }
}
