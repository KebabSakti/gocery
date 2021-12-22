import 'package:gocery/feature/todo/model/user/auth_model.dart';
import 'package:gocery/feature/todo/model/user/user_param.dart';

abstract class UserEntity {
  Future<AuthModel> register(UserRegisterParam userRegisterParam);

  Future<AuthModel> login(UserLoginParam userLoginParam);
}
