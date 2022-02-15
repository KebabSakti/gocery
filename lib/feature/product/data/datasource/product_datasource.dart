import 'package:gocery/feature/product/data/model/index_product_param_model.dart';
import 'package:gocery/feature/product/data/model/product_model.dart';
import 'package:gocery/feature/product/data/model/product_paging_model.dart';
import 'package:gocery/feature/product/data/model/product_statistic_param.dart';

abstract class ProductDatasource {
  Future<ProductPagingModel> indexProduct(
      {required IndexProductParamModel param});

  Future<ProductModel> showProduct({required String uid});

  Future<ProductModel> toggleProductFavourite({required String uid});

  Future statisticProduct({required ProductStatisticParam param});

  Future<List<ProductModel>> productViewHistories();
}
