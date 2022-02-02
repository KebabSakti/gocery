import 'package:gocery/feature/banner/domain/entity/banner_entity.dart';
import 'package:gocery/feature/banner/domain/repository/banner_repository.dart';

class IndexBanner {
  IndexBanner({required this.repository});

  final BannerRepository repository;

  Future<List<BannerEntity>> call() async {
    return await repository.indexBanner();
  }
}
