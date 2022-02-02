import 'package:gocery/core/service/storage/storage.dart';

abstract class AuthLocalDatasource {
  Future<void> saveAuthToken({required String token});

  Future<void> deleteAuthToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  AuthLocalDatasourceImpl({required this.storage});

  final Storage storage;

  @override
  Future<void> saveAuthToken({required String token}) async {
    await storage.write(key: 'token', value: token);
  }

  @override
  Future<void> deleteAuthToken() async {
    await storage.delete(key: 'token');
  }
}
