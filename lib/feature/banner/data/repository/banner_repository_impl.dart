import 'package:dio/dio.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/feature/banner/data/datasource/remote/banner_remote_datasource.dart';
import 'package:gocery/feature/banner/domain/entity/banner_entity.dart';
import 'package:gocery/feature/banner/domain/repository/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  BannerRepositoryImpl({required this.remoteDatasource});

  final BannerRemoteDatasource remoteDatasource;

  @override
  Future<List<BannerEntity>> indexBanner() async {
    try {
      return await remoteDatasource.indexBanner();
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
