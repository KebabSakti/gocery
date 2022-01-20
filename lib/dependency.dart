import 'package:get/get.dart';
import 'package:gocery/core/service/network/dio_client.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/core/service/storage/get_storage_client.dart';
import 'package:gocery/core/service/storage/secure_storage_client.dart';
import 'package:gocery/core/service/storage/storage.dart';

class Dependency extends Bindings {
  @override
  void dependencies() {
    //SERVICE
    Get.lazyPut(() => SecureStorageImpl(SecureStorageClient()), fenix: true);
    Get.lazyPut(() => LocalStorageImpl(GetStorageClient()), fenix: true);
    Get.lazyPut(() => NetworkImpl(DioClient()), fenix: true);
  }
}
