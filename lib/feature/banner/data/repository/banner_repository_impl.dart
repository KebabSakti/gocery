import 'package:gocery/feature/banner/data/datasource/remote/banner_remote_datasource.dart';
import 'package:gocery/feature/banner/domain/entity/banner_entity.dart';
import 'package:gocery/feature/banner/domain/repository/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  BannerRepositoryImpl({required this.remoteDatasource});

  final BannerRemoteDatasource remoteDatasource;

  @override
  Future<List<BannerEntity>> indexBanner() async {
    return await remoteDatasource.indexBanner();
  }
}
