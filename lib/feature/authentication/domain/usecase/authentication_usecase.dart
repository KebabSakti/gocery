import 'package:get/get.dart';
import 'package:gocery/feature/authentication/data/repository/auth_repository_impl.dart';
import 'package:gocery/feature/authentication/domain/usecase/facebook_login.dart';
import 'package:gocery/feature/authentication/domain/usecase/google_login.dart';
import 'package:gocery/feature/authentication/domain/usecase/logout.dart';
import 'package:gocery/feature/authentication/domain/usecase/otp_login.dart';
import 'package:gocery/feature/authentication/domain/usecase/phone_login.dart';
import 'package:gocery/feature/authentication/domain/usecase/validate_user.dart';

class AuthenticationUsecase {
  final facebookLogin =
      FacebookLogin(repository: Get.find<AuthRepositoryImpl>());

  final googleLogin = GoogleLogin(repository: Get.find<AuthRepositoryImpl>());

  final phoneLogin = PhoneLogin(repository: Get.find<AuthRepositoryImpl>());

  final otpLogin = OtpLogin(repository: Get.find<AuthRepositoryImpl>());

  final logout = Logout(repository: Get.find<AuthRepositoryImpl>());

  final validateUser = ValidateUser(repository: Get.find<AuthRepositoryImpl>());
}
