import 'package:gocery/feature/search/domain/repository/search_repository.dart';

class DeleteSearch {
  DeleteSearch({required this.repository});

  final SearchRepository repository;

  Future<void> call({required String uid}) async {
    await repository.deleteSearch(uid: uid);
  }
}
