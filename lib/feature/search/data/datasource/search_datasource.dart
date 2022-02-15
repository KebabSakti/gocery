import 'package:gocery/feature/search/data/model/search_model.dart';

abstract class SearchDatasource {
  Future<List<SearchModel>> indexSearch();

  Future<List<SearchModel>> suggestionSearch({required String keyword});

  Future<void> storeSearch({required String keyword});

  Future<void> deleteSearch({required String uid});
}
