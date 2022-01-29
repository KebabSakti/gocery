import 'package:firebase_auth/firebase_auth.dart';
import 'package:gocery/core/param/auth_phone_login_param.dart';
import 'package:gocery/feature/authentication/domain/repository/auth_repository.dart';

class OtpLogin {
  OtpLogin({required this.repository});

  final AuthRepository repository;

  Future<void> call({required AuthPhoneLoginParam param}) async {
    await repository.otpLogin(param: param);
  }
}
