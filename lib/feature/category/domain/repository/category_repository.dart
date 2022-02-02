import 'package:gocery/feature/category/domain/entity/category_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> indexCategory();
}
