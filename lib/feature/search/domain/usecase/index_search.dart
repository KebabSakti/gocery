import 'package:gocery/feature/search/domain/entity/search_entity.dart';
import 'package:gocery/feature/search/domain/repository/search_repository.dart';

class IndexSearch {
  IndexSearch({required this.repository});

  final SearchRepository repository;

  Future<List<SearchEntity>> call() async {
    return await repository.indexSearch();
  }
}
