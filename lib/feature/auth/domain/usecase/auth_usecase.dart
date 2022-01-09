import 'package:get/get.dart';
import 'package:gocery/core/service/storage/storage.dart';
import 'package:gocery/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:gocery/feature/auth/domain/usecase/email_login_usecase.dart';

class AuthUsecase {
  static final emailLogin = EmailLoginUsecase(
    secureStorage: Get.find<SecureStorageImpl>(),
    authRepository: Get.find<AuthRepositoryImpl>(),
  );
}
