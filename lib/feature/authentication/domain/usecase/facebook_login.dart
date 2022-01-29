import 'package:gocery/feature/authentication/data/repository/authentication_repository_impl.dart';
import 'package:gocery/feature/authentication/domain/repository/auth_repository.dart';

class FacebookLogin {
  FacebookLogin({required this.repository});

  final AuthRepository repository;

  Future<void> call() async {
    await repository.facebookLogin();
  }
}
