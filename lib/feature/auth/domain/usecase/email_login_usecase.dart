import 'package:firebase_auth/firebase_auth.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/core/service/storage/storage.dart';
import 'package:gocery/feature/auth/data/model/auth_model.dart';
import 'package:gocery/feature/auth/data/model/auth_param.dart';
import 'package:gocery/feature/auth/data/repository/auth_repository_impl.dart';

class EmailLoginUsecase {
  EmailLoginUsecase(
      {required this.secureStorage, required this.authRepository});

  final SecureStorageImpl secureStorage;
  final AuthRepositoryImpl authRepository;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future emailLogin(UserLoginParam param) async {
    try {
      UserCredential _firebaseUserCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: param.email!,
        password: param.password!,
      );

      AuthModel _authModel =
          await authRepository.login(_firebaseUserCredential.credential?.token);

      await secureStorage.write(
          key: 'user', value: authModelToJson(_authModel));
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          throw Failure('User tidak ditemukan', error: e);
        }

        if (e.code == 'wrong-password') {
          throw Failure('Password yang anda masukkan salah', error: e);
        }

        if (e.code == 'invalid-email') {
          throw Failure('Email yang anda masukkan tidak valid', error: e);
        }

        if (e.code == 'user-disabled') {
          throw Failure(
              'User anda terblokir, harap hubungi layanan kustomer kami',
              error: e);
        }
      }

      throw Failure('Terjadi kesalahan, harap coba beberapa saat lagi',
          error: e);
    }
  }
}
