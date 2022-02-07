import 'package:dio/dio.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/feature/bundle/data/datasource/remote/bundle_remote_datasource.dart';
import 'package:gocery/feature/bundle/domain/entity/bundle_entity.dart';
import 'package:gocery/feature/bundle/domain/repository/bundle_repository.dart';

class BundleRepositoryImpl implements BundleRepository {
  BundleRepositoryImpl({required this.remoteDatasource});

  final BundleRemoteDatasource remoteDatasource;

  @override
  Future<List<BundleEntity>> indexBundle() async {
    try {
      return await remoteDatasource.indexBundle();
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
