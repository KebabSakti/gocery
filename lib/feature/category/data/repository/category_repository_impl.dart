import 'package:dio/dio.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/feature/category/data/datasource/remote/category_remote_datasource.dart';
import 'package:gocery/feature/category/domain/entity/category_entity.dart';
import 'package:gocery/feature/category/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({required this.remoteDatasource});

  final CategoryRemoteDatasource remoteDatasource;

  @override
  Future<List<CategoryEntity>> indexCategory() async {
    try {
      return await remoteDatasource.index();
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
