import 'package:gocery/feature/search/domain/entity/search_entity.dart';
import 'package:gocery/feature/search/domain/repository/search_repository.dart';

class SuggestionSearch {
  SuggestionSearch({required this.repository});

  final SearchRepository repository;

  Future<List<SearchEntity>> call({required String keyword}) async {
    return await repository.suggestionSearch(keyword: keyword);
  }
}
