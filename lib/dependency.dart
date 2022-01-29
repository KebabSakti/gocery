import 'package:get/get.dart';
import 'package:gocery/core/service/network/dio_client.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/core/service/storage/get_storage_client.dart';
import 'package:gocery/core/service/storage/secure_storage_client.dart';
import 'package:gocery/core/service/storage/storage.dart';
import 'package:gocery/feature/authentication/data/datasource/local/auth_local_datasource.dart';
import 'package:gocery/feature/authentication/data/datasource/remote/auth_remote_datasource.dart';
import 'package:gocery/feature/authentication/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:gocery/feature/authentication/data/repository/auth_repository_impl.dart';
import 'package:gocery/feature/authentication/data/repository/authentication_repository_impl.dart';

class Dependency extends Bindings {
  @override
  void dependencies() {
    //SERVICE
    Get.lazyPut(() => SecureStorageImpl(SecureStorageClient()), fenix: true);
    Get.lazyPut(() => LocalStorageImpl(GetStorageClient()), fenix: true);
    Get.lazyPut(() => NetworkImpl(DioClient()), fenix: true);

    //AUTHENTICATION
    Get.lazyPut(() => AuthenticationRepositoryImpl(
          base: AuthenticationBaseDatasource(),
          firebase: AuthenticationFirebaseDatasource(),
        ));

    Get.lazyPut(() => AuthRepositoryImpl(
          remoteDatasource: AuthRemoteDatasourceImpl(),
          localDatasource: AuthLocalDatasourceImpl(),
        ));
  }
}
