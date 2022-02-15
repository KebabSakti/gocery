import 'package:gocery/feature/category/data/datasource/remote/category_remote_datasource.dart';
import 'package:gocery/feature/category/domain/entity/category_entity.dart';
import 'package:gocery/feature/category/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({required this.remoteDatasource});

  final CategoryRemoteDatasource remoteDatasource;

  @override
  Future<List<CategoryEntity>> indexCategory() async {
    return await remoteDatasource.index();
  }
}
