import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gocery/core/service/error/auth_exception.dart';
import 'package:gocery/core/service/error/business_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gocery/core/param/auth_phone_login_param.dart';
import 'package:gocery/feature/authentication/data/datasource/local/auth_local_datasource.dart';
import 'package:gocery/feature/authentication/data/datasource/remote/auth_remote_datasource.dart';
import 'package:gocery/feature/authentication/data/model/authentication_model.dart';
import 'package:gocery/feature/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<void> facebookLogin() async {
    final LoginResult loginResult = await _facebookAuth.login();

    if (loginResult.accessToken == null) {
      throw LoginProviderNotSelected();
    }

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    await _grantUserAccess(credential: facebookAuthCredential);
  }

  @override
  Future<void> googleLogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth == null) {
      throw LoginProviderNotSelected();
    }

    final googleAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _grantUserAccess(credential: googleAuthCredential);
  }

  @override
  Future<void> phoneLogin({
    required AuthPhoneLoginParam param,
    required void Function(Exception e) verificationFailed,
    required void Function(String verificationId, int? resendToken) codeSent,
    required void Function() successCallback,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: param.phoneNumber!,
      forceResendingToken: param.resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        await _grantUserAccess(credential: phoneAuthCredential);

        successCallback();
      },
      verificationFailed: verificationFailed,
      codeSent: codeSent,
    );
  }

  @override
  Future<void> otpLogin({required AuthPhoneLoginParam param}) async {
    final PhoneAuthCredential phoneAuthCredential =
        PhoneAuthProvider.credential(
      verificationId: param.verificationId!,
      smsCode: param.otpCode!,
    );

    await _grantUserAccess(credential: phoneAuthCredential);
  }

  @override
  Future<void> validateUser() async {
    final AuthenticationModel model = await remoteDatasource.access(
        token: await _firebaseAuth.currentUser!.getIdToken());

    await localDatasource.saveAuthToken(token: model.token!);
  }

  @override
  Future<void> logout() async {
    await _facebookAuth.logOut();
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    await remoteDatasource.revoke();
    await localDatasource.deleteAuthToken();
  }

  Future<void> _grantUserAccess({required AuthCredential credential}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final AuthenticationModel model = await remoteDatasource.access(
          token: await userCredential.user!.getIdToken());

      await localDatasource.saveAuthToken(token: model.token!);
    } on FirebaseAuthException catch (e, s) {
      throw AuthException(e, s);
    }
  }
}
