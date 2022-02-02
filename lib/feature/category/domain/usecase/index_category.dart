import 'package:gocery/feature/category/domain/entity/category_entity.dart';
import 'package:gocery/feature/category/domain/repository/category_repository.dart';

class IndexCategory {
  IndexCategory({required this.repository});

  final CategoryRepository repository;

  Future<List<CategoryEntity>> call() async {
    return await repository.indexCategory();
  }
}
