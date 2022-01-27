import 'package:gocery/feature/authentication/domain/repository/authentication_repository.dart';

class SaveAuthenticationToken {
  SaveAuthenticationToken({required this.repository});

  final AuthenticationRepository repository;

  Future call({required String token}) async {
    await repository.saveAuthToken(token: token);
  }
}
