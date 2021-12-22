import 'package:gocery/feature/landing/domain/entity/post_entity.dart';

abstract class PostRepository {
  Future<PostEntity> getPost();
}
