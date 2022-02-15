import 'package:gocery/feature/search/domain/repository/search_repository.dart';

class StoreSearch {
  StoreSearch({required this.repository});

  final SearchRepository repository;

  Future<void> call({required String keyword}) async {
    await repository.storeSearch(keyword: keyword);
  }
}
