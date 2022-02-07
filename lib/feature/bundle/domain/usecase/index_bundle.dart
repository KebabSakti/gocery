import 'package:gocery/feature/bundle/domain/entity/bundle_entity.dart';
import 'package:gocery/feature/bundle/domain/repository/bundle_repository.dart';

class IndexBundle {
  IndexBundle({required this.repository});

  final BundleRepository repository;

  Future<List<BundleEntity>> call() async {
    return await repository.indexBundle();
  }
}
