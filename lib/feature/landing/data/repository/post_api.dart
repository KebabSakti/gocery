import 'package:gocery/feature/landing/data/datasource/remote/post_remote.dart';
import 'package:gocery/feature/landing/domain/entity/post_entity.dart';
import 'package:gocery/feature/landing/domain/repository/post_repository.dart';

class PostApi implements PostRepository {
  PostApi({required this.postRemote});

  final PostRemote postRemote;

  @override
  Future<PostEntity> getPost() async {
    return await postRemote.getPost();
  }
}
