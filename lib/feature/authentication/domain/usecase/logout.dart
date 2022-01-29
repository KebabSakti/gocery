import 'package:gocery/feature/authentication/domain/repository/auth_repository.dart';

class Logout {
  Logout({required this.repository});

  final AuthRepository repository;

  Future<void> call() async {
    await repository.logout();
  }
}
