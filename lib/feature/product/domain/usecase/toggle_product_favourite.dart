import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/domain/repository/product_repository.dart';

class ToggleFavouriteProduct {
  ToggleFavouriteProduct({required this.repository});

  final ProductRepository repository;

  Future<ProductEntity> call({required String uid}) async {
    return await repository.toggleProductFavourite(uid: uid);
  }
}
