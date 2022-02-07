import 'package:get/get.dart';
import 'package:gocery/core/service/network/dio_client.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/core/service/storage/secure_storage_client.dart';
import 'package:gocery/core/service/storage/storage.dart';
import 'package:gocery/feature/authentication/data/datasource/local/auth_local_datasource.dart';
import 'package:gocery/feature/authentication/data/datasource/remote/auth_remote_datasource.dart';
import 'package:gocery/feature/authentication/data/repository/auth_repository_impl.dart';
import 'package:gocery/feature/banner/data/datasource/remote/banner_remote_datasource.dart';
import 'package:gocery/feature/banner/data/repository/banner_repository_impl.dart';
import 'package:gocery/feature/bundle/data/datasource/remote/bundle_remote_datasource.dart';
import 'package:gocery/feature/bundle/data/repository/bundle_repository_impl.dart';
import 'package:gocery/feature/category/data/datasource/remote/category_remote_datasource.dart';
import 'package:gocery/feature/category/data/repository/category_repository_impl.dart';
import 'package:gocery/feature/customer/data/datasource/remote/customer_remote_datasource.dart';
import 'package:gocery/feature/customer/data/repository/customer_repository_impl.dart';
import 'package:gocery/feature/product/data/datasource/remote/product_remote_datasource.dart';
import 'package:gocery/feature/product/data/repository/product_repository_impl.dart';

class Dependency extends Bindings {
  @override
  void dependencies() {
    //EXTERNAL SERVICE
    Get.lazyPut(() => SecureStorageImpl(SecureStorageClient()), fenix: true);
    Get.lazyPut(() => NetworkImpl(DioClient()), fenix: true);

    //AUTHENTICATION
    Get.lazyPut(
        () => AuthRepositoryImpl(
              remoteDatasource: AuthRemoteDatasourceImpl(
                client: Get.find<NetworkImpl>(),
              ),
              localDatasource: AuthLocalDatasourceImpl(
                storage: Get.find<SecureStorageImpl>(),
              ),
            ),
        fenix: true);

    //CUSTOMER ACCOUNT
    Get.lazyPut(
        () => CustomerRepositoryImpl(
              remoteDatasource: CustomerRemoteDatasourceImpl(
                client: Get.find<NetworkImpl>(),
              ),
            ),
        fenix: true);

    //CATEGORY
    Get.lazyPut(
        () => CategoryRepositoryImpl(
              remoteDatasource: CategoryRemoteDatasourceImpl(
                client: Get.find<NetworkImpl>(),
              ),
            ),
        fenix: true);

    //BANNER
    Get.lazyPut(
        () => BannerRepositoryImpl(
              remoteDatasource: BannerRemoteDatasourceImpl(
                client: Get.find<NetworkImpl>(),
              ),
            ),
        fenix: true);

    //PRODUCT
    Get.lazyPut(
        () => ProductRepositoryImpl(
              remoteDatasource: ProductRemoteDatasourceImpl(
                client: Get.find<NetworkImpl>(),
              ),
            ),
        fenix: true);

    //BUNDLE
    Get.lazyPut(
        () => BundleRepositoryImpl(
              remoteDatasource: BundleRemoteDatasourceImpl(
                client: Get.find<NetworkImpl>(),
              ),
            ),
        fenix: true);
  }
}
