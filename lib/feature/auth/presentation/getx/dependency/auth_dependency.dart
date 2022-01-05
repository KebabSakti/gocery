import 'package:get/get.dart';
import 'package:gocery/feature/auth/data/datasource/mock/auth_mock_datasource.dart';
import 'package:gocery/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:gocery/feature/auth/presentation/getx/controller/auth_controller.dart';

class AuthDependency implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepositoryImpl(AuthMockDatasource()));
    Get.put(AuthController());
  }
}
