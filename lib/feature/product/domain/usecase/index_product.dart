import 'package:gocery/feature/product/domain/entity/product_paging_entity.dart';
import 'package:gocery/feature/product/domain/repository/product_repository.dart';

class IndexProduct {
  IndexProduct({required this.repository});

  final ProductRepository repository;

  Future<ProductPagingEntity> call() async {
    return await repository.indexProduct();
  }
}
