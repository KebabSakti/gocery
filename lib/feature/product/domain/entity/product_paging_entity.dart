import 'package:gocery/core/entity/link_entity.dart';
import 'package:gocery/core/entity/meta_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';

class ProductPagingEntity {
  ProductPagingEntity({
    this.data,
    this.links,
    this.meta,
  });

  final List<ProductEntity>? data;
  final LinkEntity? links;
  final MetaEntity? meta;
}
