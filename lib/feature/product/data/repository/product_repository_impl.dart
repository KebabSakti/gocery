import 'package:dio/dio.dart';
import 'package:gocery/core/service/error/failure.dart';
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
    try {
      return await datasource.indexProduct(
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
      return await datasource.showProduct(uid: uid);
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
  Future<ProductEntity> toggleProductFavourite({required String uid}) async {
    try {
      return await datasource.toggleProductFavourite(uid: uid);
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
  Future statisticProduct({required ProductStatisticParamEntity param}) async {
    try {
      return await datasource.statisticProduct(
          param: ProductStatisticParam(
        productUid: param.productUid,
        target: param.target,
      ));
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
  Future<List<ProductEntity>> productViewHistories() async {
    try {
      return await datasource.productViewHistories();
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
