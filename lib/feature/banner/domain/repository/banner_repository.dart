import 'package:gocery/feature/banner/domain/entity/banner_entity.dart';

abstract class BannerRepository {
  Future<List<BannerEntity>> indexBanner();
}
