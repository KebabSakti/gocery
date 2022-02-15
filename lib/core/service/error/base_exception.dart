import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class BaseException implements Exception {
  final Exception exception;
  final StackTrace stackTrace;

  BaseException(this.exception, this.stackTrace) {
    debugPrint('\x1B[32m$exception\x1B[0m');

    Sentry.captureException(exception, stackTrace: stackTrace);
  }
}
