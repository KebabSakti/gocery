import 'package:gocery/core/param/auth_phone_login_param.dart';
import 'package:gocery/core/param/auth_register_param.dart';

abstract class AuthRepository {
  Future<void> registerUser({required AuthRegisterParam param});

  Future<void> facebookLogin();

  Future<void> googleLogin();

  Future<void> phoneLogin({
    required AuthPhoneLoginParam param,
    required void Function(Exception e) verificationFailed,
    required void Function(String verificationId, int? resendToken) codeSent,
    required void Function() successCallback,
  });

  Future<void> otpLogin({required AuthPhoneLoginParam param});

  Future<void> logout();

  void authState({required void Function(bool status) userIsLoggedIn});
}
