import 'package:gocery/feature/product/domain/repository/product_repository.dart';

class ToggleFavouriteProduct {
  ToggleFavouriteProduct({required this.repository});

  final ProductRepository repository;

  Future<void> call({required String uid}) async {
    await repository.toggleProductFavourite(uid: uid);
  }
}
