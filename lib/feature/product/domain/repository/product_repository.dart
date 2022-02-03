import 'package:gocery/feature/product/domain/entity/product_paging_entity.dart';

abstract class ProductRepository {
  Future<ProductPagingEntity> indexProduct();
}
