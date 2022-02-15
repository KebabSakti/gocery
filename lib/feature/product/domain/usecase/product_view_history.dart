import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/domain/repository/product_repository.dart';

class ProductViewHistory {
  ProductViewHistory({required this.repository});

  final ProductRepository repository;

  Future<List<ProductEntity>> call() async {
    return await repository.productViewHistories();
  }
}
