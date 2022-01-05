import 'package:gocery/feature/auth/data/model/auth_model.dart';
import 'package:gocery/feature/auth/data/model/auth_param.dart';

abstract class AuthRepository {
  Future<AuthModel> register(UserRegisterParam userRegisterParam);

  Future<AuthModel> login(int? firebaseToken);

  Future<bool> forgotPassword(String email);
}
