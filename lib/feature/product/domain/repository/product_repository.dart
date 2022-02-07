import 'package:gocery/feature/product/domain/entity/index_product_param_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_paging_entity.dart';

abstract class ProductRepository {
  Future<ProductPagingEntity> indexProduct(
      {required IndexProductParamEntity param});

  Future<ProductEntity> showProduct({required String uid});
}
