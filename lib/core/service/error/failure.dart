import 'package:flutter/cupertino.dart';

class Failure implements Exception {
  final String errorMessage;
  final dynamic error;

  Failure(this.errorMessage, {this.error}) {
    debugPrint(error.toString());
  }

  String get message => errorMessage;

  @override
  String toString() => error.message;
}
