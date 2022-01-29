import 'package:gocery/feature/authentication/data/model/authentication_register_param.dart';
import 'package:gocery/feature/authentication/domain/repository/auth_repository.dart';

class RegisterUser {
  RegisterUser({required this.repository});

  final AuthRepository repository;

  Future<void> call({required AuthenticationRegisterParam param}) async {}
}
