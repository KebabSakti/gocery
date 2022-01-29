import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

abstract class AuthenticationFirebaseRepository {
  Future<void> facebookLogin();
}

class AuthenticationRepositoryImpl implements AuthenticationFirebaseRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  @override
  Future<void> facebookLogin() async {
    final LoginResult loginResult = await _facebookAuth.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    final UserCredential userCredential =
        await _signinWithCredential(facebookAuthCredential);

    await _grantAccess(userCredential: userCredential);
  }

  Future<UserCredential> _signinWithCredential(
      AuthCredential credential) async {
    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> _grantAccess({required UserCredential userCredential}) async {}
}
