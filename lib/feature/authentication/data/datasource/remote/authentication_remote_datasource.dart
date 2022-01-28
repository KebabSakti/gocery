import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/core/service/storage/storage.dart';
import 'package:gocery/feature/authentication/data/model/authentication_register_param.dart';
import 'package:gocery/feature/authentication/data/model/authentication_model.dart';
import 'package:gocery/feature/authentication/domain/repository/authentication_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationBaseDatasource implements AuthenticationRepository {
  final NetworkImpl _client = Get.find();
  final SecureStorageImpl _secureStorage = Get.find();

  @override
  Future<AuthenticationModel> access({required String token}) async {
    var _response =
        await _client.post('customer/auth/access', data: {'token': token});

    AuthenticationModel _model =
        await compute(authenticationModelFromJson, _response.toString());

    return _model;
  }

  @override
  Future<AuthenticationModel> register(
      {required AuthenticationRegisterParam param}) async {
    var _response = await _client.post('customer/auth/register', data: {
      'name': param.name,
      'email': param.email,
      'phone': param.phone,
    });

    AuthenticationModel _model =
        await compute(authenticationModelFromJson, _response.toString());

    return _model;
  }

  @override
  Future<void> revoke() async {
    await _client.get('customer/auth/revoke');
  }

  @override
  Future<void> saveAuthToken({required String token}) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  @override
  Future<void> deleteAuthToken() async {
    await _secureStorage.delete(key: 'token');
  }
}

class AuthenticationFirebaseDatasource
    implements AuthenticationFirebaseRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<OAuthCredential?> facebookLogin() async {
    final LoginResult loginResult = await _facebookAuth.login(
        loginBehavior: LoginBehavior.nativeWithFallback);

    if (loginResult.accessToken != null) {
      final OAuthCredential _facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      return _facebookAuthCredential;
    }

    return null;
  }

  @override
  Future<OAuthCredential?> googleLogin() async {
    GoogleSignInAccount? _googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? _googleAuth = await _googleUser?.authentication;

    OAuthCredential _googelAuthCredential = GoogleAuthProvider.credential(
      accessToken: _googleAuth?.accessToken,
      idToken: _googleAuth?.idToken,
    );

    return _googelAuthCredential;
  }

  @override
  Future<void> phoneLogin(
    String phone, {
    int? resendToken,
    required PhoneCodeSent codeSent,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String) codeAutoRetrievalTimeout,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      forceResendingToken: resendToken,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      verificationFailed: verificationFailed,
      verificationCompleted: verificationCompleted,
      codeSent: codeSent,
    );
  }

  @override
  Future<UserCredential> signinWithCredential(AuthCredential credential) async {
    return await _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<UserCredential> registerUserFirebase(
      {required AuthenticationRegisterParam param}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: param.email ?? '',
      password: param.password ?? '',
    );
  }

  @override
  void authStateChangeListener(
      {required void Function(User? user) onAuthStateChange}) {
    _firebaseAuth.authStateChanges().listen(onAuthStateChange);
  }

  @override
  Future<void> logout() async {
    await _facebookAuth.logOut();
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
