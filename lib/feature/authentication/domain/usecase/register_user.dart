import 'package:gocery/feature/authentication/data/model/authentication_register_param.dart';
import 'package:gocery/feature/authentication/data/repository/authentication_repository_impl.dart';

class RegisterUser {
  RegisterUser({required this.repository});

  final AuthenticationRepositoryImpl repository;

  Future<void> call({required AuthenticationRegisterParam param}) async {}
}
