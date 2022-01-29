import 'package:gocery/feature/authentication/data/model/authentication_model.dart';
import 'package:gocery/feature/authentication/data/model/authentication_register_param.dart';

abstract class AuthenticationBaseRepository {
  Future<AuthenticationModel> access({required String token});

  Future<AuthenticationModel> register(
      {required AuthenticationRegisterParam param});

  Future<void> revoke();
}
