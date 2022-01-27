import 'package:firebase_auth/firebase_auth.dart';
import 'package:gocery/feature/authentication/data/model/authentication_register_param.dart';
import 'package:gocery/feature/authentication/data/model/authentication_model.dart';
import 'package:gocery/feature/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl
    implements AuthenticationRepository, AuthenticationFirebaseRepository {
  final AuthenticationRepository base;
  final AuthenticationFirebaseRepository firebase;

  AuthenticationRepositoryImpl({
    required this.base,
    required this.firebase,
  });

  @override
  Future<AuthenticationModel> access({required String token}) async {
    return await base.access(token: token);
  }

  @override
  Future<AuthenticationModel> register(
      {required AuthenticationRegisterParam param}) async {
    return await base.register(param: param);
  }

  @override
  Future<void> revoke() async {
    await base.revoke();
  }

  @override
  Future<void> saveAuthToken({required String token}) async {
    await base.saveAuthToken(token: token);
  }

  @override
  Future<OAuthCredential?> facebookLogin() async {
    return await firebase.facebookLogin();
  }

  @override
  Future<OAuthCredential?> googleLogin() async {
    return await firebase.googleLogin();
  }

  @override
  Future<void> phoneLogin(
    String phone, {
    int? resendToken,
    required PhoneCodeSent codeSent,
    required void Function(PhoneAuthCredential p1) verificationCompleted,
    required void Function(FirebaseAuthException p1) verificationFailed,
    required void Function(String p1) codeAutoRetrievalTimeout,
  }) async {
    await firebase.phoneLogin(
      phone,
      codeSent: codeSent,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Future<UserCredential> signinWithCredential(AuthCredential credential) async {
    return await firebase.signinWithCredential(credential);
  }

  @override
  Future<UserCredential> registerUserFirebase(
      {required AuthenticationRegisterParam param}) async {
    return await firebase.registerUserFirebase(param: param);
  }

  @override
  void authStateChangeListener(
      {required void Function(User? user) onAuthStateChange}) {
    firebase.authStateChangeListener(onAuthStateChange: onAuthStateChange);
  }
}
