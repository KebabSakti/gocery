import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/domain/repository/product_repository.dart';

class ShowProduct {
  ShowProduct({required this.repository});

  final ProductRepository repository;

  Future<ProductEntity> call({required String uid}) async {
    return await repository.showProduct(uid: uid);
  }
}
