import 'package:gocery/feature/todo/model/user/user_param.dart';
import 'package:gocery/feature/todo/model/user/auth_model.dart';
import 'package:gocery/feature/todo/view_model/entity/user/user_entity.dart';

class UserRepository implements UserEntity {
  UserRepository(this.dataSource);

  final UserEntity dataSource;

  @override
  Future<AuthModel> login(UserLoginParam userLoginParam) async {
    return await dataSource.login(userLoginParam);
  }

  @override
  Future<AuthModel> register(UserRegisterParam userRegisterParam) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
