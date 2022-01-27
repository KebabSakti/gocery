import 'package:flutter/cupertino.dart';

class Failure implements Exception {
  final String errorMessage;
  final dynamic error;

  Failure(this.errorMessage, {this.error}) {
    debugPrint('\x1B[32m$error\x1B[0m');
  }

  String get message => errorMessage;

  @override
  String toString() => error.message;
}
