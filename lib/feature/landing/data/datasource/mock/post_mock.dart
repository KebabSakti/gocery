import 'package:gocery/feature/landing/domain/entity/post_entity.dart';
import 'package:gocery/feature/landing/domain/repository/post_repository.dart';

class PostMock implements PostRepository {
  @override
  Future<PostEntity> getPost() {
    // TODO: implement getPost
    throw UnimplementedError();
  }
}
