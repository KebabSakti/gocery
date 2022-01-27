import 'package:firebase_auth/firebase_auth.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/feature/authentication/data/model/authentication_model.dart';
import 'package:gocery/feature/authentication/data/repository/authentication_repository_impl.dart';

class GoogleLogin {
  GoogleLogin({required this.repository});

  final AuthenticationRepositoryImpl repository;

  Future<void> call() async {
    try {
      final OAuthCredential? _googleCredential = await repository.googleLogin();

      if (_googleCredential != null) {
        UserCredential _userCredential =
            await repository.signinWithCredential(_googleCredential);

        AuthenticationModel _model = await repository.access(
            token: await _userCredential.user!.getIdToken());

        await repository.saveAuthToken(token: _model.token!);
      }
    } catch (e) {
      throw Failure('Terjadi kesalahan, harap coba beberapa saat lagi',
          error: e);
    }
  }
}
