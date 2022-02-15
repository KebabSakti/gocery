import 'package:gocery/feature/search/data/datasource/search_datasource.dart';
import 'package:gocery/feature/search/domain/entity/search_entity.dart';
import 'package:gocery/feature/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl({required this.datasource});

  final SearchDatasource datasource;

  @override
  Future<List<SearchEntity>> indexSearch() async {
    return await datasource.indexSearch();
  }

  @override
  Future<List<SearchEntity>> suggestionSearch({required String keyword}) async {
    return await datasource.suggestionSearch(keyword: keyword);
  }

  @override
  Future<void> storeSearch({required String keyword}) async {
    await datasource.storeSearch(keyword: keyword);
  }

  @override
  Future<void> deleteSearch({required String uid}) async {
    await datasource.deleteSearch(uid: uid);
  }
}
