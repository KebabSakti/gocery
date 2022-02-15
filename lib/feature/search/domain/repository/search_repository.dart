import 'package:gocery/feature/search/domain/entity/search_entity.dart';

abstract class SearchRepository {
  Future<List<SearchEntity>> indexSearch();

  Future<List<SearchEntity>> suggestionSearch({required String keyword});

  Future<void> storeSearch({required String keyword});

  Future<void> deleteSearch({required String uid});
}
