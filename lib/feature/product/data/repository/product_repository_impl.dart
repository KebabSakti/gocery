import 'package:dio/dio.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/feature/product/data/datasource/remote/product_remote_datasource.dart';
import 'package:gocery/feature/product/data/model/index_product_param_model.dart';
import 'package:gocery/feature/product/domain/entity/index_product_param_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_paging_entity.dart';
import 'package:gocery/feature/product/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.remoteDatasource});

  final ProductRemoteDatasource remoteDatasource;

  @override
  Future<ProductPagingEntity> indexProduct(
      {required IndexProductParamEntity param}) async {
    try {
      return await remoteDatasource.indexProduct(
        param: IndexProductParamModel(
            page: param.page,
            bundle: param.bundle,
            category: param.category,
            name: param.name,
            shipping: param.shipping,
            sorting: param.sorting),
      );
    } catch (e, _) {
      if (e is DioError) {
        if (e.response == null) {
          throw Failure(
              'Koneksi internet bermasalah, cobalah beberapa saat lagi',
              error: e);
        }

        throw Failure(e.message, error: e);
      } else {
        throw Failure('Terjadi kesalahan, harap coba beberapa saat lagi',
            error: e);
      }
    }
  }

  @override
  Future<ProductEntity> showProduct({required String uid}) async {
    try {
      return await remoteDatasource.showProduct(uid: uid);
    } catch (e, _) {
      if (e is DioError) {
        if (e.response == null) {
          throw Failure(
              'Koneksi internet bermasalah, cobalah beberapa saat lagi',
              error: e);
        }

        throw Failure(e.message, error: e);
      } else {
        throw Failure('Terjadi kesalahan, harap coba beberapa saat lagi',
            error: e);
      }
    }
  }
}
