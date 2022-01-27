import 'package:firebase_auth/firebase_auth.dart';
import 'package:gocery/feature/authentication/data/model/authentication_model.dart';
import 'package:gocery/feature/authentication/data/model/authentication_phone_login_param.dart';
import 'package:gocery/feature/authentication/data/repository/authentication_repository_impl.dart';

class OtpLogin {
  OtpLogin({required this.repository});

  final AuthenticationRepositoryImpl repository;

  Future<void> call({required AuthenticationPhoneLoginParam param}) async {
    PhoneAuthCredential _credential = PhoneAuthProvider.credential(
      verificationId: param.verificationId!,
      smsCode: param.otpCode!,
    );

    UserCredential _userCredential =
        await repository.signinWithCredential(_credential);

    AuthenticationModel _model = await repository.access(
        token: await _userCredential.user!.getIdToken());

    await repository.saveAuthToken(token: _model.token!);
  }
}
