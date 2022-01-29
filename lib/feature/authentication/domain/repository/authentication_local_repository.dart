abstract class AuthenticationLocalRepository {
  Future<void> saveAuthToken({required String token});

  Future<void> deleteAuthToken();
}
