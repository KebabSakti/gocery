import 'package:gocery/core/param/auth_register_param.dart';
import 'package:gocery/feature/authentication/domain/repository/auth_repository.dart';

class RegisterUser {
  RegisterUser({required this.repository});

  final AuthRepository repository;

  Future<void> call({required AuthRegisterParam param}) async {
    await repository.registerUser(param: param);
  }
}
