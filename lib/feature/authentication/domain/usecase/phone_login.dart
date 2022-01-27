import 'package:firebase_auth/firebase_auth.dart';
import 'package:gocery/feature/authentication/data/model/authentication_model.dart';
import 'package:gocery/feature/authentication/data/model/authentication_phone_login_param.dart';
import 'package:gocery/feature/authentication/data/repository/authentication_repository_impl.dart';

class PhoneLogin {
  PhoneLogin({required this.repository});

  final AuthenticationRepositoryImpl repository;

  Future<void> call({
    required AuthenticationPhoneLoginParam param,
    required void Function() completeCallback,
    required void Function(String, int?) codeSent,
    required void Function(Exception) verificationFailed,
  }) async {
    if (param.phoneNumber != null) {
      await repository.phoneLogin(
        param.phoneNumber!,
        resendToken: param.resendToken,
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            UserCredential _userCredential =
                await repository.signinWithCredential(credential);

            AuthenticationModel _model = await repository.access(
                token: await _userCredential.user!.getIdToken());

            await repository.saveAuthToken(token: _model.token!);

            completeCallback();
          } on Exception catch (e) {
            verificationFailed(e);
          }
        },
      );
    }
  }
}
