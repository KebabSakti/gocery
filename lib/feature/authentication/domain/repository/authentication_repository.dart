import 'package:firebase_auth/firebase_auth.dart';
import 'package:gocery/feature/authentication/data/model/authentication_model.dart';
import 'package:gocery/feature/authentication/data/model/authentication_register_param.dart';

abstract class AuthenticationRepository {
  Future<AuthenticationModel> access({required String token});

  Future<AuthenticationModel> register(
      {required AuthenticationRegisterParam param});

  Future<void> revoke();

  Future<void> saveAuthToken({required String token});

  Future<void> deleteAuthToken();
}

abstract class AuthenticationFirebaseRepository {
  Future<UserCredential> signinWithCredential(AuthCredential credential);

  Future<OAuthCredential?> facebookLogin();

  Future<OAuthCredential?> googleLogin();

  Future<void> phoneLogin(
    String phone, {
    int? resendToken,
    required PhoneCodeSent codeSent,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String) codeAutoRetrievalTimeout,
  });

  Future<UserCredential> registerUserFirebase(
      {required AuthenticationRegisterParam param});

  Future<void> logout();

  void authStateChangeListener(
      {required void Function(User? user) onAuthStateChange});
}
