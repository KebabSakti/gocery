import 'package:gocery/feature/bundle/domain/entity/bundle_entity.dart';

abstract class BundleRepository {
  Future<List<BundleEntity>> indexBundle();
}
