import 'package:dio/dio.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/feature/product/data/datasource/remote/product_remote_datasource.dart';
import 'package:gocery/feature/product/data/model/product_paging_model.dart';
import 'package:gocery/feature/product/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.remoteDatasource});

  final ProductRemoteDatasource remoteDatasource;

  @override
  Future<ProductPagingModel> indexProduct() async {
    try {
      return await remoteDatasource.indexProduct();
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
