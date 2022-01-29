import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gocery/core/param/auth_phone_login_param.dart';
import 'package:gocery/core/param/auth_register_param.dart';
import 'package:gocery/core/service/error/failure.dart';
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
  Future<void> registerUser({required AuthRegisterParam param}) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: param.email!,
      password: param.password!,
    );

    AuthenticationModel authenticationModel = await remoteDatasource.register(
      param: param.copyWith(
        token: await userCredential.user?.getIdToken(),
      ),
    );

    localDatasource.saveAuthToken(token: authenticationModel.token!);
  }

  @override
  Future<void> facebookLogin() async {
    final LoginResult loginResult = await _facebookAuth.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    final UserCredential userCredential =
        await _signinWithCredential(facebookAuthCredential);

    await _grantAccess(userCredential: userCredential);
  }

  @override
  Future<void> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth == null) {
        throw Exception();
      }

      if (googleAuth.accessToken == null && googleAuth.idToken == null) {
        throw Exception();
      }

      if (googleAuth.accessToken!.isEmpty && googleAuth.idToken!.isEmpty) {
        throw Exception();
      }

      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _signinWithCredential(googleAuthCredential);

      await _grantAccess(userCredential: userCredential);
    } catch (_) {
      throw Failure('');
    }
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
        final UserCredential userCredential =
            await _signinWithCredential(phoneAuthCredential);

        await _grantAccess(userCredential: userCredential);

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

    final UserCredential userCredential =
        await _signinWithCredential(phoneAuthCredential);

    await _grantAccess(userCredential: userCredential);
  }

  @override
  Future<void> logout() async {
    await _facebookAuth.logOut();
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    await remoteDatasource.revoke();
    await localDatasource.deleteAuthToken();
  }

  Future<UserCredential> _signinWithCredential(
      AuthCredential credential) async {
    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> _grantAccess({required UserCredential userCredential}) async {
    final AuthenticationModel model = await remoteDatasource.access(
        token: await userCredential.user!.getIdToken());

    await localDatasource.saveAuthToken(token: model.token!);
  }
}
