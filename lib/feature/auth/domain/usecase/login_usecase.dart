import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/core/service/storage/storage.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/auth/data/model/auth_model.dart';
import 'package:gocery/feature/auth/data/model/auth_param.dart';
import 'package:gocery/feature/auth/data/repository/auth_repository_impl.dart';

class LoginUsecase {
  LoginUsecase({required this.secureStorage, required this.authRepository});

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
          await grantAccessToken(_firebaseUserCredential.credential?.token);

      await saveUserToSecureLocalStorage(_authModel);
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

  Future phoneLogin(
    String phone, {
    int? resendToken,
    required PhoneCodeSent codeSent,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      forceResendingToken: resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationFailed: (FirebaseAuthException e) {
        MDialog.close();

        if (e.code == 'invalid-phone-number') {
          MToast.show('Nomor hp tidak valid');
        } else {
          MToast.show('Terjadi kesalahan, harap coba beberapa saat lagi');
        }
      },
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          UserCredential _firebaseUserCredential =
              await signInWithCredential(credential);

          AuthModel _authModel =
              await grantAccessToken(_firebaseUserCredential.credential?.token);

          await saveUserToSecureLocalStorage(_authModel);
        } on Failure catch (e) {
          MDialog.close();

          MToast.show(e.message);
        }
      },
      codeSent: codeSent,
    );
  }

  Future facebookLogin() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance
          .login(loginBehavior: LoginBehavior.nativeWithFallback);

      if (loginResult.accessToken != null) {
        final OAuthCredential _facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        UserCredential _firebaseUserCredential =
            await signInWithCredential(_facebookAuthCredential);

        AuthModel _authModel =
            await grantAccessToken(_firebaseUserCredential.credential?.token);

        await saveUserToSecureLocalStorage(_authModel);
      }
    } catch (e) {
      throw Failure('Terjadi kesalahan, harap coba beberapa saat lagi',
          error: e);
    }
  }

  Future googleLogin() async {
    try {
      GoogleSignInAccount? _googleUser = await GoogleSignIn().signIn();

      GoogleSignInAuthentication? _googleAuth =
          await _googleUser?.authentication;

      OAuthCredential _googelAuthCredential = GoogleAuthProvider.credential(
        accessToken: _googleAuth?.accessToken,
        idToken: _googleAuth?.idToken,
      );

      UserCredential _firebaseUserCredential =
          await signInWithCredential(_googelAuthCredential);

      AuthModel _authModel =
          await grantAccessToken(_firebaseUserCredential.credential?.token);

      await saveUserToSecureLocalStorage(_authModel);
    } catch (e) {
      throw Failure('Terjadi kesalahan, harap coba beberapa saat lagi',
          error: e);
    }
  }

  Future saveUserToSecureLocalStorage(AuthModel authModel) async {
    await secureStorage.write(key: 'user', value: authModelToJson(authModel));
  }

  Future<AuthModel> grantAccessToken(int? firebaseToken) async {
    try {
      return await authRepository.login(firebaseToken);
    } catch (e) {
      throw Failure('Terjadi kesalahan, harap coba beberapa saat lagi',
          error: e);
    }
  }

  Future<UserCredential> signInWithCredential(AuthCredential credential) async {
    try {
      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-disabled') {
          throw Failure(
              'User anda terblokir, harap hubungi layanan kustomer kami',
              error: e);
        }

        if (e.code == 'invalid-verification-code') {
          throw Failure('Kode OTP yang anda masukkan salah', error: e);
        }
      }

      throw Failure('Terjadi kesalahan, harap coba beberapa saat lagi',
          error: e);
    }
  }
}
