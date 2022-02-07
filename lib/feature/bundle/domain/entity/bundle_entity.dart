import 'package:gocery/feature/product/domain/entity/product_entity.dart';

class BundleEntity {
  BundleEntity({
    this.uid,
    this.name,
    this.description,
    this.products,
  });

  final String? uid;
  final String? name;
  final String? description;
  final List<ProductEntity>? products;
}
