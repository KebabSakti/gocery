import 'package:get/get.dart';
import 'package:gocery/core/service/storage/storage.dart';

abstract class AuthLocalDatasource {
  Future<void> saveAuthToken({required String token});

  Future<void> deleteAuthToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SecureStorageImpl _secureStorage = Get.find();

  @override
  Future<void> saveAuthToken({required String token}) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  @override
  Future<void> deleteAuthToken() async {
    await _secureStorage.delete(key: 'token');
  }
}
