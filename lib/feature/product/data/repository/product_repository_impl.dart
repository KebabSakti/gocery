import 'package:gocery/feature/product/data/datasource/product_datasource.dart';
import 'package:gocery/feature/product/data/model/index_product_param_model.dart';
import 'package:gocery/feature/product/data/model/product_statistic_param.dart';
import 'package:gocery/feature/product/domain/entity/index_product_param_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_paging_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_statistic_param_entity.dart';
import 'package:gocery/feature/product/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.datasource});

  final ProductDatasource datasource;

  @override
  Future<ProductPagingEntity> indexProduct(
      {required IndexProductParamEntity param}) async {
    return await datasource.indexProduct(
      param: IndexProductParamModel(
          page: param.page,
          bundle: param.bundle,
          category: param.category,
          name: param.name,
          shipping: param.shipping,
          sorting: param.sorting),
    );
  }

  @override
  Future<ProductEntity> showProduct({required String uid}) async {
    return await datasource.showProduct(uid: uid);
  }

  @override
  Future<ProductEntity> toggleProductFavourite({required String uid}) async {
    return await datasource.toggleProductFavourite(uid: uid);
  }

  @override
  Future statisticProduct({required ProductStatisticParamEntity param}) async {
    return await datasource.statisticProduct(
        param: ProductStatisticParam(
      productUid: param.productUid,
      target: param.target,
    ));
  }

  @override
  Future<List<ProductEntity>> productViewHistories() async {
    return await datasource.productViewHistories();
  }
}
