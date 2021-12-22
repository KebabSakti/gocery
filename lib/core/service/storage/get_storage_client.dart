import 'package:get_storage/get_storage.dart';
import 'package:gocery/core/service/storage/storage.dart';

class GetStorageClient extends Storage {
  Future<GetStorage> _init() async {
    await GetStorage.init();

    return GetStorage();
  }

  @override
  Future read({required String key}) async {
    return await _init().then((instance) async => await instance.read(key));
  }

  @override
  Future<void> write({required String key, required String value}) async {
    return await _init()
        .then((instance) async => await instance.write(key, value));
  }

  @override
  Future<void> delete({required String key}) async {
    return await _init().then((instance) async => await instance.remove(key));
  }

  @override
  Future<void> deleteAll({required String key}) async {
    return await _init().then((instance) async => await instance.erase());
  }
}
