import 'package:get/get.dart';
import 'package:gocery/core/service/network/dio_client.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/core/service/storage/get_storage_client.dart';
import 'package:gocery/core/service/storage/secure_storage_client.dart';
import 'package:gocery/core/service/storage/storage.dart';

class Dependency extends Bindings {
  @override
  void dependencies() {
    //do not change the load order of dependency, executed from top to bottom
    Get.lazyPut(() => SecureStorageImpl(SecureStorageClient()));
    Get.lazyPut(() => LocalStorageImpl(GetStorageClient()));
    Get.lazyPut(() => NetworkImpl(DioClient()));
  }
}
