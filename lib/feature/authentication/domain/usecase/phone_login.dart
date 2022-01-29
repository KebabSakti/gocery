import 'package:gocery/core/param/auth_phone_login_param.dart';
import 'package:gocery/feature/authentication/domain/repository/auth_repository.dart';

class PhoneLogin {
  PhoneLogin({required this.repository});

  final AuthRepository repository;

  Future<void> call({
    required AuthPhoneLoginParam param,
    required void Function(Exception e) verificationFailed,
    required void Function(String verificationId, int? resendToken) codeSent,
    required void Function() successCallback,
  }) async {
    await repository.phoneLogin(
      param: param,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      successCallback: successCallback,
    );
  }
}
