import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gocery/core/service/storage/storage.dart';

class SecureStorageClient extends Storage {
  static const FlutterSecureStorage _flutterSecureStorage =
      FlutterSecureStorage();

  @override
  Future<String?> read({required String key}) async {
    return await _flutterSecureStorage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await _flutterSecureStorage.write(key: key, value: value);
  }

  @override
  Future<void> delete({required String key}) async {
    await _flutterSecureStorage.delete(key: key);
  }

  @override
  Future<void> deleteAll({required String key}) async {
    await _flutterSecureStorage.deleteAll();
  }
}
