import 'package:firebase_auth/firebase_auth.dart';
import 'package:gocery/core/service/error/base_exception.dart';
import 'package:gocery/core/service/error/business_exception.dart';

class AuthException extends BaseException {
  AuthException(FirebaseAuthException exception, StackTrace stackTrace)
      : super(exception, stackTrace) {
    switch (exception.code) {
      case 'user-disabled':
        throw UserDisabled();

      case 'invalid-verification-code':
        throw InvalidOtpCode();

      case 'invalid-phone-number':
        throw InvalidPhoneNumber();
    }
  }
}
