import 'package:get/get.dart';
import 'package:gocery/feature/authentication/data/repository/authentication_repository_impl.dart';
import 'package:gocery/feature/authentication/domain/usecase/facebook_login.dart';
import 'package:gocery/feature/authentication/domain/usecase/google_login.dart';
import 'package:gocery/feature/authentication/domain/usecase/otp_login.dart';
import 'package:gocery/feature/authentication/domain/usecase/phone_login.dart';

class AuthenticationUsecase {
  final facebookLogin =
      FacebookLogin(repository: Get.find<AuthenticationRepositoryImpl>());

  final googleLogin =
      GoogleLogin(repository: Get.find<AuthenticationRepositoryImpl>());

  final phoneLogin =
      PhoneLogin(repository: Get.find<AuthenticationRepositoryImpl>());

  final otpLogin =
      OtpLogin(repository: Get.find<AuthenticationRepositoryImpl>());
}
