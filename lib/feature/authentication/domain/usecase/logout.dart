import 'package:gocery/feature/authentication/data/repository/authentication_repository_impl.dart';

class Logout {
  Logout({required this.repository});

  final AuthenticationRepositoryImpl repository;

  Future<void> call() async {
    await repository.base.revoke();

    await repository.base.deleteAuthToken();

    await repository.firebase.logout();
  }
}
