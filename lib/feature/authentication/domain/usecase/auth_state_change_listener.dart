import 'package:gocery/feature/authentication/domain/repository/auth_repository.dart';

class AuthStateChangeListener {
  AuthStateChangeListener({required this.repository});

  final AuthRepository repository;

  void call({required Function(bool) userIsLoggedIn}) {
    repository.authState(userIsLoggedIn: userIsLoggedIn);
  }
}
